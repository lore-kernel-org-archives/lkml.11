Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB10C47084
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 11:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357959AbiDELhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 07:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244700AbiDEIwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:52:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC139D95EA;
        Tue,  5 Apr 2022 01:42:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5085560FFC;
        Tue,  5 Apr 2022 08:42:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D05C385A0;
        Tue,  5 Apr 2022 08:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649148127;
        bh=cDOHcd6ONfY3Vz+ceAFwv+xN7bIZgszIs24tb7wI428=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=av4whejuoZmDCNjz0geHwWumsi94xNyYXoP1inWP5n1XsofLQkrvxyFBKbrnBLFNN
         fekUSytx0xKEe/QwAoUsypl1DbtOZX/RQoDLPH+ZK3L5qaSYGW+KdvD6axhrJNuxT7
         rXxdIzGtpcaLrBQIbd69UhMoycEbgEfjNaaWbNAo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.16 0244/1017] clocksource/drivers/timer-microchip-pit64b: Use notrace
Date:   Tue,  5 Apr 2022 09:19:17 +0200
Message-Id: <20220405070401.501707186@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070354.155796697@linuxfoundation.org>
References: <20220405070354.155796697@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

[ Upstream commit ff10ee97cb203262e88d9c8bc87369cbd4004a0c ]

Use notrace for mchp_pit64b_sched_read_clk() to avoid recursive call of
prepare_ftrace_return() when issuing:
echo function_graph > /sys/kernel/debug/tracing/current_tracer

Fixes: 625022a5f160 ("clocksource/drivers/timer-microchip-pit64b: Add Microchip PIT64B support")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Link: https://lore.kernel.org/r/20220304133601.2404086-3-claudiu.beznea@microchip.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
2.34.1



