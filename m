Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B46BCCA49A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jun 2022 17:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348692AbiFGRgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 13:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347128AbiFGRaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 13:30:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6461059F8;
        Tue,  7 Jun 2022 10:25:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8909F60C7C;
        Tue,  7 Jun 2022 17:25:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99927C3411C;
        Tue,  7 Jun 2022 17:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654622752;
        bh=p0mKdJIcev35d5O3zQ9pHkKJ9Fx9jtlnQMK8XtBBd9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oyU80sw5b/qXETna7BsBwzL+Jx81TlcQfRS4dBPP1HRhelaVYy0rE2CGOIUHWVm8P
         9RrxmEVc7wdew8SuRuSwoobDrVqrgNPGgvn8O/oc68W+kEjVVQacAIMkeTXAcoK8bH
         f19zg2KZJUEmlSIxYiVUNVWiFqu7cuw+1l8JNiGs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 171/452] ASoC: rk3328: fix disabling mclk on pclk probe failure
Date:   Tue,  7 Jun 2022 19:00:28 +0200
Message-Id: <20220607164913.657533718@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220607164908.521895282@linuxfoundation.org>
References: <20220607164908.521895282@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>

[ Upstream commit dd508e324cdde1c06ace08a8143fa50333a90703 ]

If preparing/enabling the pclk fails, the probe function should
unprepare and disable the previously prepared and enabled mclk,
which it doesn't do. This commit rectifies this.

Fixes: c32759035ad2 ("ASoC: rockchip: support ACODEC for rk3328")
Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Reviewed-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Link: https://lore.kernel.org/r/20220427172310.138638-1-frattaroli.nicolas@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rk3328_codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rk3328_codec.c b/sound/soc/codecs/rk3328_codec.c
index aed18cbb9f68..e40b97929f6c 100644
--- a/sound/soc/codecs/rk3328_codec.c
+++ b/sound/soc/codecs/rk3328_codec.c
@@ -481,7 +481,7 @@ static int rk3328_platform_probe(struct platform_device *pdev)
 	ret = clk_prepare_enable(rk3328->pclk);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to enable acodec pclk\n");
-		return ret;
+		goto err_unprepare_mclk;
 	}
 
 	base = devm_platform_ioremap_resource(pdev, 0);
-- 
2.35.1



