Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB3CECAAD4
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Aug 2022 02:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244624AbiHZCX6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Aug 2022 22:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbiHZCX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 22:23:56 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C2FC924C;
        Thu, 25 Aug 2022 19:23:55 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MDNpr6tX9zlWMm;
        Fri, 26 Aug 2022 10:20:36 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 26 Aug 2022 10:23:53 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600010.china.huawei.com
 (7.193.23.86) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 26 Aug
 2022 10:23:52 +0800
From:   Sun Ke <sunke32@huawei.com>
To:     <dhowells@redhat.com>
CC:     <linux-cachefs@redhat.com>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <jefflexu@linux.alibaba.com>, <dan.carpenter@oracle.com>,
        <hsiangkao@linux.alibaba.com>, <sunke32@huawei.com>
Subject: [PATCH v4] cachefiles: fix error return code in cachefiles_ondemand_copen()
Date:   Fri, 26 Aug 2022 10:35:15 +0800
Message-ID: <20220826023515.3437469-1-sunke32@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cache_size field of copen is specified by the user daemon.
If cache_size < 0, then the OPEN request is expected to fail,
while copen itself shall succeed. However, returning 0 is indeed
unexpected when cache_size is an invalid error code.

Fix this by returning error when cache_size is an invalid error code.

Fixes: c8383054506c ("cachefiles: notify the user daemon when looking up cookie")
Signed-off-by: Sun Ke <sunke32@huawei.com>
Suggested-by: Jeffle Xu <jefflexu@linux.alibaba.com>
Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v4: update the code suggested by Dan
v3: update the commit log suggested by Jingbo.
 fs/cachefiles/ondemand.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 1fee702d5529..7e1586bd5cf3 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -158,9 +158,13 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
 
 	/* fail OPEN request if daemon reports an error */
 	if (size < 0) {
-		if (!IS_ERR_VALUE(size))
-			size = -EINVAL;
-		req->error = size;
+		if (!IS_ERR_VALUE(size)) {
+			req->error = -EINVAL;
+			ret = -EINVAL;
+		} else {
+			req->error = size;
+			ret = 0;
+		}
 		goto out;
 	}
 
-- 
2.31.1

