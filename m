Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F3EC433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Mar 2022 03:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbiCCDQG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Mar 2022 22:16:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbiCCDQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 22:16:04 -0500
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326DAEF096
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 19:15:17 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V650kF3_1646277305;
Received: from localhost.localdomain(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0V650kF3_1646277305)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 03 Mar 2022 11:15:14 +0800
From:   Tianchen Ding <dtcccc@linux.alibaba.com>
To:     Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/2] Alloc kfence_pool after system startup
Date:   Thu,  3 Mar 2022 11:15:03 +0800
Message-Id: <20220303031505.28495-1-dtcccc@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KFENCE aims at production environments, but it does not allow enabling
after system startup because kfence_pool only alloc pages from memblock.
Consider the following production scene:
At first, for performance considerations, production machines do not
enable KFENCE.
However, after running for a while, the kernel is suspected to have
memory errors. (e.g., a sibling machine crashed.)
So other production machines need to enable KFENCE, but it's hard for
them to reboot.

The 1st patch allows re-enabling KFENCE if the pool is already
allocated from memblock.

The 2nd patch applies the main part.

Tianchen Ding (2):
  kfence: Allow re-enabling KFENCE after system startup
  kfence: Alloc kfence_pool after system startup

 mm/kfence/core.c | 106 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 87 insertions(+), 19 deletions(-)

-- 
2.27.0

