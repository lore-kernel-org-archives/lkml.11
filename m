Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A6AC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Mar 2022 09:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238036AbiCNJ3z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Mar 2022 05:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237982AbiCNJ3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 05:29:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE94B3F8AB;
        Mon, 14 Mar 2022 02:28:21 -0700 (PDT)
Date:   Mon, 14 Mar 2022 09:28:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647250100;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JQiVHaFzav7HcxV1PnBHQU2vB7sMtXYWohR6/yhkIQA=;
        b=PTKscyzG5rfszLunE162DPMkbq3xBE2SQqHJvCr9LXrWTWgprmjuuhNr5FAT7azNXH7tLT
        CXSo5V2P/GxYxln0c58vFoV7iI1EDM9WnzbrzlC3Wisv5PHQWe3RifDEhfyXF/jco58SUq
        ntRA5of/nPQM5HOOyfbozxCeBP4cbL07ZDwa6k8C7MeOvp6ovMKdSiOMb9naOee+yP4NXj
        CHubYxwKwN7kNYvkdGULeUT/JFCTKSUsb1luzJTbovks6nUS3PbQyOcUrHpXMubKlxTgie
        B3pcuYpLoScUIFf+162qLtlwQcWsSUF0ZIC8oQck0ksEAzEeSrzwM3iG7A8qIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647250100;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JQiVHaFzav7HcxV1PnBHQU2vB7sMtXYWohR6/yhkIQA=;
        b=ahW3zuPicYF0HEjd7399d7z80S2d6bsBFpwVMFxf17Y7Y8J1P292NxUcvqPkyxWxi47RIs
        BF3pxVDbiU7XFLCw==
From:   "tip-bot2 for Claudiu Beznea" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-microchip-pit64b: Use
 5MHz for clockevent
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220304133601.2404086-4-claudiu.beznea@microchip.com>
References: <20220304133601.2404086-4-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Message-ID: <164725009936.16921.9315404177053448675.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     389e3bff69b4341b42779833063c7b462a6e6d42
Gitweb:        https://git.kernel.org/tip/389e3bff69b4341b42779833063c7b462a6e6d42
Author:        Claudiu Beznea <claudiu.beznea@microchip.com>
AuthorDate:    Fri, 04 Mar 2022 15:35:58 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 07 Mar 2022 18:27:34 +01:00

clocksource/drivers/timer-microchip-pit64b: Use 5MHz for clockevent

Use 5MHz clock for clockevent timers. This increases timer's
resolution.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Link: https://lore.kernel.org/r/20220304133601.2404086-4-claudiu.beznea@microchip.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-microchip-pit64b.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/timer-microchip-pit64b.c b/drivers/clocksource/timer-microchip-pit64b.c
index 790d2c9..abce83d 100644
--- a/drivers/clocksource/timer-microchip-pit64b.c
+++ b/drivers/clocksource/timer-microchip-pit64b.c
@@ -42,8 +42,7 @@
 #define MCHP_PIT64B_LSBMASK		GENMASK_ULL(31, 0)
 #define MCHP_PIT64B_PRES_TO_MODE(p)	(MCHP_PIT64B_MR_PRES & ((p) << 8))
 #define MCHP_PIT64B_MODE_TO_PRES(m)	((MCHP_PIT64B_MR_PRES & (m)) >> 8)
-#define MCHP_PIT64B_DEF_CS_FREQ		5000000UL	/* 5 MHz */
-#define MCHP_PIT64B_DEF_CE_FREQ		32768		/* 32 KHz */
+#define MCHP_PIT64B_DEF_FREQ		5000000UL	/* 5 MHz */
 
 #define MCHP_PIT64B_NAME		"pit64b"
 
@@ -418,7 +417,6 @@ static int __init mchp_pit64b_init_clkevt(struct mchp_pit64b_timer *timer,
 static int __init mchp_pit64b_dt_init_timer(struct device_node *node,
 					    bool clkevt)
 {
-	u32 freq = clkevt ? MCHP_PIT64B_DEF_CE_FREQ : MCHP_PIT64B_DEF_CS_FREQ;
 	struct mchp_pit64b_timer timer;
 	unsigned long clk_rate;
 	u32 irq = 0;
@@ -446,7 +444,7 @@ static int __init mchp_pit64b_dt_init_timer(struct device_node *node,
 	}
 
 	/* Initialize mode (prescaler + SGCK bit). To be used at runtime. */
-	ret = mchp_pit64b_init_mode(&timer, freq);
+	ret = mchp_pit64b_init_mode(&timer, MCHP_PIT64B_DEF_FREQ);
 	if (ret)
 		goto irq_unmap;
 
