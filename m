Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E60C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 21 May 2022 11:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348451AbiEULPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 May 2022 07:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242419AbiEULMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 07:12:03 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328E22B18B;
        Sat, 21 May 2022 04:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/Xjy/3p4SMUmqBnwUcbwEf3XXUDh3xvEAhklGc46AYY=;
  b=jIfusPeiipJzcirL00ToLr9nx6jUigHG5UTc9xobojbH1tSnYlXqHZVE
   M+tr2TFjkTyTNO0cXiqV1E7cbGQFigzc0Xxh8mSvNa4TAClqp31E+dBmi
   o+p3kJ0oeR2SOh6CQxjobFX2Xm6KIrqamVw1Ee3NvEYHkoNlYaHQzdMfn
   8=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,242,1647298800"; 
   d="scan'208";a="14727912"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 13:11:55 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     kernel-janitors@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: ste_dma40: fix typo in comment
Date:   Sat, 21 May 2022 13:10:27 +0200
Message-Id: <20220521111145.81697-17-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Spelling mistake (triple letters) in comment.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/dma/ste_dma40.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index e1827393143f..f093e08c23b1 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -1970,7 +1970,7 @@ static int d40_config_memcpy(struct d40_chan *d40c)
 		   dma_has_cap(DMA_SLAVE, cap)) {
 		d40c->dma_cfg = dma40_memcpy_conf_phy;
 
-		/* Generate interrrupt at end of transfer or relink. */
+		/* Generate interrupt at end of transfer or relink. */
 		d40c->dst_def_cfg |= BIT(D40_SREG_CFG_TIM_POS);
 
 		/* Generate interrupt on error. */

