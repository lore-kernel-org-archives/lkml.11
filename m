Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39C3CCA473
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Jul 2022 05:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbiGFFU1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Jul 2022 01:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiGFFUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 01:20:24 -0400
Received: from smtp.smtpout.orange.fr (smtp06.smtpout.orange.fr [80.12.242.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713421FCE9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 22:20:23 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id 8xSSolGl2xzw28xSSoAalg; Wed, 06 Jul 2022 07:20:21 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Wed, 06 Jul 2022 07:20:21 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] perf/arm-cci: Use the bitmap API to allocate bitmaps
Date:   Wed,  6 Jul 2022 07:20:15 +0200
Message-Id: <fbde85a5e8ae99b10a2115d8ea1e69320a62947f.1657084786.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_bitmap_zalloc() instead of hand-writing it.
It is less verbose and it improves the semantic.

While at it, use bitmap_zero() instead of hand-writing it.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/perf/arm-cci.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/perf/arm-cci.c b/drivers/perf/arm-cci.c
index 16a272c8d4b3..03b1309875ae 100644
--- a/drivers/perf/arm-cci.c
+++ b/drivers/perf/arm-cci.c
@@ -1261,7 +1261,7 @@ static int validate_group(struct perf_event *event)
 		 */
 		.used_mask = mask,
 	};
-	memset(mask, 0, BITS_TO_LONGS(cci_pmu->num_cntrs) * sizeof(unsigned long));
+	bitmap_zero(mask, cci_pmu->num_cntrs);
 
 	if (!validate_event(event->pmu, &fake_pmu, leader))
 		return -EINVAL;
@@ -1629,10 +1629,9 @@ static struct cci_pmu *cci_pmu_alloc(struct device *dev)
 					     GFP_KERNEL);
 	if (!cci_pmu->hw_events.events)
 		return ERR_PTR(-ENOMEM);
-	cci_pmu->hw_events.used_mask = devm_kcalloc(dev,
-						BITS_TO_LONGS(CCI_PMU_MAX_HW_CNTRS(model)),
-						sizeof(*cci_pmu->hw_events.used_mask),
-						GFP_KERNEL);
+	cci_pmu->hw_events.used_mask = devm_bitmap_zalloc(dev,
+							  CCI_PMU_MAX_HW_CNTRS(model),
+							  GFP_KERNEL);
 	if (!cci_pmu->hw_events.used_mask)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.34.1

