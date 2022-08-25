Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4D4C04AA5
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Aug 2022 01:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbiHYBTi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Aug 2022 21:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiHYBTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 21:19:36 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6DD081A82A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 18:19:35 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id AE1231E80C99;
        Thu, 25 Aug 2022 09:15:31 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BEp5JU4Eh47n; Thu, 25 Aug 2022 09:15:28 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: yuzhe@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 6A5001E80C8D;
        Thu, 25 Aug 2022 09:15:28 +0800 (CST)
From:   Yu Zhe <yuzhe@nfschina.com>
To:     will@kernel.org, mark.rutland@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        liqiong@nfschina.com, Yu Zhe <yuzhe@nfschina.com>
Subject: [PATCH] perf/arm_pmu_platform: fix tests for platform_get_irq() failure
Date:   Thu, 25 Aug 2022 09:18:44 +0800
Message-Id: <20220825011844.8536-1-yuzhe@nfschina.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The platform_get_irq() returns negative error codes.  It can't actually
return zero.

Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
---
 drivers/perf/arm_pmu_platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/arm_pmu_platform.c b/drivers/perf/arm_pmu_platform.c
index 513de1f54e2d..933b96e243b8 100644
--- a/drivers/perf/arm_pmu_platform.c
+++ b/drivers/perf/arm_pmu_platform.c
@@ -117,7 +117,7 @@ static int pmu_parse_irqs(struct arm_pmu *pmu)
 
 	if (num_irqs == 1) {
 		int irq = platform_get_irq(pdev, 0);
-		if (irq && irq_is_percpu_devid(irq))
+		if ((irq > 0) && irq_is_percpu_devid(irq))
 			return pmu_parse_percpu_irq(pmu, irq);
 	}
 
-- 
2.11.0

