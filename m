Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDD7CCA48B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jun 2022 01:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384749AbiFHB0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 21:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383749AbiFGWGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 18:06:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA1AF1366;
        Tue,  7 Jun 2022 12:17:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2949061929;
        Tue,  7 Jun 2022 19:17:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 343E6C385A2;
        Tue,  7 Jun 2022 19:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654629436;
        bh=/fej+mXE9IrJnCoGX4AW8AzyF2M8v1cIvlXyCB/f208=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t5C5RphSGM64LPF+KyI/OhhxvGh0HVorQSOgaTfL/63/r0lXILSYZuVbFZsGqnwpb
         qpgvvO384HF5pqnWtx/q7CHJe65WIqg8+ilJSlFpmKCZhotssC4hmQdlYfNxkMrx9i
         EwnuK/hAWiQ331PmxF61sMZ3ryY3HjpmPCuxS5Ds=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Wolfram Sang <wsa@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.18 691/879] i2c: rcar: fix PM ref counts in probe error paths
Date:   Tue,  7 Jun 2022 19:03:29 +0200
Message-Id: <20220607165022.905400150@linuxfoundation.org>
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

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

[ Upstream commit 3fe2ec59db1a7569e18594b9c0cf1f4f1afd498e ]

We have to take care of ID_P_PM_BLOCKED when bailing out during probe.

Fixes: 7ee24eb508d6 ("i2c: rcar: disable PM in multi-master mode")
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-rcar.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 0db3d7559066..0064c632af5c 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -1063,8 +1063,10 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
 	ret = rcar_i2c_clock_calculate(priv);
-	if (ret < 0)
-		goto out_pm_put;
+	if (ret < 0) {
+		pm_runtime_put(dev);
+		goto out_pm_disable;
+	}
 
 	rcar_i2c_write(priv, ICSAR, 0); /* Gen2: must be 0 if not using slave */
 
@@ -1093,19 +1095,19 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0)
-		goto out_pm_disable;
+		goto out_pm_put;
 	priv->irq = ret;
 	ret = devm_request_irq(dev, priv->irq, irqhandler, irqflags, dev_name(dev), priv);
 	if (ret < 0) {
 		dev_err(dev, "cannot get irq %d\n", priv->irq);
-		goto out_pm_disable;
+		goto out_pm_put;
 	}
 
 	platform_set_drvdata(pdev, priv);
 
 	ret = i2c_add_numbered_adapter(adap);
 	if (ret < 0)
-		goto out_pm_disable;
+		goto out_pm_put;
 
 	if (priv->flags & ID_P_HOST_NOTIFY) {
 		priv->host_notify_client = i2c_new_slave_host_notify_device(adap);
@@ -1122,7 +1124,8 @@ static int rcar_i2c_probe(struct platform_device *pdev)
  out_del_device:
 	i2c_del_adapter(&priv->adap);
  out_pm_put:
-	pm_runtime_put(dev);
+	if (priv->flags & ID_P_PM_BLOCKED)
+		pm_runtime_put(dev);
  out_pm_disable:
 	pm_runtime_disable(dev);
 	return ret;
-- 
2.35.1



