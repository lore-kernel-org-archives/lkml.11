Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0740AC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Feb 2022 11:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235439AbiB1LT3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Feb 2022 06:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbiB1LTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 06:19:09 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D783525A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 03:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646047110; x=1677583110;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lUQnn0zVy+bE/xhgO9ACVEqiKnempNvpK91uF2dQ9T0=;
  b=ohGkoTCuAaptfoD/td3gmWBXur9ctFcnShf+y5wH1m6hDd0BrLel5U4F
   0+sCKGizN05EsYWgFos+5W+5cX2B0UTXUyaJFEGyG4H349T93rbhN5WtN
   gwCzTiYSWd7EpgaIbH3mzrj+VA0+o3IN+dEYalsafQNNIC2NFLu6JTR3a
   f0jo5//rJG8UYN43GEGjwb8VsHB7IWV4mbLMx40QLroPwKpg24IYht+Gl
   CK+OJonUmEeLUny91u+CFxWbTTELeS9fTl2Cyt4Lrg9YBm0BnRTqkwr+3
   SIgPw9Rb30zFWokfEumZHp2r8ZVwLFo3u8SVTVxZmunUZ+Of3uYy+B5Xt
   g==;
X-IronPort-AV: E=Sophos;i="5.90,142,1643698800"; 
   d="scan'208";a="155099464"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Feb 2022 04:18:30 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 28 Feb 2022 04:18:29 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 28 Feb 2022 04:18:28 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 5/7] clocksource/drivers/timer-microchip-pit64b: add delay timer
Date:   Mon, 28 Feb 2022 13:19:21 +0200
Message-ID: <20220228111923.1400049-6-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220228111923.1400049-1-claudiu.beznea@microchip.com>
References: <20220228111923.1400049-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add delay timer.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clocksource/timer-microchip-pit64b.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/clocksource/timer-microchip-pit64b.c b/drivers/clocksource/timer-microchip-pit64b.c
index abce83d2f00b..f1b211ee6312 100644
--- a/drivers/clocksource/timer-microchip-pit64b.c
+++ b/drivers/clocksource/timer-microchip-pit64b.c
@@ -9,6 +9,7 @@
 
 #include <linux/clk.h>
 #include <linux/clockchips.h>
+#include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
@@ -92,6 +93,8 @@ struct mchp_pit64b_clksrc {
 static void __iomem *mchp_pit64b_cs_base;
 /* Default cycles for clockevent timer. */
 static u64 mchp_pit64b_ce_cycles;
+/* Delay timer. */
+static struct delay_timer mchp_pit64b_dt;
 
 static inline u64 mchp_pit64b_cnt_read(void __iomem *base)
 {
@@ -169,6 +172,11 @@ static u64 notrace mchp_pit64b_sched_read_clk(void)
 	return mchp_pit64b_cnt_read(mchp_pit64b_cs_base);
 }
 
+static unsigned long notrace mchp_pit64b_dt_read(void)
+{
+	return mchp_pit64b_cnt_read(mchp_pit64b_cs_base);
+}
+
 static int mchp_pit64b_clkevt_shutdown(struct clock_event_device *cedev)
 {
 	struct mchp_pit64b_timer *timer = clkevt_to_mchp_pit64b_timer(cedev);
@@ -371,6 +379,10 @@ static int __init mchp_pit64b_init_clksrc(struct mchp_pit64b_timer *timer,
 
 	sched_clock_register(mchp_pit64b_sched_read_clk, 64, clk_rate);
 
+	mchp_pit64b_dt.read_current_timer = mchp_pit64b_dt_read;
+	mchp_pit64b_dt.freq = clk_rate;
+	register_current_timer_delay(&mchp_pit64b_dt);
+
 	return 0;
 }
 
-- 
2.32.0

