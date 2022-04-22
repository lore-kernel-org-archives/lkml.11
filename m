Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6FFC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Apr 2022 06:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444201AbiDVG2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Apr 2022 02:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbiDVG2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 02:28:12 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF024D257
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 23:25:19 -0700 (PDT)
Received: from kwepemi500018.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Kl4BQ13tVzfYsX;
        Fri, 22 Apr 2022 14:24:30 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi500018.china.huawei.com (7.221.188.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 22 Apr 2022 14:25:17 +0800
Received: from localhost.localdomain (10.175.112.70) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 22 Apr 2022 14:25:17 +0800
From:   Xu Jia <xujia39@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <dhowells@redhat.com>
CC:     <edumazet@google.com>, <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] watch_queue: fix mistake in kcalloc
Date:   Fri, 22 Apr 2022 14:39:07 +0800
Message-ID: <1650609547-9854-1-git-send-email-xujia39@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.70]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function watch_queue_set_size, when the func kcalloc is
invoked, the number of elements and the element size are reversed.
It is a cleanup patch and does not affect the implementation.

Signed-off-by: Xu Jia <xujia39@huawei.com>
---
 kernel/watch_queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index 230038d4f908..868ce7e94cf6 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -248,7 +248,7 @@ long watch_queue_set_size(struct pipe_inode_info *pipe, unsigned int nr_notes)
 	if (ret < 0)
 		goto error;
 
-	pages = kcalloc(sizeof(struct page *), nr_pages, GFP_KERNEL);
+	pages = kcalloc(nr_pages, sizeof(struct page *), GFP_KERNEL);
 	if (!pages)
 		goto error;
 
-- 
2.25.1

