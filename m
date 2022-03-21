Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739C1C433FE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Mar 2022 16:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350917AbiCUQOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Mar 2022 12:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350839AbiCUQN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:13:59 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A4C6E4D0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=Z0ms4mMQwbIM4H
        QhkKakBorBxsTnuxIwIQiCY9Zd7nk=; b=itcfh13I0lM/2B2cDrZlVAVsX8H2dX
        TrgshuvEA+wui2FBdGV4TwWqZqvr6NeAwAi8/BC03+zMLCDW0Fa2Se8r5nLg1HIJ
        Z3c2D1AyL0qvhc1WgoIIbYXIpXOHWKILeCbIvBPsBYtoiBdNsjYZKH3zsa3POxvi
        EPeJgL06eBVjA=
Received: (qmail 957797 invoked from network); 21 Mar 2022 17:12:31 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 21 Mar 2022 17:12:31 +0100
X-UD-Smtp-Session: l3s3148p1@bF9vw7zaItkgAwDPXxCoAIeNYiWy88zT
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 06/15] mfd: use new name 'usleep_autoyield' instead of 'fsleep'
Date:   Mon, 21 Mar 2022 17:12:14 +0100
Message-Id: <20220321161223.2837-7-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220321161223.2837-1-wsa+renesas@sang-engineering.com>
References: <20220321161223.2837-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function was just renamed to be easier understandable. No functional
change.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
RFC, please do not apply yet

 drivers/mfd/acer-ec-a500.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/acer-ec-a500.c b/drivers/mfd/acer-ec-a500.c
index 80c2fdd14fc4..b3155c7b0559 100644
--- a/drivers/mfd/acer-ec-a500.c
+++ b/drivers/mfd/acer-ec-a500.c
@@ -59,7 +59,7 @@ static int a500_ec_read(void *context, const void *reg_buf, size_t reg_size,
 	*ret_val = ret;
 
 	if (reg == REG_CURRENT_NOW)
-		fsleep(10000);
+		usleep_autoyield(10000);
 
 	return 0;
 }
-- 
2.34.1

