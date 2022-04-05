Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891A1C43217
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 12:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382845AbiDEMRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 08:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244966AbiDEIww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:52:52 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C611CB0A;
        Tue,  5 Apr 2022 01:48:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 68B0DCE1BF8;
        Tue,  5 Apr 2022 08:48:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB2AC385A1;
        Tue,  5 Apr 2022 08:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649148484;
        bh=L7t5eCcbxKioBhlB6WdiF/7kW9vwa2XNaTwBhgAO9Cw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UAW0TAwNIjPRJ+Tm4dErDaOuiNS9Hijojc3qROmWylrk2tqTCNo881eEnEMtoWqA4
         0pfQjwN8HdrkpwS0mvZC0Un9nQIKzzRvPjAr01Yja89OcjayT1rmTy6S15FJiGbjL+
         N5odf+Plvy4E+vqVde7itBrUMZcDTJ5ziZCORllE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.16 0372/1017] ASoC: atmel: Add missing of_node_put() in at91sam9g20ek_audio_probe
Date:   Tue,  5 Apr 2022 09:21:25 +0200
Message-Id: <20220405070405.328164771@linuxfoundation.org>
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

From: Miaoqian Lin <linmq006@gmail.com>

[ Upstream commit f590797fa3c1bccdd19e55441592a23b46aef449 ]

This node pointer is returned by of_parse_phandle() with refcount
incremented in this function.
Calling of_node_put() to avoid the refcount leak.

Fixes: 531f67e41dcd ("ASoC: at91sam9g20ek-wm8731: convert to dt support")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Reviewed-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Link: https://lore.kernel.org/r/20220307124539.1743-1-linmq006@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/atmel/sam9g20_wm8731.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/atmel/sam9g20_wm8731.c b/sound/soc/atmel/sam9g20_wm8731.c
index 915da92e1ec8..33e43013ff77 100644
--- a/sound/soc/atmel/sam9g20_wm8731.c
+++ b/sound/soc/atmel/sam9g20_wm8731.c
@@ -214,6 +214,7 @@ static int at91sam9g20ek_audio_probe(struct platform_device *pdev)
 	cpu_np = of_parse_phandle(np, "atmel,ssc-controller", 0);
 	if (!cpu_np) {
 		dev_err(&pdev->dev, "dai and pcm info missing\n");
+		of_node_put(codec_np);
 		return -EINVAL;
 	}
 	at91sam9g20ek_dai.cpus->of_node = cpu_np;
-- 
2.34.1



