Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8885C43334
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jul 2022 08:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiGKIud (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jul 2022 04:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiGKIuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:50:11 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92392EA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657529409; x=1689065409;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+5a4TVD9cAS8BYvma0cNTLvM2floEItwSC7MbOeP6I8=;
  b=dZnP6vXuswWp7hTLELKRIIZlsyhXg2IMLkgUTzmNn8zMr6Audri6h7D0
   xp61GjpcP4470mtejiwyaLccou9ivnsDLHfoPunqLFfh6aa1lZ5Bytmux
   QoodWC1FKzP4aPZAOG75IvML/qhcAi1JDJ0X0ei60jkoVIj19rVU/NIda
   hca7r4CMVoNdYQDrDmjrvcYxspmt5pmeTQ8/44FCz0/UO4YJRFNlSwPx3
   vrwD4wJpgsPfLyML7nWyeIQSKJJcwzTPypUDq8erFxTL54ORvOPCYIW61
   U/FB5K9HwCztXtG3dJoSO9j66NWZSgqYBkLdczgVomUqCJGU6Z5g99+hn
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="284637842"
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="284637842"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 01:50:09 -0700
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="652374135"
Received: from yhuang6-mobl1.sh.intel.com ([10.238.5.168])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 01:50:07 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>
Subject: [PATCH -V2 3/7] migrate_pages(): fix THP failure counting for -ENOMEM
Date:   Mon, 11 Jul 2022 16:49:44 +0800
Message-Id: <20220711084948.274787-4-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220711084948.274787-1-ying.huang@intel.com>
References: <20220711084948.274787-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In unmap_and_move(), if the new THP cannot be allocated, -ENOMEM will
be returned, and migrate_pages() will try to split the THP unless
"reason" is MR_NUMA_MISPLACED (that is, nosplit == true).  But when
nosplit == true, the THP migration failure will not be counted.  This
is incorrect.  So in this patch, the THP migration failure will be
counted for -ENOMEM regardless of nosplit is true or false.  The
nr_failed counting isn't fixed because it's not used.  Added some
comments for it per Baolin's suggestion.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Fixes: 5984fabb6e82 ("mm: move_pages: report the number of non-attempted pages")
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Yang Shi <shy828301@gmail.com>
---
 mm/migrate.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 794312072eb3..38e2c789a9c3 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1426,11 +1426,11 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 				/*
 				 * When memory is low, don't bother to try to migrate
 				 * other pages, just exit.
-				 * THP NUMA faulting doesn't split THP to retry.
 				 */
-				if (is_thp && !nosplit) {
+				if (is_thp) {
 					nr_thp_failed++;
-					if (!try_split_thp(page, &thp_split_pages)) {
+					/* THP NUMA faulting doesn't split THP to retry. */
+					if (!nosplit && !try_split_thp(page, &thp_split_pages)) {
 						nr_thp_split++;
 						goto retry;
 					}
@@ -1446,6 +1446,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 				 * the caller otherwise the page refcnt will be leaked.
 				 */
 				list_splice_init(&thp_split_pages, from);
+				/* nr_failed isn't updated for not used */
 				nr_thp_failed += thp_retry;
 				goto out;
 			case -EAGAIN:
-- 
2.30.2

