Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D787C25B06
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Aug 2022 20:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238220AbiHEUv6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Aug 2022 16:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234587AbiHEUvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 16:51:55 -0400
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C062DAA5
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 13:51:52 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id K4IPokAJ0sKAkK4IPorqln; Fri, 05 Aug 2022 22:51:50 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Fri, 05 Aug 2022 22:51:50 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] perf/arm_pmu_platform: Fix an error message related to dev_err_probe() usage
Date:   Fri,  5 Aug 2022 22:51:12 +0200
Message-Id: <aaebe9c12fcdb29f48fe19737cb5abee888fbb20.1659732652.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_err() is a macro that expand dev_fmt, but dev_err_probe() is a
function and cannot perform this macro expansion.

So hard code the "hw perfevents: " prefix and dd a comment explaining why.

Fixes: 11fa1dc8020a ("perf/arm_pmu_platform: Use dev_err_probe() for IRQ errors")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Untested, but I can't see how it could work.
---
 drivers/perf/arm_pmu_platform.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm_pmu_platform.c b/drivers/perf/arm_pmu_platform.c
index 513de1f54e2d..02cca4b8f0fd 100644
--- a/drivers/perf/arm_pmu_platform.c
+++ b/drivers/perf/arm_pmu_platform.c
@@ -101,8 +101,11 @@ static int pmu_parse_irqs(struct arm_pmu *pmu)
 	struct device *dev = &pdev->dev;
 
 	num_irqs = platform_irq_count(pdev);
-	if (num_irqs < 0)
-		return dev_err_probe(dev, num_irqs, "unable to count PMU IRQs\n");
+	if (num_irqs < 0) {
+		/* dev_err_probe() does not handle dev_pm, so hard-code the prefix */
+		return dev_err_probe(dev, num_irqs,
+				     "hw perfevents: unable to count PMU IRQs\n");
+	}
 
 	/*
 	 * In this case we have no idea which CPUs are covered by the PMU.
-- 
2.34.1

