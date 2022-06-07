Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC66AC433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jun 2022 01:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbiFHBaa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 21:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380635AbiFGVrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 17:47:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792C11900E5;
        Tue,  7 Jun 2022 12:08:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B418D61768;
        Tue,  7 Jun 2022 19:08:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFFA0C385A2;
        Tue,  7 Jun 2022 19:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654628888;
        bh=InK2P2719+ucxNiXUq5akHXves7w4RjNdOe6zfMyDME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=caDUBd4xVwOT2DeimpyvL9ri4My1VfIbzB7qZo4fk8a/nr+TrJg+9mq/13YOQTqdb
         iIdIs3zTdtHN3Nsy8udAsnruWAxBPWIbhr4DScElhuvAFofF/tpGlNyIeTFjZIC1xc
         ZIl9jEr/7FtAvT09WrhnWvuG+shoebEk8C2DFEzg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.18 491/879] thermal/drivers/bcm2711: Dont clamp temperature at zero
Date:   Tue,  7 Jun 2022 19:00:09 +0200
Message-Id: <20220607165017.123408598@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220607165002.659942637@linuxfoundation.org>
References: <20220607165002.659942637@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Wahren <stefan.wahren@i2se.com>

[ Upstream commit 106e0121e243de4da7d634338089a68a8da2abe9 ]

The thermal sensor on BCM2711 is capable of negative temperatures, so don't
clamp the measurements at zero. Since this was the only use for variable t,
drop it.

This change based on a patch by Dom Cobley, who also tested the fix.

Fixes: 59b781352dc4 ("thermal: Add BCM2711 thermal driver")
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Link: https://lore.kernel.org/r/20220412195423.104511-1-stefan.wahren@i2se.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/broadcom/bcm2711_thermal.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/thermal/broadcom/bcm2711_thermal.c b/drivers/thermal/broadcom/bcm2711_thermal.c
index 1ec57d9ecf53..e9bef5c3414b 100644
--- a/drivers/thermal/broadcom/bcm2711_thermal.c
+++ b/drivers/thermal/broadcom/bcm2711_thermal.c
@@ -38,7 +38,6 @@ static int bcm2711_get_temp(void *data, int *temp)
 	int offset = thermal_zone_get_offset(priv->thermal);
 	u32 val;
 	int ret;
-	long t;
 
 	ret = regmap_read(priv->regmap, AVS_RO_TEMP_STATUS, &val);
 	if (ret)
@@ -50,9 +49,7 @@ static int bcm2711_get_temp(void *data, int *temp)
 	val &= AVS_RO_TEMP_STATUS_DATA_MSK;
 
 	/* Convert a HW code to a temperature reading (millidegree celsius) */
-	t = slope * val + offset;
-
-	*temp = t < 0 ? 0 : t;
+	*temp = slope * val + offset;
 
 	return 0;
 }
-- 
2.35.1



