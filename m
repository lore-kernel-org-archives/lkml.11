Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FF3C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 02:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343502AbiBUCQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Feb 2022 21:16:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240542AbiBUCQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 21:16:22 -0500
Received: from spam.unicloud.com (eage.unicloud.com [220.194.70.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068D832078
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 18:15:59 -0800 (PST)
Received: from eage.unicloud.com ([220.194.70.35])
        by spam.unicloud.com with ESMTP id 21L2FaV2091761;
        Mon, 21 Feb 2022 10:15:37 +0800 (GMT-8)
        (envelope-from luofei@unicloud.com)
Received: from localhost.localdomain (10.10.1.7) by zgys-ex-mb09.Unicloud.com
 (10.10.0.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2375.17; Mon, 21
 Feb 2022 10:15:35 +0800
From:   luofei <luofei@unicloud.com>
To:     <naoya.horiguchi@nec.com>, <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        luofei <luofei@unicloud.com>
Subject: [PATCH v4 2/2] mm/hwpoison: Add in-use hugepage hwpoison filter judgement
Date:   Sun, 20 Feb 2022 21:15:21 -0500
Message-ID: <20220221021521.2329075-1-luofei@unicloud.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.10.1.7]
X-ClientProxiedBy: zgys-ex-mb07.Unicloud.com (10.10.0.27) To
 zgys-ex-mb09.Unicloud.com (10.10.0.24)
X-DNSRBL: 
X-MAIL: spam.unicloud.com 21L2FaV2091761
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After successfully obtaining the reference count of the huge
page, it is still necessary to call hwpoison_filter() to make a
filter judgement, otherwise the filter hugepage will be unmaped
and the related process may be killed.

Signed-off-by: luofei <luofei@unicloud.com>
---
 mm/memory-failure.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 59d6d939a752..17a7b0a94ab9 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1548,6 +1548,17 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
 	lock_page(head);
 	page_flags = head->flags;
 
+	if (hwpoison_filter(p)) {
+		if (TestClearPageHWPoison(head))
+			num_poisoned_pages_dec();
+		put_page(p);
+		if (flags & MF_MCE_HANDLE)
+			res = -EHWPOISON;
+		else
+			res = 0;
+		goto out;
+	}
+
 	/*
 	 * TODO: hwpoison for pud-sized hugetlb doesn't work right now, so
 	 * simply disable it. In order to make it work properly, we need
-- 
2.27.0

