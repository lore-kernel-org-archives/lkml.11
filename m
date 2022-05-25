Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A294C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 25 May 2022 20:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344185AbiEYU7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 May 2022 16:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbiEYU7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 16:59:20 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFC0BA553;
        Wed, 25 May 2022 13:59:19 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id w19-20020a9d6393000000b0060aeb359ca8so11713975otk.6;
        Wed, 25 May 2022 13:59:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1m2s22XtmxEczOaH6Nvd5Gv9iJMhl6MqiC51IH1U9jc=;
        b=uy7EAn6ql6b6ZygPiqws98K0b/pJuQtwoj2xjCCg7YT7hBCVb6IGzNwvSF7hn0+ohK
         MElFex2+ueQ5K8aNP5p6x8DqJjJXD2H2SwyAtVi5lb7AICtXeJRveN8js15281mSswBU
         vW3kRPjeUD/BHZ4jexHuQIVP0sybRlZrZS5zEnErc5K2yZIyrC4rQT5PjT/JLGT/orTm
         KFzXLxP3QMZj94oDza3q7AYuT89RhFje1rbfu+J1L4dcMIHMTcZ0NDOue3ICar5pM96i
         UFWvMuo6tFFPQEnERSlNMnol5lftROxx/RthL7yp3/2eshQxJJeMUiONWCnlY/oY1DUa
         B17Q==
X-Gm-Message-State: AOAM531atMPoPI5S8ThdRJvNLNnP2F3JM2Cm304YT5hSy8YGHL/yWsrK
        huQ0GvvEHX0YGbQVIf5hCrC4eFkecg==
X-Google-Smtp-Source: ABdhPJweDY0pMYyERhPPRmIRG2kB92PgCy9mt/HQ7tcYvBieKTd/XAk2Cowz8xfLpjWerh2SdE4Kbg==
X-Received: by 2002:a9d:69:0:b0:60a:f535:f54e with SMTP id 96-20020a9d0069000000b0060af535f54emr10364616ota.215.1653512359028;
        Wed, 25 May 2022 13:59:19 -0700 (PDT)
Received: from xps15.. (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id n24-20020a4ae758000000b0035eb4e5a6b1sm7058090oov.7.2022.05.25.13.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 13:59:18 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mtd: spi-nand: Add spi-peripheral-props.yaml reference
Date:   Wed, 25 May 2022 15:59:08 -0500
Message-Id: <20220525205909.2486153-1-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPI peripheral device bindings need to reference spi-peripheral-props.yaml
in order to use various SPI controller specific properties. Otherwise,
the unevaluatedProperties check will reject any controller specific
properties.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/mtd/spi-nand.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mtd/spi-nand.yaml b/Documentation/devicetree/bindings/mtd/spi-nand.yaml
index 431faac518a4..dd3cd1d53009 100644
--- a/Documentation/devicetree/bindings/mtd/spi-nand.yaml
+++ b/Documentation/devicetree/bindings/mtd/spi-nand.yaml
@@ -11,6 +11,7 @@ maintainers:
 
 allOf:
   - $ref: "nand-chip.yaml#"
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
 
 properties:
   compatible:
-- 
2.34.1

