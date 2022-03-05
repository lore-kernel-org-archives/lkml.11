Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D48C433EF
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Mar 2022 14:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbiCEOuD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Mar 2022 09:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiCEOuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 09:50:02 -0500
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCA4201BD
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 06:49:11 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V6HF7hU_1646491739;
Received: from localhost.localdomain(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0V6HF7hU_1646491739)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 05 Mar 2022 22:49:08 +0800
From:   Tianchen Ding <dtcccc@linux.alibaba.com>
To:     Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] provide the flexibility to enable KFENCE
Date:   Sat,  5 Mar 2022 22:48:56 +0800
Message-Id: <20220305144858.17040-1-dtcccc@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I'm sending v2 about (re-)enabling KFENCE.
I've removed description about use case and just focus on flexibility.

Thanks.

v2:
Take KFENCE_WARN_ON() into account. Do not allow re-enabling KFENCE
if it once disabled by warn.
Modify func names and comments.

RFC/v1: https://lore.kernel.org/all/20220303031505.28495-1-dtcccc@linux.alibaba.com/

Tianchen Ding (2):
  kfence: Allow re-enabling KFENCE after system startup
  kfence: Alloc kfence_pool after system startup

 mm/kfence/core.c | 114 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 93 insertions(+), 21 deletions(-)

-- 
2.27.0

