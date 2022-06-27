Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41D0C43334
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jun 2022 13:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236047AbiF0NX6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jun 2022 09:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbiF0NX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:23:57 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A8E62F3;
        Mon, 27 Jun 2022 06:23:55 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LWpM65sQ4z9srP;
        Mon, 27 Jun 2022 21:23:14 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 27 Jun
 2022 21:23:53 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <willy@infradead.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH] filemap: minor cleanup for filemap_write_and_wait_range
Date:   Mon, 27 Jun 2022 21:23:51 +0800
Message-ID: <20220627132351.55680-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Restructure the logic in filemap_write_and_wait_range to simplify the code
and make it more consistent with file_write_and_wait_range. No functional
change intended.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/filemap.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 8ccb868c3d95..b561619cfafe 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -667,7 +667,7 @@ EXPORT_SYMBOL_GPL(filemap_range_has_writeback);
 int filemap_write_and_wait_range(struct address_space *mapping,
 				 loff_t lstart, loff_t lend)
 {
-	int err = 0;
+	int err = 0, err2;
 
 	if (mapping_needs_writeback(mapping)) {
 		err = __filemap_fdatawrite_range(mapping, lstart, lend,
@@ -678,18 +678,12 @@ int filemap_write_and_wait_range(struct address_space *mapping,
 		 * But the -EIO is special case, it may indicate the worst
 		 * thing (e.g. bug) happened, so we avoid waiting for it.
 		 */
-		if (err != -EIO) {
-			int err2 = filemap_fdatawait_range(mapping,
-						lstart, lend);
-			if (!err)
-				err = err2;
-		} else {
-			/* Clear any previously stored errors */
-			filemap_check_errors(mapping);
-		}
-	} else {
-		err = filemap_check_errors(mapping);
+		if (err != -EIO)
+			__filemap_fdatawait_range(mapping, lstart, lend);
 	}
+	err2 = filemap_check_errors(mapping);
+	if (!err)
+		err = err2;
 	return err;
 }
 EXPORT_SYMBOL(filemap_write_and_wait_range);
-- 
2.23.0

