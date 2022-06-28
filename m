Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F01C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jun 2022 12:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345621AbiF1MXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jun 2022 08:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345666AbiF1MXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:23:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6807B12636;
        Tue, 28 Jun 2022 05:23:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0561160FC7;
        Tue, 28 Jun 2022 12:23:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D657C341CE;
        Tue, 28 Jun 2022 12:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656418993;
        bh=bw4JxdKBLg5YZjdvIpofcV0Tb/wNIuvBvilj7qW7zR0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NlG8+Oki4S49DTX5lyXPrUoA0zvZXhni38IAMJwdfhYUd4J+oLh2DRXIkSVheOAti
         yJFyC5rKCtSd6XL0SVdjXDRLEqdXlcGge+Mwh0dDaXyOWSXJOizEiMqmOx8QnQE6SV
         y9qpA8gxoEag9lZ29lEgdyf+C5RnI3G9pZNKtJsSh6FDL/lMXyVtGa+kQU+5AUzolR
         rsq5m0DCeBMhlZ2ccc0lZ64mEmmjJu6rgHpZpJoO3cJpKF2kWQozMRZn4cNf+Qnkj0
         FuriCOXpjGQDOu4frPjvIGlJTRSrHZYySz4plDp1O67yom+/0ScHw0f1xZIBAnVBlL
         dyoUGJlFHAAIQ==
From:   Roger Quadros <rogerq@kernel.org>
To:     kishon@ti.com, vkoul@kernel.org
Cc:     vigneshr@ti.com, t-patil@ti.com, sjakhade@cadence.com,
        s-vadapalli@ti.com, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 1/7] phy: ti: phy-j721e-wiz: Add SGMII support in wiz driver for J7200
Date:   Tue, 28 Jun 2022 15:22:49 +0300
Message-Id: <20220628122255.24265-2-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220628122255.24265-1-rogerq@kernel.org>
References: <20220628122255.24265-1-rogerq@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Siddharth Vadapalli <s-vadapalli@ti.com>

Select the same mac divider for SGMII too as the one being used for
QSGMII.

Enable full rate divider configuration support for J721E_WIZ_10G for
SGMII.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/phy/ti/phy-j721e-wiz.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index 70bac931f99a..8c10ee8e2707 100644
--- a/drivers/phy/ti/phy-j721e-wiz.c
+++ b/drivers/phy/ti/phy-j721e-wiz.c
@@ -325,7 +325,8 @@ static int wiz_p_mac_div_sel(struct wiz *wiz)
 	int i;
 
 	for (i = 0; i < num_lanes; i++) {
-		if (wiz->lane_phy_type[i] == PHY_TYPE_QSGMII) {
+		if (wiz->lane_phy_type[i] == PHY_TYPE_SGMII ||
+		    wiz->lane_phy_type[i] == PHY_TYPE_QSGMII) {
 			ret = regmap_field_write(wiz->p_mac_div_sel0[i], 1);
 			if (ret)
 				return ret;
@@ -1025,12 +1026,18 @@ static int wiz_phy_reset_assert(struct reset_controller_dev *rcdev,
 
 static int wiz_phy_fullrt_div(struct wiz *wiz, int lane)
 {
-	if (wiz->type != AM64_WIZ_10G)
+	switch (wiz->type) {
+	case AM64_WIZ_10G:
+		if (wiz->lane_phy_type[lane] == PHY_TYPE_PCIE)
+			return regmap_field_write(wiz->p0_fullrt_div[lane], 0x1);
+		break;
+	case J721E_WIZ_10G:
+		if (wiz->lane_phy_type[lane] == PHY_TYPE_SGMII)
+			return regmap_field_write(wiz->p0_fullrt_div[lane], 0x2);
+		break;
+	default:
 		return 0;
-
-	if (wiz->lane_phy_type[lane] == PHY_TYPE_PCIE)
-		return regmap_field_write(wiz->p0_fullrt_div[lane], 0x1);
-
+	}
 	return 0;
 }
 
-- 
2.17.1

