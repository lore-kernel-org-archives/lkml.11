Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F3AC433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 May 2022 09:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354730AbiEEKC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 May 2022 06:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354726AbiEEKCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 06:02:25 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E42506F8;
        Thu,  5 May 2022 02:58:44 -0700 (PDT)
Received: from janitor.denx.de (unknown [62.91.23.180])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: noc@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 5C71A83B39;
        Thu,  5 May 2022 11:58:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1651744723;
        bh=Lf/yCYkD7jA7slNP+kaNzEXHEvTuA+EXjFYOYKEZjA0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TgFLUzhWhr0sCAFTiO0+r3rfL+XoQ+oL1ATaHavY6HdH3/u64rykNSoPl/Iy8tqw0
         aMEU48U+erNKuz2GXAoPr6V3trpnmN7vs6THPHpVFo2I/pp4bXyaoGaDCCi3LW8Vwt
         ETPxoYK+1vmi+QntA/W03Y7n7BE+1LmSZ+La4JasTJRWy6q0CHIX126SDgkVmqXp4/
         hqFRpe4bFCYzsmHTPkzf8JaSifXJy/R5zyX0kTq12fXQ67re4Act7SnUOy8hZITt2V
         L4aC+RNPZ6ZhlRfp1aoqaJ3L8ebwDKJwoDLD3yICtLeMzixNCweQ1REXJPWox+W3ER
         0Brj2ac0bo1bQ==
Received: by janitor.denx.de (Postfix, from userid 108)
        id 1684CA012A; Thu,  5 May 2022 11:58:43 +0200 (CEST)
Received: from xpert.denx.de (xpert.denx.de [192.168.0.4])
        by janitor.denx.de (Postfix) with ESMTPS id 61CB1A003A;
        Thu,  5 May 2022 11:58:27 +0200 (CEST)
Received: by xpert.denx.de (Postfix, from userid 535)
        id 5701F3E07D7; Thu,  5 May 2022 11:58:27 +0200 (CEST)
From:   Philip Oberfichtner <pro@denx.de>
Cc:     Philip Oberfichtner <pro@denx.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, matthias.winker@de.bosch.com
Subject: [PATCH v4 3/4] dt-bindings: arm: Add bosch acc board
Date:   Thu,  5 May 2022 11:57:28 +0200
Message-Id: <20220505095725.902447-3-pro@denx.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220505095725.902447-1-pro@denx.de>
References: <20220505095725.902447-1-pro@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree binding for the Bosch ACC board, based on i.MX6 Dual.

Signed-off-by: Philip Oberfichtner <pro@denx.de>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Li Yang <leoyang.li@nxp.com>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: matthias.winker@de.bosch.com

---

Changes in v4: none
Changes in v3: none
Changes in v2: Acked-by Krzysztof
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 08bdd30e511c..9deb568761c1 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -192,6 +192,7 @@ properties:
         items:
           - enum:
               - auvidea,h100              # Auvidea H100
+              - bosch,imx6q-acc           # Bosch ACC i.MX6 Dual
               - boundary,imx6q-nitrogen6_max
               - boundary,imx6q-nitrogen6_som2
               - boundary,imx6q-nitrogen6x
-- 
2.34.1

