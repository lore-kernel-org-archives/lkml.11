Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA869C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Mar 2022 16:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350114AbiCOQi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Mar 2022 12:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239917AbiCOQi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 12:38:26 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769BA57141
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 09:37:13 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V7IiZE5_1647362229;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0V7IiZE5_1647362229)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Mar 2022 00:37:10 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     sj@kernel.org
Cc:     xhao@linux.alibaba.com, rongwei.wang@linux.alibaba.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH V1 0/3] mm/damon: Add CMA minotor support
Date:   Wed, 16 Mar 2022 00:37:04 +0800
Message-Id: <cover.1647378112.git.xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of these patches is to add CMA memory monitoring function.
In some memory tight scenarios, it will be a good choice to release more
memory by monitoring the CMA memory.

These patches is only preliminarily for monitoring function, About the
reclaim, it need to do some fixes base on "reclaim.c" and more tests,
I will implement it in the next patch series.


Xin Hao (3):
  mm/damon: rename damon_evenly_split_region()
  mm/damon/paddr: Move "paddr" relative func to ops-common.c file
  mm/damon/sysfs: Add CMA memory monitoring

 include/linux/damon.h |   1 +
 mm/damon/Makefile     |   2 +-
 mm/damon/ops-common.c | 286 ++++++++++++++++++++++++++++++++++++++++++
 mm/damon/ops-common.h |  18 +++
 mm/damon/paddr-cma.c  | 104 +++++++++++++++
 mm/damon/paddr.c      | 246 ------------------------------------
 mm/damon/sysfs.c      |   1 +
 mm/damon/vaddr-test.h |   6 +-
 mm/damon/vaddr.c      |  41 +-----
 9 files changed, 415 insertions(+), 290 deletions(-)
 create mode 100644 mm/damon/paddr-cma.c

--
2.27.0
