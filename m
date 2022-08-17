Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952A5C25B08
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Aug 2022 08:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234726AbiHQIQL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Aug 2022 04:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234942AbiHQIOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 04:14:53 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21DC5A896
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 01:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660724080; x=1692260080;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CfWZdev3ddt5aOgW4WxIwyKcDYIQwXT1f+c+rDGkzjw=;
  b=kK8PV78sbIBjiyYEP2mBhyaQxQgI/ICHiyamxtCELGDgotGjyEfuhZ9W
   8s+8f7V1udX+pTXgvujWOxyAKovsVO66Wu2UvyEKLxKWLVX1X3mVfSyra
   D5MHYcJx2IPn/EiKuyp9EeD1jCLc8HSGhp80hRpIT9HzQ/f/YtE2iul5l
   2vACvya3fwG47QK4P92tX5c4phXX4HNm02H8jj7D2jRoRdJJ6ByL30WzD
   25q46qnnsHL3aEenvikBKknxG7fP2M1hjfLmIr4gR+OdKk4S/64Bc1U/T
   jsAbAWX2SVDrP9nXP5K/I9J1OQahpaXdODmSe4bFMuTmrTmdIXQ3wktcx
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="293228871"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="293228871"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 01:14:39 -0700
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="583668162"
Received: from yhuang6-mobl1.sh.intel.com ([10.238.6.172])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 01:14:37 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>
Subject: [PATCH -V3 8/8] mm: migrate: Do not retry 10 times for the subpages of fail-to-migrate THP
Date:   Wed, 17 Aug 2022 16:14:08 +0800
Message-Id: <20220817081408.513338-9-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220817081408.513338-1-ying.huang@intel.com>
References: <20220817081408.513338-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Baolin Wang <baolin.wang@linux.alibaba.com>

If THP is failed to migrate due to -ENOSYS or -ENOMEM case, the THP will
be split, and the subpages of fail-to-migrate THP will be tried to migrate
again, so we should not account the retry counter in the second loop, since
we already accounted 'nr_thp_failed' in the first loop.

Moreover we also do not need retry 10 times for -EAGAIN case for the subpages
of fail-to-migrate THP in the second loop, since we already regarded the
THP as migration failure, and save some migration time (for the worst case,
will try 512 * 10 times) according to previous discussion [1].

[1] https://lore.kernel.org/linux-mm/87r13a7n04.fsf@yhuang6-desk2.ccr.corp.intel.com/

Tested-by: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Yang Shi <shy828301@gmail.com>
---
 mm/migrate.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 55fbf9669431..06a653977835 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1522,7 +1522,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 			case -EAGAIN:
 				if (is_thp)
 					thp_retry++;
-				else
+				else if (!no_subpage_counting)
 					retry++;
 				nr_retry_pages += nr_subpages;
 				break;
@@ -1548,8 +1548,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 			}
 		}
 	}
-	if (!no_subpage_counting)
-		nr_failed += retry;
+	nr_failed += retry;
 	nr_thp_failed += thp_retry;
 	nr_failed_pages += nr_retry_pages;
 	/*
-- 
2.30.2

