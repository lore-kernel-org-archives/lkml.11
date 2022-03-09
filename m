Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD3CC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Mar 2022 09:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbiCIJQX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Mar 2022 04:16:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbiCIJQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 04:16:11 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE5E157220
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 01:15:11 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1646817309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=olA4r4ZgiOAYFwlfl2Yy38K26xuaM/avMHUMNx9O8Pk=;
        b=Bp0HuafFKD3+SWGE1W6sp5tYOmKpDRTvBmmbJbFH2VoI5+vvTvUn4qBD3vW6fwAHOp6hze
        OH+jL3Hl0ab+4sDc+0O6YJyzDe52fZyzlHJ0VWxDnTsmaoEuGrASOlcny2Fogx+psvDrvW
        DacQxNeNOxNniz57xHkRJepZ7hDkDbA=
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] mm/hwpoison: set PageHWPoison after taking page lock in memory_failure_hugetlb()
Date:   Wed,  9 Mar 2022 18:14:49 +0900
Message-Id: <20220309091449.2753904-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

There is a race condition between memory_failure_hugetlb() and hugetlb
free/demotion, which causes setting PageHWPoison flag on the wrong page
(which was a hugetlb when memory_failrue() was called, but was removed
or demoted when memory_failure_hugetlb() is called).  This results in
killing wrong processes.  So set PageHWPoison flag with holding page lock,

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 mm/memory-failure.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index ac6492e36978..fe25eee8f9d6 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1494,24 +1494,11 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
 	int res;
 	unsigned long page_flags;
 
-	if (TestSetPageHWPoison(head)) {
-		pr_err("Memory failure: %#lx: already hardware poisoned\n",
-		       pfn);
-		res = -EHWPOISON;
-		if (flags & MF_ACTION_REQUIRED)
-			res = kill_accessing_process(current, page_to_pfn(head), flags);
-		return res;
-	}
-
-	num_poisoned_pages_inc();
-
 	if (!(flags & MF_COUNT_INCREASED)) {
 		res = get_hwpoison_page(p, flags);
 		if (!res) {
 			lock_page(head);
 			if (hwpoison_filter(p)) {
-				if (TestClearPageHWPoison(head))
-					num_poisoned_pages_dec();
 				unlock_page(head);
 				return -EOPNOTSUPP;
 			}
@@ -1544,13 +1531,16 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
 	page_flags = head->flags;
 
 	if (hwpoison_filter(p)) {
-		if (TestClearPageHWPoison(head))
-			num_poisoned_pages_dec();
 		put_page(p);
 		res = -EOPNOTSUPP;
 		goto out;
 	}
 
+	if (TestSetPageHWPoison(head))
+		goto already_hwpoisoned;
+
+	num_poisoned_pages_inc();
+
 	/*
 	 * TODO: hwpoison for pud-sized hugetlb doesn't work right now, so
 	 * simply disable it. In order to make it work properly, we need
@@ -1576,6 +1566,13 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
 out:
 	unlock_page(head);
 	return res;
+already_hwpoisoned:
+	unlock_page(head);
+	pr_err("Memory failure: %#lx: already hardware poisoned\n", pfn);
+	res = -EHWPOISON;
+	if (flags & MF_ACTION_REQUIRED)
+		res = kill_accessing_process(current, page_to_pfn(head), flags);
+	return res;
 }
 
 static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
-- 
2.25.1

