Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CD4C32771
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Aug 2022 10:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347640AbiHSKNN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Aug 2022 06:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243414AbiHSKNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 06:13:10 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6060AD8E16
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 03:13:08 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VMfr8eo_1660903984;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VMfr8eo_1660903984)
          by smtp.aliyun-inc.com;
          Fri, 19 Aug 2022 18:13:05 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com
Cc:     baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Fix some issues when looking up hugetlb page
Date:   Fri, 19 Aug 2022 18:12:55 +0800
Message-Id: <cover.1660902741.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On ARM64 architecture, it can support CONT-PTE/PMD size hugetlb. When
looking up hugetlb page by follow_page(), we will hold the incorrect
pte/pmd lock for the CONT-PTE/PMD size hugetlb page, which will make
the pte/pmd entry unstable even under the lock and cause some potential
race issues. So considering the CONT-PTE/PMD size hugetlb, this patch set
changes to use the correct function to get the correct pte/pmd entry lock
to make the pte/pmd entry stable.

Baolin Wang (3):
  mm/gup: fix races when looking up a CONT-PTE size hugetlb page
  mm/hugetlb: fix races when looking up a CONT-PMD size hugetlb page
  mm/hugetlb: add FOLL_MIGRATION validation before waiting for a
    migration entry

 include/linux/hugetlb.h |  4 ++--
 mm/gup.c                | 24 +++++++++++++++++++++---
 mm/hugetlb.c            | 17 ++++++++++++++---
 3 files changed, 37 insertions(+), 8 deletions(-)

-- 
1.8.3.1

