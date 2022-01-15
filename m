Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70988C433FE
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jan 2022 16:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbiAOQ4D (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jan 2022 11:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbiAOQz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 11:55:56 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51B0C06161C
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 08:55:55 -0800 (PST)
Received: from dslb-178-004-201-171.178.004.pools.vodafone-ip.de ([178.4.201.171] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1n8mLH-0005N8-Pu; Sat, 15 Jan 2022 17:55:51 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 03/11] staging: r8188eu: remove unused bitshift function
Date:   Sat, 15 Jan 2022 17:55:28 +0100
Message-Id: <20220115165536.231210-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220115165536.231210-1-martin@kaiser.cx>
References: <20220115165536.231210-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bitshift function from osdep_service.h is not used.
Remove it.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/include/osdep_service.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/staging/r8188eu/include/osdep_service.h b/drivers/staging/r8188eu/include/osdep_service.h
index 2f6b8acd0a10..6d03e135d1e3 100644
--- a/drivers/staging/r8188eu/include/osdep_service.h
+++ b/drivers/staging/r8188eu/include/osdep_service.h
@@ -163,15 +163,6 @@ static inline u32 _RND512(u32 sz)
 	return val;
 }
 
-static inline u32 bitshift(u32 bitmask)
-{
-	u32 i;
-
-	for (i = 0; i <= 31; i++)
-		if (((bitmask>>i) &  0x1) == 1) break;
-	return i;
-}
-
 /*  limitation of path length */
 #define PATH_LENGTH_MAX PATH_MAX
 
-- 
2.30.2

