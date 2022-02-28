Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CF2C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Feb 2022 11:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235126AbiB1LTR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Feb 2022 06:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235316AbiB1LTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 06:19:03 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552B233E03
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 03:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646047106; x=1677583106;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3OTySUvfj9YLZ+NLvxOpjOu3QfEnAa4NzFTMBjne5gU=;
  b=c5cKTEFVj4mvx3hIm5KAL4mMg7kkj8/2v1+e4jaPHBp3SxZ1yjvjR8po
   OfZj77HB8dHhobBjHLefdctg8CtkgNXSAyw92u4/UK+eCF1TmeO7hKWLO
   J05SFMO+UMtSCiDbU4RAC5vAdLhTsvIpsdIr2EFoeI2pXQvVRe7r5QR39
   vg+ssxylB/82jVrMOKDevNS6yU1NbyqXNJQyLMkowHv/J2acMhmXOZ9P0
   CYGVYrHXoLlWnz5lNViFI8lYowkSTS+DUzDNy9NUXIZj2W7cip7CNif1W
   DsYlvzVgKO7R8gNTeCTm6URSXjlbmQSV+D3YdiYF5exdeBJlwcVjgUw4K
   w==;
X-IronPort-AV: E=Sophos;i="5.90,142,1643698800"; 
   d="scan'208";a="154614990"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Feb 2022 04:18:25 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 28 Feb 2022 04:18:24 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 28 Feb 2022 04:18:22 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 3/7] clocksource/drivers/timer-microchip-pit64b: use notrace
Date:   Mon, 28 Feb 2022 13:19:19 +0200
Message-ID: <20220228111923.1400049-4-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220228111923.1400049-1-claudiu.beznea@microchip.com>
References: <20220228111923.1400049-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use notrace for mchp_pit64b_sched_read_clk() to avoid recursive call of
prepare_ftrace_return() when issuing:
echo function_graph > /sys/kernel/debug/tracing/current_tracer

Fixes: 625022a5f160 ("clocksource/drivers/timer-microchip-pit64b: Add Microchip PIT64B support")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clocksource/timer-microchip-pit64b.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-microchip-pit64b.c b/drivers/clocksource/timer-microchip-pit64b.c
index cfa4ec7ef396..790d2c9b42a7 100644
--- a/drivers/clocksource/timer-microchip-pit64b.c
+++ b/drivers/clocksource/timer-microchip-pit64b.c
@@ -165,7 +165,7 @@ static u64 mchp_pit64b_clksrc_read(struct clocksource *cs)
 	return mchp_pit64b_cnt_read(mchp_pit64b_cs_base);
 }
 
-static u64 mchp_pit64b_sched_read_clk(void)
+static u64 notrace mchp_pit64b_sched_read_clk(void)
 {
 	return mchp_pit64b_cnt_read(mchp_pit64b_cs_base);
 }
-- 
2.32.0

