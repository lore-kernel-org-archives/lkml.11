Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40C2C433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Feb 2022 16:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244793AbiBFQSe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Feb 2022 11:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242793AbiBFQSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 11:18:24 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40059C043186
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 08:18:23 -0800 (PST)
Received: from ipservice-092-217-075-184.092.217.pools.vodafone-ip.de ([92.217.75.184] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nGkF1-0001bS-MF; Sun, 06 Feb 2022 17:18:19 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 03/14] staging: r8188eu: replace local OFDM_index with single variable
Date:   Sun,  6 Feb 2022 17:17:58 +0100
Message-Id: <20220206161809.423031-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220206161809.423031-1-martin@kaiser.cx>
References: <20220206161809.423031-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the local OFDM_index array in the
odm_TXPowerTrackingCallback_ThermalMeter_8188E function
with a single variable. Only its first component is used.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
index 8b3bc41b7e27..27cac9775a90 100644
--- a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
+++ b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
@@ -103,7 +103,7 @@ odm_TXPowerTrackingCallback_ThermalMeter_8188E(
 	u8 ThermalValue_AVG_count = 0;
 	u32 ThermalValue_AVG = 0;
 	s32 ele_D, TempCCk;
-	s8 OFDM_index[2], CCK_index = 0;
+	s8 OFDM_index, CCK_index = 0;
 	s8 OFDM_index_old = 0, CCK_index_old = 0;
 	u32 i = 0, j = 0;
 
@@ -234,13 +234,13 @@ odm_TXPowerTrackingCallback_ThermalMeter_8188E(
 			}
 			if (offset >= index_mapping_NUM_88E)
 				offset = index_mapping_NUM_88E - 1;
-			OFDM_index[0] = dm_odm->RFCalibrateInfo.OFDM_index + OFDM_index_mapping[j][offset];
+			OFDM_index = dm_odm->RFCalibrateInfo.OFDM_index + OFDM_index_mapping[j][offset];
 			CCK_index = dm_odm->RFCalibrateInfo.CCK_index + OFDM_index_mapping[j][offset];
 
-			if (OFDM_index[0] > OFDM_TABLE_SIZE_92D - 1)
-				OFDM_index[0] = OFDM_TABLE_SIZE_92D - 1;
-			else if (OFDM_index[0] < OFDM_min_index)
-				OFDM_index[0] = OFDM_min_index;
+			if (OFDM_index > OFDM_TABLE_SIZE_92D - 1)
+				OFDM_index = OFDM_TABLE_SIZE_92D - 1;
+			else if (OFDM_index < OFDM_min_index)
+				OFDM_index = OFDM_min_index;
 
 			if (CCK_index > CCK_TABLE_SIZE - 1)
 				CCK_index = CCK_TABLE_SIZE - 1;
@@ -253,7 +253,7 @@ odm_TXPowerTrackingCallback_ThermalMeter_8188E(
 				dm_odm->RFCalibrateInfo.bDoneTxpower = true;
 
 				/*  Revse TX power table. */
-				dm_odm->BbSwingIdxOfdm		= (u8)OFDM_index[0];
+				dm_odm->BbSwingIdxOfdm		= (u8)OFDM_index;
 				dm_odm->BbSwingIdxCck		= (u8)CCK_index;
 
 				if (dm_odm->BbSwingIdxOfdmCurrent != dm_odm->BbSwingIdxOfdm) {
-- 
2.30.2

