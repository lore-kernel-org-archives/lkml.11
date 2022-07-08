Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A120C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Jul 2022 20:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240306AbiGHUyc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Jul 2022 16:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240285AbiGHUya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 16:54:30 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765441AF12;
        Fri,  8 Jul 2022 13:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1657313661; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gDom/uPmSe9UiwdDAFbjIzOeDiIX+x98YrGKZn/GFRU=;
        b=EgWJ4HV/Vkvqm0qcPZ2jWu76bMes33ds1tI2iDm/nRa7H2hSqoLtMVAx8K0OhK6xMSWZ3C
        NYjnchaPA1lYy3L3u4LKXf1Pvk+B4EK9xrE2B+ATt3svos+IMkbXRcl7HbWbbY21vaNRoI
        BBCvfG0prmzbmpcc/PLhMkrBaM4j1S8=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Christophe Branchereau <cbranchereau@gmail.com>,
        list@opendingux.net, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH 1/6] dt-bindings/display: ingenic: Add compatible string for the JZ4760(B)
Date:   Fri,  8 Jul 2022 21:54:01 +0100
Message-Id: <20220708205406.96473-2-paul@crapouillou.net>
In-Reply-To: <20220708205406.96473-1-paul@crapouillou.net>
References: <20220708205406.96473-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible strings for the LCD controllers found in the JZ4760 and
JZ4760B SoCs from Ingenic.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: devicetree@vger.kernel.org
---
 Documentation/devicetree/bindings/display/ingenic,lcd.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/ingenic,lcd.yaml b/Documentation/devicetree/bindings/display/ingenic,lcd.yaml
index 0049010b37ca..c0bb02fb49f4 100644
--- a/Documentation/devicetree/bindings/display/ingenic,lcd.yaml
+++ b/Documentation/devicetree/bindings/display/ingenic,lcd.yaml
@@ -17,6 +17,8 @@ properties:
     enum:
       - ingenic,jz4740-lcd
       - ingenic,jz4725b-lcd
+      - ingenic,jz4760-lcd
+      - ingenic,jz4760b-lcd
       - ingenic,jz4770-lcd
       - ingenic,jz4780-lcd
 
-- 
2.35.1

