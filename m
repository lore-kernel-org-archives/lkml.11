Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB551CCA481
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jun 2022 13:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379269AbiFMNn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jun 2022 09:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379146AbiFMNjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 09:39:55 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C503DA7D;
        Mon, 13 Jun 2022 04:28:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 55717CE110D;
        Mon, 13 Jun 2022 11:28:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ABAFC34114;
        Mon, 13 Jun 2022 11:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655119735;
        bh=3Avsel2L6qQgV3X7BOOhbwHe0V7A+QJopTMpCRyGBJc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dZg32QZE3c4cKYfeab8DpQsvn4gWqSoZ248JZiYfC+6gsIilN3Xjhd8d6QFAphu03
         WDfmcpWEa7FxQ36Le8HPd0+oQvANWwUs2X19zsmJhQf4OI0gNpCsGFjsEOSo/eJ61U
         hDW5O/QTmjlqZE7Z86dJepsWhxkMRJ1eOMDB1yzE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Weizhao Ouyang <o451686892@gmail.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Yue Hu <huyue2@coolpad.com>, Chao Yu <chao@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.18 121/339] erofs: fix backmost member of z_erofs_decompress_frontend
Date:   Mon, 13 Jun 2022 12:09:06 +0200
Message-Id: <20220613094930.178767865@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220613094926.497929857@linuxfoundation.org>
References: <20220613094926.497929857@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weizhao Ouyang <o451686892@gmail.com>

[ Upstream commit 4398d3c31b582db0d640b23434bf344a6c8df57c ]

Initialize 'backmost' to true in DECOMPRESS_FRONTEND_INIT.

Fixes: 5c6dcc57e2e5 ("erofs: get rid of `struct z_erofs_collector'")
Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Reviewed-by: Yue Hu <huyue2@coolpad.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Link: https://lore.kernel.org/r/20220530075114.918874-1-o451686892@gmail.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/zdata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index e6dea6dfca16..3e3e96043b5b 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -214,7 +214,7 @@ struct z_erofs_decompress_frontend {
 
 #define DECOMPRESS_FRONTEND_INIT(__i) { \
 	.inode = __i, .owned_head = Z_EROFS_PCLUSTER_TAIL, \
-	.mode = COLLECT_PRIMARY_FOLLOWED }
+	.mode = COLLECT_PRIMARY_FOLLOWED, .backmost = true }
 
 static struct page *z_pagemap_global[Z_EROFS_VMAP_GLOBAL_PAGES];
 static DEFINE_MUTEX(z_pagemap_global_lock);
-- 
2.35.1



