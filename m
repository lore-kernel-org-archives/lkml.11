Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66929C4332F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 09:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388631AbiDLJWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 05:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357907AbiDLHkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:40:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32733A701;
        Tue, 12 Apr 2022 00:17:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F66461701;
        Tue, 12 Apr 2022 07:17:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 421FCC385AB;
        Tue, 12 Apr 2022 07:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649747824;
        bh=537283YRBjJKgJj+Nf1tX1vYfyuMABT/nm75Jj/WTxo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lNdFbFNz1KfjS2zH06SOw/h0HieR0fqLJyl8Q2z8SnJz6cgKGLoc1645EaFv10spH
         ajWba4aaIxXg3GMzjuH/xRv7lNZKU0jV6jYEAErOkES5JdKv1QuHfOFE0OTJ6wBaPZ
         JUuZE1Wkn55+fxsDhVDmG87ZwjeUzftmTZq8nNis=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.17 219/343] spi: rpc-if: Fix RPM imbalance in probe error path
Date:   Tue, 12 Apr 2022 08:30:37 +0200
Message-Id: <20220412062957.663302382@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412062951.095765152@linuxfoundation.org>
References: <20220412062951.095765152@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 2f8cf5f642e80f8b6b0e660a9c86924a1f41cd80 ]

If rpcif_hw_init() fails, Runtime PM is left enabled.

Fixes: b04cc0d912eb80d3 ("memory: renesas-rpc-if: Add support for RZ/G2L")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/1c78a1f447d019bb66b6e7787f520ae78821e2ae.1648562287.git.geert+renesas@glider.be
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-rpc-if.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-rpc-if.c b/drivers/spi/spi-rpc-if.c
index fe82f3575df4..24ec1c83f379 100644
--- a/drivers/spi/spi-rpc-if.c
+++ b/drivers/spi/spi-rpc-if.c
@@ -158,14 +158,18 @@ static int rpcif_spi_probe(struct platform_device *pdev)
 
 	error = rpcif_hw_init(rpc, false);
 	if (error)
-		return error;
+		goto out_disable_rpm;
 
 	error = spi_register_controller(ctlr);
 	if (error) {
 		dev_err(&pdev->dev, "spi_register_controller failed\n");
-		rpcif_disable_rpm(rpc);
+		goto out_disable_rpm;
 	}
 
+	return 0;
+
+out_disable_rpm:
+	rpcif_disable_rpm(rpc);
 	return error;
 }
 
-- 
2.35.1



