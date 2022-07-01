Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFA0C43334
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Jul 2022 12:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbiGAME3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Jul 2022 08:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiGAME0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 08:04:26 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5566842ED6
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 05:04:25 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VI2LUmc_1656677062;
Received: from localhost(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VI2LUmc_1656677062)
          by smtp.aliyun-inc.com;
          Fri, 01 Jul 2022 20:04:23 +0800
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
To:     palmer@dabbelt.com
Cc:     guoren@kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v5 0/3] RISC-V: three fixup and cleanups
Date:   Fri,  1 Jul 2022 20:04:19 +0800
Message-Id: <20220701120422.228154-1-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer and experts,
These 3 patches are some obviously fixup and cleanups, please have a look, thanks.

Xianting Tian (2):
    RISC-V: use __smp_processor_id() instead of smp_processor_id()    
    RISC-V: Fixup fast call of crash_kexec()

Guo Ren (1):
    riscv: atomic: Clean up unnecessary acquire and release definitions

