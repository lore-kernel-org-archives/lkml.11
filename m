Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D3B6C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jul 2022 11:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238932AbiGNLdN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jul 2022 07:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238900AbiGNLdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:33:09 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D3E13FAC
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 04:33:07 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VJJBi4t_1657798382;
Received: from localhost(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VJJBi4t_1657798382)
          by smtp.aliyun-inc.com;
          Thu, 14 Jul 2022 19:33:03 +0800
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, alexandre.ghiti@canonical.com,
        guoren@kernel.org, anup@brainfault.org, mick@ics.forth.gr,
        rppt@kernel.org, heiko@sntech.de
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        huanyi.xj@alibaba-inc.com,
        Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [PATCH V3 0/2] Improve vmcoreinfo and memory layout dump
Date:   Thu, 14 Jul 2022 19:32:58 +0800
Message-Id: <20220714113300.367854-1-xianting.tian@linux.alibaba.com>
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
Changes v2 -> v3:
 patch 1,2: use "#ifdef CONFIG_64BIT" instead of "IS_ENABLED(CONFIG_64BIT)"
            when check whether MODULES area is available.

Xianting Tian (2):
  RISC-V: Add arch_crash_save_vmcoreinfo support
  riscv: Add modules to virtual kernel memory layout dump

 arch/riscv/kernel/Makefile     |  1 +
 arch/riscv/kernel/crash_core.c | 29 +++++++++++++++++++++++++++++
 arch/riscv/mm/init.c           |  4 ++++
 3 files changed, 34 insertions(+)
 create mode 100644 arch/riscv/kernel/crash_core.c

-- 
2.17.1

