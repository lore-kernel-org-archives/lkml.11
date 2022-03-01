Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F9AC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Mar 2022 12:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234809AbiCAMet (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Mar 2022 07:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234780AbiCAMei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 07:34:38 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D759683A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 04:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646138037; x=1677674037;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CGECGO3DLDF9kAjkJpmPmmKockfvvVD5RT0cNRq2/PE=;
  b=cJXnX/mbCDrjNLbPcgMOropnspHSblNsFp7GJxKiaaLycaaNNnCbeM3a
   D/uOo9ZOrI6ulHfvVnnnmnxpkkpA4kW89ZIjofSlEpg1nkDyRcAKOHLPB
   WUtRMa5tZWntFa69lgcWn7qNlh1+GcnLXg0R8zUecM9e9hTDC8WTHWtIR
   deqIdZ3oBvVn59MUr8u50/bhd6ePfyFp9ZGtg2CXrcdwHXKwf5CTLz27R
   6t1HpkVnFyMVyhYR392SZTf6IQVWbHfzk7wSyS9eGAvMJAcfhrUbc3Wkx
   7RRMbYO/UMVkehuzYteyo1I4LrmF46TeUk7IbMOC37xeJ4UbiRd6+VDbD
   w==;
X-IronPort-AV: E=Sophos;i="5.90,146,1643698800"; 
   d="scan'208";a="155253478"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Mar 2022 05:33:56 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 1 Mar 2022 05:33:56 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 1 Mar 2022 05:33:55 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 5/7] clocksource/drivers/timer-microchip-pit64b: remove suspend/resume ops for ce
Date:   Tue, 1 Mar 2022 14:34:47 +0200
Message-ID: <20220301123449.2816625-6-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220301123449.2816625-1-claudiu.beznea@microchip.com>
References: <20220301123449.2816625-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove suspend and resume ops for clockevent and add set_state_oneshot()
instead. Along with this mchp_pit64b_{suspend, resume}() were called on
proper function to disable/enable clocks. This will allow disabling clocks
for clockevent in case it is not selected as active clockevent.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clocksource/timer-microchip-pit64b.c | 30 +++++++++++---------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/clocksource/timer-microchip-pit64b.c b/drivers/clocksource/timer-microchip-pit64b.c
index abce83d2f00b..b51259395ac3 100644
--- a/drivers/clocksource/timer-microchip-pit64b.c
+++ b/drivers/clocksource/timer-microchip-pit64b.c
@@ -173,7 +173,8 @@ static int mchp_pit64b_clkevt_shutdown(struct clock_event_device *cedev)
 {
 	struct mchp_pit64b_timer *timer = clkevt_to_mchp_pit64b_timer(cedev);
 
-	writel_relaxed(MCHP_PIT64B_CR_SWRST, timer->base + MCHP_PIT64B_CR);
+	if (!clockevent_state_detached(cedev))
+		mchp_pit64b_suspend(timer);
 
 	return 0;
 }
@@ -182,35 +183,37 @@ static int mchp_pit64b_clkevt_set_periodic(struct clock_event_device *cedev)
 {
 	struct mchp_pit64b_timer *timer = clkevt_to_mchp_pit64b_timer(cedev);
 
+	if (clockevent_state_shutdown(cedev))
+		mchp_pit64b_resume(timer);
+
 	mchp_pit64b_reset(timer, mchp_pit64b_ce_cycles, MCHP_PIT64B_MR_CONT,
 			  MCHP_PIT64B_IER_PERIOD);
 
 	return 0;
 }
 
-static int mchp_pit64b_clkevt_set_next_event(unsigned long evt,
-					     struct clock_event_device *cedev)
+static int mchp_pit64b_clkevt_set_oneshot(struct clock_event_device *cedev)
 {
 	struct mchp_pit64b_timer *timer = clkevt_to_mchp_pit64b_timer(cedev);
 
-	mchp_pit64b_reset(timer, evt, MCHP_PIT64B_MR_ONE_SHOT,
+	if (clockevent_state_shutdown(cedev))
+		mchp_pit64b_resume(timer);
+
+	mchp_pit64b_reset(timer, mchp_pit64b_ce_cycles, MCHP_PIT64B_MR_ONE_SHOT,
 			  MCHP_PIT64B_IER_PERIOD);
 
 	return 0;
 }
 
-static void mchp_pit64b_clkevt_suspend(struct clock_event_device *cedev)
+static int mchp_pit64b_clkevt_set_next_event(unsigned long evt,
+					     struct clock_event_device *cedev)
 {
 	struct mchp_pit64b_timer *timer = clkevt_to_mchp_pit64b_timer(cedev);
 
-	mchp_pit64b_suspend(timer);
-}
-
-static void mchp_pit64b_clkevt_resume(struct clock_event_device *cedev)
-{
-	struct mchp_pit64b_timer *timer = clkevt_to_mchp_pit64b_timer(cedev);
+	mchp_pit64b_reset(timer, evt, MCHP_PIT64B_MR_ONE_SHOT,
+			  MCHP_PIT64B_IER_PERIOD);
 
-	mchp_pit64b_resume(timer);
+	return 0;
 }
 
 static irqreturn_t mchp_pit64b_interrupt(int irq, void *dev_id)
@@ -395,9 +398,8 @@ static int __init mchp_pit64b_init_clkevt(struct mchp_pit64b_timer *timer,
 	ce->clkevt.rating = 150;
 	ce->clkevt.set_state_shutdown = mchp_pit64b_clkevt_shutdown;
 	ce->clkevt.set_state_periodic = mchp_pit64b_clkevt_set_periodic;
+	ce->clkevt.set_state_oneshot = mchp_pit64b_clkevt_set_oneshot;
 	ce->clkevt.set_next_event = mchp_pit64b_clkevt_set_next_event;
-	ce->clkevt.suspend = mchp_pit64b_clkevt_suspend;
-	ce->clkevt.resume = mchp_pit64b_clkevt_resume;
 	ce->clkevt.cpumask = cpumask_of(0);
 	ce->clkevt.irq = irq;
 
-- 
2.32.0

