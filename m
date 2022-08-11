Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DDAC25B07
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Aug 2022 07:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbiHKHmD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Aug 2022 03:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234306AbiHKHmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 03:42:01 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C64D8E0F4;
        Thu, 11 Aug 2022 00:41:59 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0VLyDAKe_1660203712;
Received: from localhost(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VLyDAKe_1660203712)
          by smtp.aliyun-inc.com;
          Thu, 11 Aug 2022 15:41:53 +0800
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, anup@brainfault.org, heiko@sntech.de,
        guoren@kernel.org, mick@ics.forth.gr,
        alexandre.ghiti@canonical.com, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, corbet@lwn.net, Conor.Dooley@microchip.com
Cc:     kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        crash-utility@redhat.com, heinrich.schuchardt@canonical.com,
        k-hagio-ab@nec.com, hschauhan@nulltrace.org, yixun.lan@gmail.com,
        Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [PATCH V6 0/6] RISC-V fixups to work with crash tool
Date:   Thu, 11 Aug 2022 15:41:44 +0800
Message-Id: <20220811074150.3020189-1-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I ever sent the patch 1 in the link:
https://patchwork.kernel.org/project/linux-riscv/patch/20220708073150.352830-3-xianting.tian@linux.alibaba.com/
And patch 2,3 in the link:
https://patchwork.kernel.org/project/linux-riscv/patch/20220714113300.367854-2-xianting.tian@linux.alibaba.com/
https://patchwork.kernel.org/project/linux-riscv/patch/20220714113300.367854-3-xianting.tian@linux.alibaba.com/

This patch set just put these patches together, and with three new patch 4, 5, 6.
these six patches are the fixups for machine_kexec, kernel mode PC for vmcore
and improvements for vmcoreinfo, memory layout dump and fixup schedule out issue
in machine_crash_shutdown().

The main changes in the six patchs as below,
Patch 1: Fixup use of smp_processor_id() in preemptible context, to cleanup
         the console prints.
Patch 2: Fixup to get correct kernel mode PC for kernel mode regs for vmcore.
Patch 3: Fixup schedule out issue in machine_crash_shutdown()
Patch 4: Add modules to virtual kernel memory layout dump.
Patch 5: Add VM layout, va bits, ram base to vmcoreinfo, which can simplify
         the development of crash tool as ARM64 already did
         (arch/arm64/kernel/crash_core.c).
Patch 6: Updates vmcoreinfo.rst for vmcoreinfo export for RISCV64.

With these six patches(patch 2 is must), crash tool can work well to analyze
a vmcore. The patches for crash tool for RISCV64 is in the link:
https://lore.kernel.org/linux-riscv/20220801043040.2003264-1-xianting.tian@linux.alibaba.com/

------
Changes v1 -> v2:
  1, remove the patch "Add a fast call path of crash_kexec()" from this series
     of patches, as it already applied to riscv git.
     https://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git/commit/?h=for-next&id=3f1901110a89b0e2e13adb2ac8d1a7102879ea98
  2, add 'Reviewed-by' based on the comments of v1.
Changes v2 -> v3:
  use "riscv" instead of "riscv64" in patch 5 subject line.
Changes v3 -> v4:
  use "riscv" instead of "riscv64" in the summary of patch 5 subject line.
Changes v4 -> v5:
  add a new patch "RISC-V: Fixup schedule out issue in machine_crash_shutdown()" 
Changes v5 -> v6:
  1, move "fixup" patches to the start of the patch set.
  2, change patch 1, 2, 6's subject to make it tell more what it's about. 
  3, add Fixes for patch 3.
  4, adjuest the changes format for patch 6.


Xianting Tian (6):
  RISC-V: kexec: Fixup use of smp_processor_id() in preemptible context
  RISC-V: Fixup get incorrect user mode PC for kernel mode regs
  RISC-V: Fixup schedule out issue in machine_crash_shutdown()
  RISC-V: Add modules to virtual kernel memory layout dump
  RISC-V: Add arch_crash_save_vmcoreinfo support
  Documentation: kdump: describe VMCOREINFO export for RISCV64

 .../admin-guide/kdump/vmcoreinfo.rst          | 31 +++++++++++++++++++
 arch/riscv/kernel/Makefile                    |  1 +
 arch/riscv/kernel/crash_core.c                | 29 +++++++++++++++++
 arch/riscv/kernel/crash_save_regs.S           |  2 +-
 arch/riscv/kernel/machine_kexec.c             | 28 ++++++++++++++---
 arch/riscv/mm/init.c                          |  4 +++
 6 files changed, 89 insertions(+), 6 deletions(-)
 create mode 100644 arch/riscv/kernel/crash_core.c

-- 
2.17.1

