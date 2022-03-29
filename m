Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB541C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Mar 2022 13:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237392AbiC2N1x (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Mar 2022 09:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237248AbiC2N1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 09:27:31 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBB41F636D
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 06:25:48 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KSVZw1ZQPzBrkH;
        Tue, 29 Mar 2022 21:21:44 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 29 Mar
 2022 21:25:46 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 6/8] mm/vmscan: take all base pages of THP into account when race with speculative reference
Date:   Tue, 29 Mar 2022 21:26:17 +0800
Message-ID: <20220329132619.18689-7-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220329132619.18689-1-linmiaohe@huawei.com>
References: <20220329132619.18689-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the page has buffers, shrink_page_list will try to free the buffer
mappings associated with the page and try to free the page as well.
In the rare race with speculative reference, the page will be freed
shortly by speculative reference. But nr_reclaimed is not incremented
correctly when we come across the THP. We need to account all the base
pages in this case.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 31e95d627448..1145d23332a3 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1862,7 +1862,7 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 					 * increment nr_reclaimed here (and
 					 * leave it off the LRU).
 					 */
-					nr_reclaimed++;
+					nr_reclaimed += nr_pages;
 					continue;
 				}
 			}
-- 
2.23.0

