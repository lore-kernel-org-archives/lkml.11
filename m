Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83CCC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Feb 2022 08:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238321AbiBQI7q (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Feb 2022 03:59:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238283AbiBQI7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 03:59:41 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74FB2AA3B2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 00:59:25 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JzpYc67JJzZfhk;
        Thu, 17 Feb 2022 16:55:00 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 17 Feb
 2022 16:59:23 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <cl@linux.com>, <penberg@kernel.org>,
        <rientjes@google.com>, <iamjoonsoo.kim@lge.com>, <vbabka@suse.cz>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/slob: make kmem_cache_boot static
Date:   Thu, 17 Feb 2022 16:58:42 +0800
Message-ID: <20220217085842.29032-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmem_cache_boot is never accessed outside slob.c. Make it static.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/slob.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slob.c b/mm/slob.c
index 60c5842215f1..1179bcad2df8 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -708,7 +708,7 @@ int __kmem_cache_shrink(struct kmem_cache *d)
 	return 0;
 }
 
-struct kmem_cache kmem_cache_boot = {
+static struct kmem_cache kmem_cache_boot = {
 	.name = "kmem_cache",
 	.size = sizeof(struct kmem_cache),
 	.flags = SLAB_PANIC,
-- 
2.23.0

