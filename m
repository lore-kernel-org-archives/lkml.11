Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE1EC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 12:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241481AbiDNMEM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 08:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242936AbiDNMD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 08:03:59 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2928326DF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 05:01:35 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KfJ2J1BHPzfYkt;
        Thu, 14 Apr 2022 20:00:56 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 14 Apr
 2022 20:01:33 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/vmscan: fix comment for current_may_throttle
Date:   Thu, 14 Apr 2022 20:02:02 +0800
Message-ID: <20220414120202.30082-1-linmiaohe@huawei.com>
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

Since commit 6d6435811c19 ("remove bdi_congested() and wb_congested() and
related functions"), there is no congested backing device check anymore.
Correct the comment accordingly.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/vmscan.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index d4a7d2bd276d..6f96cf1eacb2 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2334,8 +2334,7 @@ static unsigned int move_pages_to_lru(struct lruvec *lruvec,
 /*
  * If a kernel thread (such as nfsd for loop-back mounts) services
  * a backing device by writing to the page cache it sets PF_LOCAL_THROTTLE.
- * In that case we should only throttle if the backing device it is
- * writing to is congested.  In other cases it is safe to throttle.
+ * In that case we should not throttle it otherwise it is safe to do so.
  */
 static int current_may_throttle(void)
 {
-- 
2.23.0

