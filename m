Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DF2CCA47C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jun 2022 07:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237827AbiFGHoR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 03:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235160AbiFGHoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 03:44:15 -0400
Received: from mail.shift-gmbh.com (mail.shift-gmbh.com [85.10.195.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84ACC2EA3B;
        Tue,  7 Jun 2022 00:44:11 -0700 (PDT)
From:   Alexander Martinz <amartinz@shiftphones.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shiftphones.com;
        s=2018; t=1654587849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=GgHqv91xtDPT2OEbMPNAx9fBgy2xHBtE3Y0HuLoRfss=;
        b=APfhe2ypnM9Th4dzKXX3dmJlMsKRxitnyLVzNQlNbNU+ZKcNKJfZ92KaxkWtHbKCwfokae
        ggassWgauXib4xD8oBibMonVeVb5btUMkj7EmYx/kAWQS9ndp2u87Mkm0aXg3z8fFrHqUZ
        qc3i9WvuwixveMkXq2GabkQbALv4eAfN74cGfXmFArL8JsbXe3bUCo25MpnLc7+l4rP8z6
        fmrgGWV/TB7CZLVR9BHha1ocLIG/VifxAUzYTGUwU8bdWqIYHyQ96eeFB/ZGxrfRASTLrr
        eJKMiowGtfLNvgxOXfxTyyzR4Y+mq7CPghM/0MlFDPiHq097mSrs65B247Jq7g==
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     phone-devel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Caleb Connolly <caleb@connolly.tech>,
        Dylan Van Assche <me@dylanvanassche.be>,
        Alexander Martinz <amartinz@shiftphones.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/2] ASoC: dt-bindings: nxp,tfa989x: Add tfa9890 support
Date:   Tue,  7 Jun 2022 09:43:29 +0200
Message-Id: <20220607074329.13129-1-amartinz@shiftphones.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=amartinz@shiftphones.com smtp.mailfrom=amartinz@shiftphones.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document TFA9890 binding for tfa989x.

Signed-off-by: Alexander Martinz <amartinz@shiftphones.com>
Reviewed-by: Stephan Gerhold <stephan@gerhold.net>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml b/Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml
index b9b1dba40856..7f2e68ff6d34 100644
--- a/Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml
+++ b/Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml
@@ -15,6 +15,7 @@ allOf:
 properties:
   compatible:
     enum:
+      - nxp,tfa9890
       - nxp,tfa9895
       - nxp,tfa9897
 
-- 
2.36.1

