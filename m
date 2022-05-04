Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF724C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 May 2022 17:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356749AbiEDR24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 May 2022 13:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356172AbiEDRJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 13:09:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF4452B3D;
        Wed,  4 May 2022 09:54:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17C16617BD;
        Wed,  4 May 2022 16:54:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67F23C385AF;
        Wed,  4 May 2022 16:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651683294;
        bh=puxZb8keBI0MxGWFKEJg7XUlq5HvNRAXuB4e6S/Tg5E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ANc/UoNJSpvX2Amep1G8sXwWqRHuEs859iBDeJJjSydfZuLwku17sFIlhsnO/NG6Q
         q/KIOyEl63t2A8Le6x2ZmnS+UGmDZ0Pu3EtrCrQQzSj0RurzyWSlv0nBz5zKk7Bvco
         B2WZPQwp8a9sg7LH+Pqujb9wYUvcltzaY4cNBUl8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15 148/177] net: ethernet: stmmac: fix write to sgmii_adapter_base
Date:   Wed,  4 May 2022 18:45:41 +0200
Message-Id: <20220504153106.556326710@linuxfoundation.org>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220504153053.873100034@linuxfoundation.org>
References: <20220504153053.873100034@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dinh Nguyen <dinguyen@kernel.org>

commit 5fd1fe4807f91ea0cca043114d929faa11bd4190 upstream.

I made a mistake with the commit a6aaa0032424 ("net: ethernet: stmmac:
fix altr_tse_pcs function when using a fixed-link"). I should have
tested against both scenario of having a SGMII interface and one
without.

Without the SGMII PCS TSE adpater, the sgmii_adapter_base address is
NULL, thus a write to this address will fail.

Cc: stable@vger.kernel.org
Fixes: a6aaa0032424 ("net: ethernet: stmmac: fix altr_tse_pcs function when using a fixed-link")
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
Link: https://lore.kernel.org/r/20220420152345.27415-1-dinguyen@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -65,8 +65,9 @@ static void socfpga_dwmac_fix_mac_speed(
 	struct phy_device *phy_dev = ndev->phydev;
 	u32 val;
 
-	writew(SGMII_ADAPTER_DISABLE,
-	       sgmii_adapter_base + SGMII_ADAPTER_CTRL_REG);
+	if (sgmii_adapter_base)
+		writew(SGMII_ADAPTER_DISABLE,
+		       sgmii_adapter_base + SGMII_ADAPTER_CTRL_REG);
 
 	if (splitter_base) {
 		val = readl(splitter_base + EMAC_SPLITTER_CTRL_REG);
@@ -88,10 +89,11 @@ static void socfpga_dwmac_fix_mac_speed(
 		writel(val, splitter_base + EMAC_SPLITTER_CTRL_REG);
 	}
 
-	writew(SGMII_ADAPTER_ENABLE,
-	       sgmii_adapter_base + SGMII_ADAPTER_CTRL_REG);
-	if (phy_dev)
+	if (phy_dev && sgmii_adapter_base) {
+		writew(SGMII_ADAPTER_ENABLE,
+		       sgmii_adapter_base + SGMII_ADAPTER_CTRL_REG);
 		tse_pcs_fix_mac_speed(&dwmac->pcs, phy_dev, speed);
+	}
 }
 
 static int socfpga_dwmac_parse_data(struct socfpga_dwmac *dwmac, struct device *dev)


