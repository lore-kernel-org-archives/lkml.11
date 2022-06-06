Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 169F8C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jun 2022 08:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbiFFIXW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jun 2022 04:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbiFFIXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 04:23:18 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E6110C8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 01:23:15 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VFUVkL4_1654503791;
Received: from localhost(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VFUVkL4_1654503791)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 06 Jun 2022 16:23:12 +0800
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, wangkefeng.wang@huawei.com,
        philipp.tomsich@vrull.eu, ebiederm@xmission.com, heiko@sntech.de,
        vitaly.wool@konsulko.com, tongtiangen@huawei.com, guoren@kernel.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [RESEND PATCH v2] RISC-V: Add fast call path of crash_kexec()
Date:   Mon,  6 Jun 2022 16:23:08 +0800
Message-Id: <20220606082308.2883458-1-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, almost all archs (x86, arm64, mips...) support fast call
of crash_kexec() when "regs && kexec_should_crash()" is true. But
RISC-V not, it can only enter crash system via panic(). However panic()
doesn't pass the regs of the real accident scene to crash_kexec(),
it caused we can't get accurate backtrace via gdb,
	$ riscv64-linux-gnu-gdb vmlinux vmcore
	Reading symbols from vmlinux...
	[New LWP 95]
	#0  console_unlock () at kernel/printk/printk.c:2557
	2557                    if (do_cond_resched)
	(gdb) bt
	#0  console_unlock () at kernel/printk/printk.c:2557
	#1  0x0000000000000000 in ?? ()

With the patch we can get the accurate backtrace,
	$ riscv64-linux-gnu-gdb vmlinux vmcore
	Reading symbols from vmlinux...
	[New LWP 95]
	#0  0xffffffe00063a4e0 in test_thread (data=<optimized out>) at drivers/test_crash.c:81
	81             *(int *)p = 0xdead;
	(gdb)
	(gdb) bt
	#0  0xffffffe00064d5c0 in test_thread (data=<optimized out>) at drivers/test_crash.c:81
	#1  0x0000000000000000 in ?? ()

Test code to produce NULL address dereference in test_crash.c,
	void *p = NULL;
	*(int *)p = 0xdead;

Reviewed-by: Guo Ren <guoren@kernel.org>
Tested-by: Xianting Tian <xianting.tian@linux.alibaba.com>
Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
---
Changes from v1:
- simplify the commit message
---
 arch/riscv/kernel/traps.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index fe92e119e6a3..e666ebfa2a64 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -16,6 +16,7 @@
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/irq.h>
+#include <linux/kexec.h>
 
 #include <asm/asm-prototypes.h>
 #include <asm/bug.h>
@@ -44,6 +45,9 @@ void die(struct pt_regs *regs, const char *str)
 
 	ret = notify_die(DIE_OOPS, str, regs, 0, regs->cause, SIGSEGV);
 
+	if (regs && kexec_should_crash(current))
+		crash_kexec(regs);
+
 	bust_spinlocks(0);
 	add_taint(TAINT_DIE, LOCKDEP_NOW_UNRELIABLE);
 	spin_unlock_irq(&die_lock);
-- 
2.17.1

