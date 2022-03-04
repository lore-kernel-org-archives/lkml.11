Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA97C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Mar 2022 01:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237523AbiCDBSx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Mar 2022 20:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbiCDBSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 20:18:51 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D9E637D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 17:18:04 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id jv12so5517847qvb.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 17:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ggeqlOlOK5Q/SRrSVwrpS/gLuG/ZypMb8lhTqoNFRrE=;
        b=no7tMwc7EA/95jlcIFo05RFQAZKfo9PoFLJbzXw2aTnkwdRB+dZeJ7U470nh3jPdlu
         mJluOu4sgwofvTDAFXzQ2vtr4Lha0y89JRA56loSR6LJAbTTAIvW6MChCakrfSg9uxIC
         t/bV7xUGte31kBzZt8J6byCqQyZGA+WsifcwrLvqPInAZkd5Zt8Vzczfei32D2qlWbWS
         bg1yJXpp7BHzSR5hFzPnuAeGWB0pHtFZkPeBwY9TRRjFhuCtjRB9T8k7EMhn14K3vnX+
         LD15RuDzt97JEqANGIUQiSfYiszuVeMm/9hmOeBJegUZLBti6okYUWKpIk1VTGXRlJiU
         JNoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ggeqlOlOK5Q/SRrSVwrpS/gLuG/ZypMb8lhTqoNFRrE=;
        b=4p4AcRSOinbRmU0oLY0kfIhUFq/gy/ok3AUFVcXMKoANYPROJ2m/Mm7ygLQR9Rnm4p
         PiW23eeMYmcMje2zz0GO71jOtpGfjVfxAEdxP8xBClHUrdSwZnCSMYLnTlgHry68LcbM
         Syu6WNVzxbvD/i8nsBc2kZ8LYyCVuC3/eqNezabgnrbNUBDKMit+ttdPJqfn3dwH6xHo
         SV4EsvMX7K4cY1xEeYNN8Q8dugP8Tk4Hzb7WoTff5aNSThXFwcNNQLvECNZK55d6mXyp
         CY6bO2tmpGoe5hnghHrFDZOOuknDyghiBHNzVZZtrH6ikwNlniFwkZ9srurO5PMM3md+
         0BbA==
X-Gm-Message-State: AOAM532Ov6UQtAVeHMHsOm5GKhzFBs11FfIq121VlQMTR+UeAYmuzQF/
        4fn3ttMfIOLa7ZLWwFF9CC8=
X-Google-Smtp-Source: ABdhPJzQTNpr7Wkq3+ARwqwy+LeiTyQ3YmPta2upHCMc6srbN/ncpprdDM8g61zbOTet7pygtjoZ4A==
X-Received: by 2002:ad4:448b:0:b0:432:393d:e8ae with SMTP id m11-20020ad4448b000000b00432393de8aemr26499737qvt.127.1646356684138;
        Thu, 03 Mar 2022 17:18:04 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id u26-20020ae9c01a000000b0062ce6955181sm1814302qkk.31.2022.03.03.17.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 17:18:03 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     kishon@ti.com
Cc:     vkoul@kernel.org, heiko@sntech.de, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] phy/rockchip: Use of_device_get_match_data()
Date:   Fri,  4 Mar 2022 01:17:55 +0000
Message-Id: <20220304011755.2061529-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>

Use of_device_get_match_data() to simplify the code.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
---
 drivers/phy/rockchip/phy-rockchip-typec.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-typec.c b/drivers/phy/rockchip/phy-rockchip-typec.c
index d2bbdc96a167..d76440ae10ff 100644
--- a/drivers/phy/rockchip/phy-rockchip-typec.c
+++ b/drivers/phy/rockchip/phy-rockchip-typec.c
@@ -1105,15 +1105,14 @@ static int rockchip_typec_phy_probe(struct platform_device *pdev)
 	struct phy_provider *phy_provider;
 	struct resource *res;
 	const struct rockchip_usb3phy_port_cfg *phy_cfgs;
-	const struct of_device_id *match;
 	int index, ret;
 
 	tcphy = devm_kzalloc(dev, sizeof(*tcphy), GFP_KERNEL);
 	if (!tcphy)
 		return -ENOMEM;
 
-	match = of_match_device(dev->driver->of_match_table, dev);
-	if (!match || !match->data) {
+	phy_cfgs = of_device_get_match_data(dev);
+	if (!phy_cfgs) {
 		dev_err(dev, "phy configs are not assigned!\n");
 		return -EINVAL;
 	}
@@ -1123,7 +1122,6 @@ static int rockchip_typec_phy_probe(struct platform_device *pdev)
 	if (IS_ERR(tcphy->base))
 		return PTR_ERR(tcphy->base);
 
-	phy_cfgs = match->data;
 	/* find out a proper config which can be matched with dt. */
 	index = 0;
 	while (phy_cfgs[index].reg) {
-- 
2.25.1
