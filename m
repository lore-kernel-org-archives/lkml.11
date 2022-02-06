Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54D1C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Feb 2022 16:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244743AbiBFQSb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Feb 2022 11:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239973AbiBFQSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 11:18:24 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C1BC043185
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 08:18:23 -0800 (PST)
Received: from ipservice-092-217-075-184.092.217.pools.vodafone-ip.de ([92.217.75.184] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nGkF0-0001bS-TB; Sun, 06 Feb 2022 17:18:18 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 02/14] staging: r8188eu: only OFDM_index[0] is used
Date:   Sun,  6 Feb 2022 17:17:57 +0100
Message-Id: <20220206161809.423031-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220206161809.423031-1-martin@kaiser.cx>
References: <20220206161809.423031-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the OFDM_index array in struct odm_rf_cal with a single variable.
Only its first component is used.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c | 4 ++--
 drivers/staging/r8188eu/include/odm.h        | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
index 08db24614ed1..8b3bc41b7e27 100644
--- a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
+++ b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
@@ -169,7 +169,7 @@ odm_TXPowerTrackingCallback_ThermalMeter_8188E(
 			dm_odm->RFCalibrateInfo.ThermalValue_LCK = ThermalValue;
 			dm_odm->RFCalibrateInfo.ThermalValue_IQK = ThermalValue;
 
-			dm_odm->RFCalibrateInfo.OFDM_index[0] = OFDM_index_old;
+			dm_odm->RFCalibrateInfo.OFDM_index = OFDM_index_old;
 			dm_odm->RFCalibrateInfo.CCK_index = CCK_index_old;
 		}
 
@@ -234,7 +234,7 @@ odm_TXPowerTrackingCallback_ThermalMeter_8188E(
 			}
 			if (offset >= index_mapping_NUM_88E)
 				offset = index_mapping_NUM_88E - 1;
-			OFDM_index[0] = dm_odm->RFCalibrateInfo.OFDM_index[0] + OFDM_index_mapping[j][offset];
+			OFDM_index[0] = dm_odm->RFCalibrateInfo.OFDM_index + OFDM_index_mapping[j][offset];
 			CCK_index = dm_odm->RFCalibrateInfo.CCK_index + OFDM_index_mapping[j][offset];
 
 			if (OFDM_index[0] > OFDM_TABLE_SIZE_92D - 1)
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index f7f85ca05bd3..698d61d5fc40 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -254,7 +254,7 @@ struct odm_rf_cal {
 
 	u8	bCCKinCH14;
 	u8	CCK_index;
-	u8	OFDM_index[2];
+	u8	OFDM_index;
 	bool bDoneTxpower;
 
 	u8	ThermalValue_HP[HP_THERMAL_NUM];
-- 
2.30.2

