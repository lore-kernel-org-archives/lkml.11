Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42FEC433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jun 2022 09:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351064AbiFAJal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jun 2022 05:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347828AbiFAJab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 05:30:31 -0400
Received: from mail.meizu.com (unknown [14.29.68.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F76E81999
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 02:30:27 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail04.meizu.com
 (172.16.1.16) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 1 Jun 2022
 17:30:29 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Wed, 1 Jun
 2022 17:30:24 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Haowen Bai <baihaowen@meizu.com>, <linux-staging@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] staging: r8188eu: Drop redundant memset
Date:   Wed, 1 Jun 2022 17:30:22 +0800
Message-ID: <1654075823-9154-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The region set by the call to memset is immediately overwritten by the
subsequent call to memcpy. So we drop redundant memset.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 drivers/staging/r8188eu/core/rtw_ioctl_set.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ioctl_set.c b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
index 7ba75f73e47e..17f6bcbeebf4 100644
--- a/drivers/staging/r8188eu/core/rtw_ioctl_set.c
+++ b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
@@ -71,7 +71,6 @@ u8 rtw_do_join(struct adapter *padapter)
 
 				pibss = padapter->registrypriv.dev_network.MacAddress;
 
-				memset(&pdev_network->Ssid, 0, sizeof(struct ndis_802_11_ssid));
 				memcpy(&pdev_network->Ssid, &pmlmepriv->assoc_ssid, sizeof(struct ndis_802_11_ssid));
 
 				rtw_update_registrypriv_dev_network(padapter);
-- 
2.7.4

