Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BB7C4167E
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 22:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1453009AbiDEWcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 18:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357129AbiDEKZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 06:25:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503D595A18;
        Tue,  5 Apr 2022 03:09:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E30ADB81C98;
        Tue,  5 Apr 2022 10:09:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F844C385A2;
        Tue,  5 Apr 2022 10:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649153372;
        bh=Wp0hPJ9IukXcUIGFX8IaXuqKEfhpodXZOqo2dOyyxsg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2G8gDvgpsZnH9KCR9hrfYD7ow3HFT+NQodm7z2EDoTEo4o3SEjIxsw/cUb46ZgKNg
         5wb2YVbwCS7+sHi+GunXOj85y8kliF8PY7JSlyD5DPrQtW4BgOcgaNRYA+mTDbBJAd
         q0Tcvd9COxzzvOxffQfRcPOWLD6nwEz7lLrngRnM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?D=C4=81vis=20Mos=C4=81ns?= <davispuh@gmail.com>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 162/599] crypto: ccp - ccp_dmaengine_unregister release dma channels
Date:   Tue,  5 Apr 2022 09:27:36 +0200
Message-Id: <20220405070303.661964995@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070258.802373272@linuxfoundation.org>
References: <20220405070258.802373272@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dāvis Mosāns <davispuh@gmail.com>

[ Upstream commit 54cce8ecb9254f971b40a72911c6da403720a2d2 ]

ccp_dmaengine_register adds dma_chan->device_node to dma_dev->channels list
but ccp_dmaengine_unregister didn't remove them.
That can cause crashes in various dmaengine methods that tries to use dma_dev->channels

Fixes: 58ea8abf4904 ("crypto: ccp - Register the CCP as a DMA...")
Signed-off-by: Dāvis Mosāns <davispuh@gmail.com>
Acked-by: John Allen <john.allen@amd.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/ccp/ccp-dmaengine.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/crypto/ccp/ccp-dmaengine.c b/drivers/crypto/ccp/ccp-dmaengine.c
index 0770a83bf1a5..b3eea329f840 100644
--- a/drivers/crypto/ccp/ccp-dmaengine.c
+++ b/drivers/crypto/ccp/ccp-dmaengine.c
@@ -633,6 +633,20 @@ static int ccp_terminate_all(struct dma_chan *dma_chan)
 	return 0;
 }
 
+static void ccp_dma_release(struct ccp_device *ccp)
+{
+	struct ccp_dma_chan *chan;
+	struct dma_chan *dma_chan;
+	unsigned int i;
+
+	for (i = 0; i < ccp->cmd_q_count; i++) {
+		chan = ccp->ccp_dma_chan + i;
+		dma_chan = &chan->dma_chan;
+		tasklet_kill(&chan->cleanup_tasklet);
+		list_del_rcu(&dma_chan->device_node);
+	}
+}
+
 int ccp_dmaengine_register(struct ccp_device *ccp)
 {
 	struct ccp_dma_chan *chan;
@@ -737,6 +751,7 @@ int ccp_dmaengine_register(struct ccp_device *ccp)
 	return 0;
 
 err_reg:
+	ccp_dma_release(ccp);
 	kmem_cache_destroy(ccp->dma_desc_cache);
 
 err_cache:
@@ -753,6 +768,7 @@ void ccp_dmaengine_unregister(struct ccp_device *ccp)
 		return;
 
 	dma_async_device_unregister(dma_dev);
+	ccp_dma_release(ccp);
 
 	kmem_cache_destroy(ccp->dma_desc_cache);
 	kmem_cache_destroy(ccp->dma_cmd_cache);
-- 
2.34.1



