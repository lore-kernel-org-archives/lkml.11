Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B39C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 21 May 2022 11:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354885AbiEULRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 May 2022 07:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354815AbiEULMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 07:12:39 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED18436E24;
        Sat, 21 May 2022 04:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oeoGIolh+B9ZKlRkght98N+Q1Q4N0R0ACfahDR8k8E0=;
  b=t0WGoZZkithIR0lsLcF5kJUvFhQjWfgtfuiQPWCqIflq8HdSPL49Uwkm
   wkKmfhZ2K6fU29BPSBtNxVriFfumR5zXL+SH4zK/6Sdrd3HgHzAwf7R5c
   8O62uz80+GW8lYMfVBAa1akYtNaR5lCXrE7JZe+gk3R2e+Y13ZsJM7xnm
   Y=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,242,1647298800"; 
   d="scan'208";a="14727953"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 13:12:01 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: fix typos in comments
Date:   Sat, 21 May 2022 13:11:01 +0200
Message-Id: <20220521111145.81697-51-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Spelling mistakes (triple letters) in comments.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/dma/amba-pl08x.c |    2 +-
 drivers/dma/mv_xor_v2.c  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index a4a794e62ac2..487a01aa207d 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -231,7 +231,7 @@ enum pl08x_dma_chan_state {
 
 /**
  * struct pl08x_dma_chan - this structure wraps a DMA ENGINE channel
- * @vc: wrappped virtual channel
+ * @vc: wrapped virtual channel
  * @phychan: the physical channel utilized by this channel, if there is one
  * @name: name of channel
  * @cd: channel platform data
diff --git a/drivers/dma/mv_xor_v2.c b/drivers/dma/mv_xor_v2.c
index f10b29034da1..f629ef6fd3c2 100644
--- a/drivers/dma/mv_xor_v2.c
+++ b/drivers/dma/mv_xor_v2.c
@@ -313,7 +313,7 @@ mv_xor_v2_tx_submit(struct dma_async_tx_descriptor *tx)
 		"%s sw_desc %p: async_tx %p\n",
 		__func__, sw_desc, &sw_desc->async_tx);
 
-	/* assign coookie */
+	/* assign cookie */
 	spin_lock_bh(&xor_dev->lock);
 	cookie = dma_cookie_assign(tx);
 

