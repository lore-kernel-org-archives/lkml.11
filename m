Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CDFC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Apr 2022 20:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236839AbiDMUKX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Apr 2022 16:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235385AbiDMUKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 16:10:15 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0647B54E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 13:07:53 -0700 (PDT)
Received: from dslb-178-004-174-121.178.004.pools.vodafone-ip.de ([178.4.174.121] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nejHJ-0005wN-OK; Wed, 13 Apr 2022 22:07:49 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 1/4] staging: r8188eu: use ieee80211 helper to read the qos tid
Date:   Wed, 13 Apr 2022 22:07:39 +0200
Message-Id: <20220413200742.276806-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220413200742.276806-1-martin@kaiser.cx>
References: <20220413200742.276806-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the driver-specific GetPriority macro with ieee80211_get_tid,
which does exactly the same thing.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_recv.c | 2 +-
 drivers/staging/r8188eu/include/wifi.h  | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 91a6e0f035f4..16224476d18a 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -978,7 +978,7 @@ static int validate_recv_data_frame(struct adapter *adapter,
 	pattrib->ack_policy = 0;
 	/* parsing QC field */
 	if (pattrib->qos) {
-		pattrib->priority = GetPriority((ptr + 24));
+		pattrib->priority = ieee80211_get_tid(hdr);
 		pattrib->ack_policy = GetAckpolicy((ptr + 24));
 		pattrib->amsdu = GetAMsdu((ptr + 24));
 		pattrib->hdrlen = 26;
diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index b26770e91fc0..0254310bdf44 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -211,8 +211,6 @@ enum WIFI_REG_DOMAIN {
 #define SetPriority(pbuf, tid)	\
 	*(__le16 *)(pbuf) |= cpu_to_le16(tid & 0xf)
 
-#define GetPriority(pbuf)	((le16_to_cpu(*(__le16 *)(pbuf))) & 0xf)
-
 #define SetEOSP(pbuf, eosp)	\
 		*(__le16 *)(pbuf) |= cpu_to_le16((eosp & 1) << 4)
 
-- 
2.30.2

