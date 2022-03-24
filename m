Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8039C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Mar 2022 01:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344589AbiCXB0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Mar 2022 21:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241719AbiCXB0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 21:26:41 -0400
Received: from mail.meizu.com (unknown [14.29.68.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E766D4E6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 18:25:08 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail04.meizu.com
 (172.16.1.16) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 24 Mar
 2022 09:25:10 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Thu, 24 Mar
 2022 09:25:06 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     <willy@infradead.org>
CC:     <linux-kernel@vger.kernel.org>, Haowen Bai <baihaowen@meizu.com>
Subject: [PATCH] XArray: Fix warning comparing pointer to 0
Date:   Thu, 24 Mar 2022 09:25:04 +0800
Message-ID: <1648085104-22891-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-125.meizu.com (172.16.1.125) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid pointer type value compared with 0 to make code clear.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 lib/test_xarray.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index 8b1c318..d3fa5d9 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -742,7 +742,7 @@ static noinline void check_xa_alloc_1(struct xarray *xa, unsigned int base)
 
 	XA_BUG_ON(xa, xa_alloc(xa, &id, xa_mk_index(10), XA_LIMIT(10, 5),
 				GFP_KERNEL) != -EBUSY);
-	XA_BUG_ON(xa, xa_store_index(xa, 3, GFP_KERNEL) != 0);
+	XA_BUG_ON(xa, xa_store_index(xa, 3, GFP_KERNEL) != NULL);
 	XA_BUG_ON(xa, xa_alloc(xa, &id, xa_mk_index(10), XA_LIMIT(10, 5),
 				GFP_KERNEL) != -EBUSY);
 	xa_erase_index(xa, 3);
-- 
2.7.4

