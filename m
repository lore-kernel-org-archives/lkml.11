Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DE0C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Mar 2022 11:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235578AbiC2LLP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Mar 2022 07:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbiC2LLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 07:11:11 -0400
Received: from mail.meizu.com (edge07.meizu.com [112.91.151.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD77E35DEB
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 04:09:27 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail11.meizu.com
 (172.16.1.15) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 29 Mar
 2022 19:09:20 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Tue, 29 Mar
 2022 19:09:19 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Haowen Bai <baihaowen@meizu.com>, <linux-staging@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH V3] staging: r8188eu: Directly return _SUCCESS instead of using local ret variable
Date:   Tue, 29 Mar 2022 19:09:17 +0800
Message-ID: <1648552158-24203-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1648551967-23627-1-git-send-email-baihaowen@meizu.com>
References: <1648551967-23627-1-git-send-email-baihaowen@meizu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-124.meizu.com (172.16.1.124) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As init_mlme_ext_priv function always returns SUCCESS , We can change
return type from int to void.

fixes coccinelle warning:
./drivers/staging/r8188eu/core/rtw_mlme_ext.c:357:5-8: Unneeded variable: "res".
 Return "_SUCCESS" on line 380

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
V1->V2: split into two patches.
V2->V3: change return type from int to void.

 drivers/staging/r8188eu/core/rtw_mlme_ext.c    | 5 +----
 drivers/staging/r8188eu/include/rtw_mlme_ext.h | 2 +-
 drivers/staging/r8188eu/os_dep/os_intfs.c      | 8 +-------
 3 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 10d5f12..ff48293 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -352,9 +352,8 @@ static u8 init_channel_set(struct adapter *padapter, u8 ChannelPlan, struct rt_c
 	return chanset_size;
 }
 
-int	init_mlme_ext_priv(struct adapter *padapter)
+void init_mlme_ext_priv(struct adapter *padapter)
 {
-	int	res = _SUCCESS;
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
@@ -376,8 +375,6 @@ int	init_mlme_ext_priv(struct adapter *padapter)
 	pmlmeext->mlmeext_init = true;
 
 	pmlmeext->active_keep_alive_check = true;
-
-	return res;
 }
 
 void free_mlme_ext_priv(struct mlme_ext_priv *pmlmeext)
diff --git a/drivers/staging/r8188eu/include/rtw_mlme_ext.h b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
index 0c555ea..827ac6c 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
@@ -419,7 +419,7 @@ struct mlme_ext_priv {
 	u8 active_keep_alive_check;
 };
 
-int init_mlme_ext_priv(struct adapter *adapter);
+void init_mlme_ext_priv(struct adapter *adapter);
 int init_hw_mlme_ext(struct adapter *padapter);
 void free_mlme_ext_priv (struct mlme_ext_priv *pmlmeext);
 extern void init_mlme_ext_timer(struct adapter *padapter);
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index 550721e..ca1c4df 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -490,10 +490,7 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
 	init_wifidirect_info(padapter, P2P_ROLE_DISABLE);
 	reset_global_wifidirect_info(padapter);
 
-	if (init_mlme_ext_priv(padapter) == _FAIL) {
-		dev_err(dvobj_to_dev(padapter->dvobj), "init_mlme_ext_priv failed\n");
-		goto free_mlme_priv;
-	}
+	init_mlme_ext_priv(padapter);
 
 	if (_rtw_init_xmit_priv(&padapter->xmitpriv, padapter) == _FAIL) {
 		dev_err(dvobj_to_dev(padapter->dvobj), "_rtw_init_xmit_priv failed\n");
@@ -534,9 +531,6 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
 free_mlme_ext:
 	free_mlme_ext_priv(&padapter->mlmeextpriv);
 
-free_mlme_priv:
-	rtw_free_mlme_priv(&padapter->mlmepriv);
-
 free_evt_priv:
 	rtw_free_evt_priv(&padapter->evtpriv);
 
-- 
2.7.4

