Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1063C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jul 2022 02:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbiGNC7P (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jul 2022 22:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbiGNC7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 22:59:09 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62EC19C03
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 19:59:07 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R761e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VJH7R-e_1657767542;
Received: from localhost(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VJH7R-e_1657767542)
          by smtp.aliyun-inc.com;
          Thu, 14 Jul 2022 10:59:03 +0800
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, alexandre.ghiti@canonical.com,
        guoren@kernel.org, anup@brainfault.org, mick@ics.forth.gr,
        rppt@kernel.org, heiko@sntech.de
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        huanyi.xj@alibaba-inc.com,
        Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [PATCH V2 0/2] Improve vmcoreinfo and memory layout dump
Date:   Thu, 14 Jul 2022 10:58:59 +0800
Message-Id: <20220714025901.359695-1-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series are the improvements for vmcoreinfo and memory
layout dump.

The first patch(1/2) is to add VM layout to vmcoreinfo, which can
simlify the development of crash tool as ARM64 already did
(arch/arm64/kernel/crash_core.c).

The second patch(2/2) is to add MODULES to memory layout dump.

Changes v1 -> v2:
 patch 1: add VA_BITS to vmcoreinfo as ARM64 does, not satp_mode.
	  crash tool can read VA_BITS to determin the pagetable
	  levels.
 patch 1,2: As MODULES area is only defined when CONFIG_64BIT=y for
	    riscv64, so only use MODULES area when CONFIG_64BIT=y. 
 
Xianting Tian (2):
  RISC-V: Add arch_crash_save_vmcoreinfo support
  riscv: Add modules to virtual kernel memory layout dump

 arch/riscv/kernel/Makefile     |  1 +
 arch/riscv/kernel/crash_core.c | 28 ++++++++++++++++++++++++++++
 arch/riscv/mm/init.c           |  3 +++
 3 files changed, 32 insertions(+)
 create mode 100644 arch/riscv/kernel/crash_core.c

-- 
2.17.1

