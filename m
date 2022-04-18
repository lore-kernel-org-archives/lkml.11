Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0E8C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Apr 2022 13:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244093AbiDRNi4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Apr 2022 09:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243985AbiDRNKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 09:10:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5608B39681;
        Mon, 18 Apr 2022 05:50:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2460E61254;
        Mon, 18 Apr 2022 12:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4F3C385A1;
        Mon, 18 Apr 2022 12:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650286217;
        bh=VJ0BUAhS3wNyh0DC82txMyIdsjCD3fgIBqLn4GwapDY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZrLjJ/j+b0lla1hjMxMzs+n5498+r1zaVr88eAd6O0NJWH2VzJ0ztxawvxYMQjaNH
         JwTz6KkdkMVUrvvIgYBLNVkPRHn8YRVYznv54iF7TZvXCTez7AiJF0Bvi5cbwfikHr
         e7cjJx1SJS0uBI9ARS3ZZShdxpmozEZAa4C/tz3M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?D=C4=81vis=20Mos=C4=81ns?= <davispuh@gmail.com>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 065/284] crypto: ccp - ccp_dmaengine_unregister release dma channels
Date:   Mon, 18 Apr 2022 14:10:46 +0200
Message-Id: <20220418121212.539249298@linuxfoundation.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220418121210.689577360@linuxfoundation.org>
References: <20220418121210.689577360@linuxfoundation.org>
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
index df82af3dd970..27a738c57119 100644
--- a/drivers/crypto/ccp/ccp-dmaengine.c
+++ b/drivers/crypto/ccp/ccp-dmaengine.c
@@ -632,6 +632,20 @@ static int ccp_terminate_all(struct dma_chan *dma_chan)
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
@@ -733,6 +747,7 @@ int ccp_dmaengine_register(struct ccp_device *ccp)
 	return 0;
 
 err_reg:
+	ccp_dma_release(ccp);
 	kmem_cache_destroy(ccp->dma_desc_cache);
 
 err_cache:
@@ -746,6 +761,7 @@ void ccp_dmaengine_unregister(struct ccp_device *ccp)
 	struct dma_device *dma_dev = &ccp->dma_dev;
 
 	dma_async_device_unregister(dma_dev);
+	ccp_dma_release(ccp);
 
 	kmem_cache_destroy(ccp->dma_desc_cache);
 	kmem_cache_destroy(ccp->dma_cmd_cache);
-- 
2.34.1



