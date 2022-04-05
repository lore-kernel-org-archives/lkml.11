Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA76C4167D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 11:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235288AbiDELev (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 07:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244698AbiDEIwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:52:34 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC9FD95C9;
        Tue,  5 Apr 2022 01:42:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 731B2CE1C6B;
        Tue,  5 Apr 2022 08:42:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C43FC385A1;
        Tue,  5 Apr 2022 08:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649148124;
        bh=VAF5i6aKP1e/tf2Wm8Jq42UU+785ciOTpaHVQGl6Dug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qsA+2ZDBBesq+GoigwpnvQbKNkVgDRcIKi3SF/OIHg8Qj2OZ6Ol1YFhaHU+zYMVx0
         ieSVcmZfVYWuZY7V6bQD0MdnleigdnyAro7d4X2WELFp+q53+hcri3Bjh86CWM4NDr
         sUQKH3bKd4wOq48SJ+osYs2cgbcA5B1AYRXj++10=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.16 0243/1017] clocksource/drivers/exynos_mct: Handle DTS with higher number of interrupts
Date:   Tue,  5 Apr 2022 09:19:16 +0200
Message-Id: <20220405070401.471413745@linuxfoundation.org>
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

From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

[ Upstream commit ab8da93dc06d82f464c47ab30e6c75190702f369 ]

The driver statically defines maximum number of interrupts it can
handle, however it does not respect that limit when configuring them.
When provided with a DTS with more interrupts than assumed, the driver
will overwrite static array mct_irqs leading to silent memory
corruption.

Validate the interrupts coming from DTS to avoid this.  This does not
change the fact that such DTS might not boot at all, because it is
simply incompatible, however at least some warning will be printed.

Fixes: 36ba5d527e95 ("ARM: EXYNOS: add device tree support for MCT controller driver")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
Link: https://lore.kernel.org/r/20220220103815.135380-1-krzysztof.kozlowski@canonical.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clocksource/exynos_mct.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 857cf12ebe57..cc2a961ddd3b 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -541,6 +541,11 @@ static int __init exynos4_timer_interrupts(struct device_node *np,
 	 * irqs are specified.
 	 */
 	nr_irqs = of_irq_count(np);
+	if (nr_irqs > ARRAY_SIZE(mct_irqs)) {
+		pr_err("exynos-mct: too many (%d) interrupts configured in DT\n",
+			nr_irqs);
+		nr_irqs = ARRAY_SIZE(mct_irqs);
+	}
 	for (i = MCT_L0_IRQ; i < nr_irqs; i++)
 		mct_irqs[i] = irq_of_parse_and_map(np, i);
 
@@ -553,11 +558,14 @@ static int __init exynos4_timer_interrupts(struct device_node *np,
 		     mct_irqs[MCT_L0_IRQ], err);
 	} else {
 		for_each_possible_cpu(cpu) {
-			int mct_irq = mct_irqs[MCT_L0_IRQ + cpu];
+			int mct_irq;
 			struct mct_clock_event_device *pcpu_mevt =
 				per_cpu_ptr(&percpu_mct_tick, cpu);
 
 			pcpu_mevt->evt.irq = -1;
+			if (MCT_L0_IRQ + cpu >= ARRAY_SIZE(mct_irqs))
+				break;
+			mct_irq = mct_irqs[MCT_L0_IRQ + cpu];
 
 			irq_set_status_flags(mct_irq, IRQ_NOAUTOEN);
 			if (request_irq(mct_irq,
-- 
2.34.1



