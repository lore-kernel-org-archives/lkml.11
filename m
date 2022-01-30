Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA07AC433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jan 2022 18:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354696AbiA3SXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jan 2022 13:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347090AbiA3SXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 13:23:03 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E203EC061714
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 10:23:02 -0800 (PST)
Received: from ipservice-092-217-087-009.092.217.pools.vodafone-ip.de ([92.217.87.9] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nEEqn-0008B8-VJ; Sun, 30 Jan 2022 19:22:58 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH] staging: r8188eu: clean up phy_BB8188E_Config_ParaFile
Date:   Sun, 30 Jan 2022 19:22:49 +0100
Message-Id: <20220130182249.712034-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up the code of the phy_BB8188E_Config_ParaFile function.

Replace a TAB with a space in the function definition.

Put the HAL_STATUS_FAILURE on the right-hand side of the comparisons.

Simplify the error handling. Exit directly if we detect an error.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
This should be applied on top of
[PATCH] staging: rt8188eu: Remove dead code.

 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c | 20 ++++++-------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
index 41a0d7f0d29f..f1cd220ea20b 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
@@ -483,20 +483,17 @@ void storePwrIndexDiffRateOffset(struct adapter *Adapter, u32 RegAddr, u32 BitMa
 		pHalData->MCSTxPowerLevelOriginalOffset[pHalData->pwrGroupCnt][13] = Data;
 }
 
-static	int phy_BB8188E_Config_ParaFile(struct adapter *Adapter)
+static int phy_BB8188E_Config_ParaFile(struct adapter *Adapter)
 {
 	struct eeprom_priv *pEEPROM = &Adapter->eeprompriv;
 	struct hal_data_8188e *pHalData = &Adapter->haldata;
-	int			rtStatus = _SUCCESS;
 
 	/*  */
 	/*  1. Read PHY_REG.TXT BB INIT!! */
 	/*  We will separate as 88C / 92C according to chip version */
 	/*  */
-	if (HAL_STATUS_FAILURE == ODM_ReadAndConfig_PHY_REG_1T_8188E(&pHalData->odmpriv))
-		rtStatus = _FAIL;
-	if (rtStatus != _SUCCESS)
-		goto phy_BB8190_Config_ParaFile_Fail;
+	if (ODM_ReadAndConfig_PHY_REG_1T_8188E(&pHalData->odmpriv) == HAL_STATUS_FAILURE)
+		return _FAIL;
 
 	/*  2. If EEPROM or EFUSE autoload OK, We must config by PHY_REG_PG.txt */
 	if (!pEEPROM->bautoload_fail_flag) {
@@ -505,15 +502,10 @@ static	int phy_BB8188E_Config_ParaFile(struct adapter *Adapter)
 	}
 
 	/*  3. BB AGC table Initialization */
-	if (HAL_STATUS_FAILURE == ODM_ReadAndConfig_AGC_TAB_1T_8188E(&pHalData->odmpriv))
-		rtStatus = _FAIL;
-
-	if (rtStatus != _SUCCESS)
-		goto phy_BB8190_Config_ParaFile_Fail;
+	if (ODM_ReadAndConfig_AGC_TAB_1T_8188E(&pHalData->odmpriv) == HAL_STATUS_FAILURE)
+		return _FAIL;
 
-phy_BB8190_Config_ParaFile_Fail:
-
-	return rtStatus;
+	return _SUCCESS;
 }
 
 int
-- 
2.30.2

