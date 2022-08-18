Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850B5C00140
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Aug 2022 07:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243764AbiHRHiF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Aug 2022 03:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243591AbiHRHiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 03:38:01 -0400
Received: from out199-14.us.a.mail.aliyun.com (out199-14.us.a.mail.aliyun.com [47.90.199.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA62AB43A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 00:37:59 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VMZnOij_1660808275;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VMZnOij_1660808275)
          by smtp.aliyun-inc.com;
          Thu, 18 Aug 2022 15:37:56 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     sj@kernel.org, akpm@linux-foundation.org
Cc:     baolin.wang@linux.alibaba.com, muchun.song@linux.dev,
        mike.kravetz@oracle.com, damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] mm/damon: validate if the pmd entry is present before accessing
Date:   Thu, 18 Aug 2022 15:37:43 +0800
Message-Id: <58b1d1f5fbda7db49ca886d9ef6783e3dcbbbc98.1660805030.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pmd_huge() is used to validate if the pmd entry is mapped by a huge
page, also including the case of non-present (migration or hwpoisoned)
pmd entry on arm64 or x86 architectures. That means the pmd_pfn() can
not get the correct pfn number for the non-present pmd entry, which
will cause damon_get_page() to get an incorrect page struct (also
may be NULL by pfn_to_online_page()) to make the access statistics
incorrect.

Moreover it does not make sense that we still waste time to get the
page of the non-present entry, just treat it as not-accessed and skip it,
that keeps consistent with non-present pte level entry.

Thus adding a pmd entry present validation to fix above issues.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
---
Changes from v1:
 - Update the commit message to make it more clear.
 - Add reviewed tag from SeongJae.
---
 mm/damon/vaddr.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 3c7b9d6..1d16c6c 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -304,6 +304,11 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
 
 	if (pmd_huge(*pmd)) {
 		ptl = pmd_lock(walk->mm, pmd);
+		if (!pmd_present(*pmd)) {
+			spin_unlock(ptl);
+			return 0;
+		}
+
 		if (pmd_huge(*pmd)) {
 			damon_pmdp_mkold(pmd, walk->mm, addr);
 			spin_unlock(ptl);
@@ -431,6 +436,11 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	if (pmd_huge(*pmd)) {
 		ptl = pmd_lock(walk->mm, pmd);
+		if (!pmd_present(*pmd)) {
+			spin_unlock(ptl);
+			return 0;
+		}
+
 		if (!pmd_huge(*pmd)) {
 			spin_unlock(ptl);
 			goto regular_page;
-- 
1.8.3.1

