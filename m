Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569EEC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Feb 2022 04:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348038AbiBIEOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Feb 2022 23:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243116AbiBIDWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 22:22:54 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE49EC061576;
        Tue,  8 Feb 2022 19:22:53 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1644376968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hLaxf6+mwc2bWStgicWOQJDXt1cFA12+VvmMUCrykgo=;
        b=L0ceTlel3Z0OmlSwarXSFM4seNY/em3QuxmSPL7wV5djK8cAV1YvelNQyqgMzAeuuNvroB
        BluClShiGljeqh5B1BpH7UntjII+666CauVzpFX7OXiU3qhaiCJVuCJym7SPrU/OIJNhMz
        A++8xvXXqOqZoOenVXSkS1e9IhuQAvI=
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     cai.huoqing@linux.dev
Cc:     Vinod Koul <vkoul@kernel.org>, Salah Triki <salah.triki@gmail.com>,
        Jason Wang <wangborong@cdjrlc.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: ppc4xx: Make use of the helper macro LIST_HEAD()
Date:   Wed,  9 Feb 2022 11:22:19 +0800
Message-Id: <20220209032221.37211-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace "struct list_head head = LIST_HEAD_INIT(head)" with
"LIST_HEAD(head)" to simplify the code.

Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
---
 drivers/dma/ppc4xx/adma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ppc4xx/adma.c b/drivers/dma/ppc4xx/adma.c
index 5e46e347e28b..6b5e91f26afc 100644
--- a/drivers/dma/ppc4xx/adma.c
+++ b/drivers/dma/ppc4xx/adma.c
@@ -1686,8 +1686,8 @@ static struct ppc440spe_adma_desc_slot *ppc440spe_adma_alloc_slots(
 {
 	struct ppc440spe_adma_desc_slot *iter = NULL, *_iter;
 	struct ppc440spe_adma_desc_slot *alloc_start = NULL;
-	struct list_head chain = LIST_HEAD_INIT(chain);
 	int slots_found, retry = 0;
+	LIST_HEAD(chain);
 
 
 	BUG_ON(!num_slots || !slots_per_op);
-- 
2.25.1

