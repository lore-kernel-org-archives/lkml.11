Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676CCC433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Jul 2022 07:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237600AbiGHHb6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Jul 2022 03:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237115AbiGHHb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 03:31:57 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B6B7B379
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 00:31:56 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VIij5CL_1657265513;
Received: from localhost(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VIij5CL_1657265513)
          by smtp.aliyun-inc.com;
          Fri, 08 Jul 2022 15:31:53 +0800
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
To:     palmer@dabbelt.com
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        guoren@kernel.org, Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [RESEND PATCH V5 0/2] Two fixups for 5.19-rcx
Date:   Fri,  8 Jul 2022 15:31:48 +0800
Message-Id: <20220708073150.352830-1-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer,
The 2 patches are some obviously fixups, could you please have a look?
Recently, I finished the development of Crash-utility for RISCV64,
I will submit the patches soon.
We expect we can normally use Kdump & Crash for 5.19-rcx.
thanks.

Xianting Tian (2):
  RISC-V: Fixup fast call of crash_kexec()
  RISC-V: use __smp_processor_id() instead of smp_processor_id()

 arch/riscv/kernel/machine_kexec.c | 2 +-
 arch/riscv/kernel/traps.c         | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

-- 
2.17.1

