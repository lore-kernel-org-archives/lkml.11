Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B14BC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Mar 2022 16:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245418AbiCWQLC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Mar 2022 12:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242576AbiCWQKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 12:10:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC0C3BBF6;
        Wed, 23 Mar 2022 09:09:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E587A210F4;
        Wed, 23 Mar 2022 16:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648051754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v1gC/BVBIa1Xfifse2nE7QJfA8miYTDk4vkup9+NIjY=;
        b=C3ONuA0M9m0xSMP7h5wJNQO1qfxtOpKzCvTPY7tzZZF/CjbLpucGBNI2rkLLCrMvzIPS+7
        jG6/3wQ8b/xCNoQTfgntFNH1OKNQ3k124NSFoMtVrLiyQgocFoj4kKlpiBiyIF7o1QWXCS
        EmSVWpi4qSqbq+Cq8ny01WLKBI4l0Rg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648051754;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v1gC/BVBIa1Xfifse2nE7QJfA8miYTDk4vkup9+NIjY=;
        b=Zm1/gROUSIjTX/3oIUsZfLWgPlzM9jEIILcBpOdCjSyjs5Di/QxLQJ2aaxJzesTYoWIDBR
        7ObKh3C7eCL1+yAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D898512FC5;
        Wed, 23 Mar 2022 16:09:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iKSPNCpGO2IgfgAAMHmgww
        (envelope-from <iivanov@suse.de>); Wed, 23 Mar 2022 16:09:14 +0000
From:   "Ivan T. Ivanov" <iivanov@suse.de>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Dom Cobley <popcornmix@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Ivan T . Ivanov" <iivanov@suse.de>
Subject: [PATCH 2/3] clk-raspberrypi: Support VEC clock
Date:   Wed, 23 Mar 2022 18:08:58 +0200
Message-Id: <20220323160859.69572-3-iivanov@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220323160859.69572-1-iivanov@suse.de>
References: <20220323160859.69572-1-iivanov@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dom Cobley <popcornmix@gmail.com>

Signed-off-by: Dom Cobley <popcornmix@gmail.com>
Signed-off-by: Ivan T. Ivanov <iivanov@suse.de>
---
 drivers/clk/bcm/clk-raspberrypi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index 9f08baef39ba..240128939d57 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -33,6 +33,7 @@ enum rpi_firmware_clk_id {
 	RPI_FIRMWARE_EMMC2_CLK_ID,
 	RPI_FIRMWARE_M2MC_CLK_ID,
 	RPI_FIRMWARE_PIXEL_BVB_CLK_ID,
+	RPI_FIRMWARE_VEC_CLK_ID,
 	RPI_FIRMWARE_NUM_CLK_ID,
 };
 
@@ -51,6 +52,7 @@ static char *rpi_firmware_clk_names[] = {
 	[RPI_FIRMWARE_EMMC2_CLK_ID]	= "emmc2",
 	[RPI_FIRMWARE_M2MC_CLK_ID]	= "m2mc",
 	[RPI_FIRMWARE_PIXEL_BVB_CLK_ID]	= "pixel-bvb",
+	[RPI_FIRMWARE_VEC_CLK_ID]	= "vec",
 };
 
 #define RPI_FIRMWARE_STATE_ENABLE_BIT	BIT(0)
@@ -273,6 +275,7 @@ static int raspberrypi_discover_clocks(struct raspberrypi_clk *rpi,
 		case RPI_FIRMWARE_V3D_CLK_ID:
 		case RPI_FIRMWARE_HEVC_CLK_ID:
 		case RPI_FIRMWARE_PIXEL_BVB_CLK_ID:
+		case RPI_FIRMWARE_VEC_CLK_ID:
 			hw = raspberrypi_clk_register(rpi, clks->parent,
 						      clks->id);
 			if (IS_ERR(hw))
-- 
2.26.2

