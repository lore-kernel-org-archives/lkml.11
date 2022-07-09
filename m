Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B458EC433EF
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Jul 2022 17:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiGIRKx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Jul 2022 13:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiGIRK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 13:10:29 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149521A3AD
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 10:10:26 -0700 (PDT)
Received: from dslb-188-096-144-007.188.096.pools.vodafone-ip.de ([188.96.144.7] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oADyJ-0005n0-0S; Sat, 09 Jul 2022 19:10:23 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 13/14] staging: r8188eu: efuse_utilized is never read
Date:   Sat,  9 Jul 2022 19:09:59 +0200
Message-Id: <20220709171000.180481-14-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220709171000.180481-1-martin@kaiser.cx>
References: <20220709171000.180481-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The efuse_utilized variable in function efuse_phymap_to_logical is
written to but never read. Remove it.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 87ebfb013193..ddda3f994fa7 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -91,7 +91,6 @@ efuse_phymap_to_logical(u8 *phymap, u16 _size_byte, u8  *pbuf)
 	u8 offset, wren;
 	u16	i, j;
 	u16	**eFuseWord = NULL;
-	u16	efuse_utilized = 0;
 	u8 u1temp = 0;
 
 	efuseTbl = kzalloc(EFUSE_MAP_LEN_88E, GFP_KERNEL);
@@ -113,7 +112,6 @@ efuse_phymap_to_logical(u8 *phymap, u16 _size_byte, u8  *pbuf)
 	/*  */
 	rtemp8 = *(phymap + eFuse_Addr);
 	if (rtemp8 != 0xFF) {
-		efuse_utilized++;
 		eFuse_Addr++;
 	} else {
 		goto exit;
@@ -151,13 +149,11 @@ efuse_phymap_to_logical(u8 *phymap, u16 _size_byte, u8  *pbuf)
 				if (!(wren & 0x01)) {
 					rtemp8 = *(phymap + eFuse_Addr);
 					eFuse_Addr++;
-					efuse_utilized++;
 					eFuseWord[offset][i] = (rtemp8 & 0xff);
 					if (eFuse_Addr >= EFUSE_REAL_CONTENT_LEN_88E)
 						break;
 					rtemp8 = *(phymap + eFuse_Addr);
 					eFuse_Addr++;
-					efuse_utilized++;
 					eFuseWord[offset][i] |= (((u16)rtemp8 << 8) & 0xff00);
 
 					if (eFuse_Addr >= EFUSE_REAL_CONTENT_LEN_88E)
@@ -170,7 +166,6 @@ efuse_phymap_to_logical(u8 *phymap, u16 _size_byte, u8  *pbuf)
 		rtemp8 = *(phymap + eFuse_Addr);
 
 		if (rtemp8 != 0xFF && (eFuse_Addr < EFUSE_REAL_CONTENT_LEN_88E)) {
-			efuse_utilized++;
 			eFuse_Addr++;
 		}
 	}
@@ -190,10 +185,6 @@ efuse_phymap_to_logical(u8 *phymap, u16 _size_byte, u8  *pbuf)
 	/*  */
 	memcpy(pbuf, efuseTbl, _size_byte);
 
-	/*  */
-	/*  5. Calculate Efuse utilization. */
-	/*  */
-
 exit:
 	kfree(efuseTbl);
 	kfree(eFuseWord);
-- 
2.30.2

