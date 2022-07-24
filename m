Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053C0C43334
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jul 2022 16:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbiGXQPF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jul 2022 12:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGXQPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 12:15:03 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83E1E0A9
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 09:15:02 -0700 (PDT)
Received: from dslb-178-004-201-227.178.004.pools.vodafone-ip.de ([178.4.201.227] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oFeFs-0004kT-UO; Sun, 24 Jul 2022 18:14:57 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH] staging: r8188eu: handle errors from ReadAdapterInfo8188EU
Date:   Sun, 24 Jul 2022 18:14:05 +0200
Message-Id: <20220724161405.146488-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update ReadAdapterInfo8188EU to return 0 for success or a negative
error code. Don't use the infamous _SUCCESS and _FAIL defines.

Handle returned errors in rtw_usb_if1_init, this will eventually fail the
probing of the r8188eu driver.

Suggested-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/usb_halinit.c  | 7 ++++---
 drivers/staging/r8188eu/include/hal_intf.h | 2 +-
 drivers/staging/r8188eu/os_dep/usb_intf.c  | 3 ++-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 421fe7c40390..08d4b5dfd430 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -922,7 +922,7 @@ static void Hal_EfuseParseMACAddr_8188EU(struct adapter *adapt, u8 *hwinfo, bool
 	}
 }
 
-void ReadAdapterInfo8188EU(struct adapter *Adapter)
+int ReadAdapterInfo8188EU(struct adapter *Adapter)
 {
 	struct eeprom_priv *eeprom = &Adapter->eeprompriv;
 	struct led_priv *ledpriv = &Adapter->ledpriv;
@@ -933,13 +933,13 @@ void ReadAdapterInfo8188EU(struct adapter *Adapter)
 	/* check system boot selection */
 	res = rtw_read8(Adapter, REG_9346CR, &eeValue);
 	if (res)
-		return;
+		return -1;
 
 	eeprom->bautoload_fail_flag	= !(eeValue & EEPROM_EN);
 
 	efuse_buf = kmalloc(EFUSE_MAP_LEN_88E, GFP_KERNEL);
 	if (!efuse_buf)
-		return;
+		return -1;
 	memset(efuse_buf, 0xFF, EFUSE_MAP_LEN_88E);
 
 	if (!(eeValue & BOOT_FROM_EEPROM) && !eeprom->bautoload_fail_flag) {
@@ -961,6 +961,7 @@ void ReadAdapterInfo8188EU(struct adapter *Adapter)
 
 	ledpriv->bRegUseLed = true;
 	kfree(efuse_buf);
+	return 0;
 }
 
 static void ResumeTxBeacon(struct adapter *adapt)
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 819d0dc6e6dc..985dffeef2cd 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -16,7 +16,7 @@ enum hw_variables {
 typedef s32 (*c2h_id_filter)(u8 id);
 
 void rtl8188eu_interface_configure(struct adapter *adapt);
-void ReadAdapterInfo8188EU(struct adapter *Adapter);
+int ReadAdapterInfo8188EU(struct adapter *Adapter);
 void rtl8188eu_init_default_value(struct adapter *adapt);
 void rtl8188e_SetHalODMVar(struct adapter *Adapter, void *pValue1, bool bSet);
 u32 rtl8188eu_InitPowerOn(struct adapter *adapt);
diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index cc2b44f60c46..e1a0447fd1e7 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -332,7 +332,8 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
 	rtl8188eu_interface_configure(padapter);
 
 	/* step read efuse/eeprom data and get mac_addr */
-	ReadAdapterInfo8188EU(padapter);
+	if (ReadAdapterInfo8188EU(padapter) < 0)
+		goto handle_dualmac;
 
 	/* step 5. */
 	if (rtw_init_drv_sw(padapter) == _FAIL)
-- 
2.30.2

