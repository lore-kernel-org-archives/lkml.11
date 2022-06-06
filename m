Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4437C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jun 2022 15:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240773AbiFFP0i (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jun 2022 11:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240600AbiFFPZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:25:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085A41CD362;
        Mon,  6 Jun 2022 08:25:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A27EA61534;
        Mon,  6 Jun 2022 15:25:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25D91C341EE;
        Mon,  6 Jun 2022 15:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654529149;
        bh=n0n0WtLdjHGysi7HQyXylTbROYN14VH5/Fz95ISJfNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SyRBV2TJCk+cQ7Tdrw7NUuwMMWYDrQ2+swwAFUxrhnBVuxYgGXg9DCvfIB6fWOWJw
         OcF4mG0EBO7ZCQMoRLmtmACaUEaF5jTA6TyjUHpThe5/ya+ni4NwynVkN3e1ySBxey
         rni5yMAcAKraS72ibpwoH1EUdlc03pdZRqTZwK7d5KTAh5vZVq1tpBBv910ZRvddfy
         45t6H0OD4acfBGpQsSAuxeEPS6vchhtVYHvj6lAfYSJAmcQbYFI79DFftY1IqZwZll
         nfdRvrOQwP0WZekD5Jp9Mf9PWn4RQpH0UfU4n72o/DYzLEJ4fdT3Cn74hRW/Bb2IKo
         AZjLb8cHU9FZQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1nyEby-0012Q5-Fh;
        Mon, 06 Jun 2022 16:25:46 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 22/23] ASoC: wm8731: update wlf,wm8731.yaml reference
Date:   Mon,  6 Jun 2022 16:25:44 +0100
Message-Id: <e56e54fe0ebb1b6e8dd2e245c398190016eb0a34.1654529011.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1654529011.git.mchehab@kernel.org>
References: <cover.1654529011.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 0e336eeaf467 ("ASoC: wm8731: Convert DT bindings to YAML format")
renamed: Documentation/devicetree/bindings/sound/wm8731.txt
to: Documentation/devicetree/bindings/sound/wlf,wm8731.yaml.

Update its cross-reference accordingly.

Fixes: 0e336eeaf467 ("ASoC: wm8731: Convert DT bindings to YAML format")
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/23] at: https://lore.kernel.org/all/cover.1654529011.git.mchehab@kernel.org/

 .../devicetree/bindings/sound/atmel-sam9x5-wm8731-audio.txt     | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/atmel-sam9x5-wm8731-audio.txt b/Documentation/devicetree/bindings/sound/atmel-sam9x5-wm8731-audio.txt
index 0720857089a7..8facbce53db8 100644
--- a/Documentation/devicetree/bindings/sound/atmel-sam9x5-wm8731-audio.txt
+++ b/Documentation/devicetree/bindings/sound/atmel-sam9x5-wm8731-audio.txt
@@ -16,7 +16,7 @@ Board connectors:
  * Line In Jack
 
 wm8731 pins:
-cf Documentation/devicetree/bindings/sound/wm8731.txt
+cf Documentation/devicetree/bindings/sound/wlf,wm8731.yaml
 
 Example:
 sound {
-- 
2.36.1

