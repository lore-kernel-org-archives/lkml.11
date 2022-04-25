Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EDEC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Apr 2022 13:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238569AbiDYNqJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Apr 2022 09:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242258AbiDYNqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:46:02 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757434B1D0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 06:42:50 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id j8so27115461pll.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 06:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ep/Z4u0b5W5ZrSMaOZGCX1Gp+XElSZzNj7MhnS39q4s=;
        b=GCT3QdZfuO4MKw84a9de0IwZhHKMmIvCHysg110umITHoTZEXyxBZC9xUvc1o0xKjB
         uUXEsp03vE6mB17iAuch9gACGod/Mt/KJVyFO2pe6LSAN5pJI19jsLsAit6Yinby7EM3
         vVAd4sHHj34y4WMJkdjobjKxNDNyjUxukjsJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ep/Z4u0b5W5ZrSMaOZGCX1Gp+XElSZzNj7MhnS39q4s=;
        b=28lN3vDvu1XjG4E7MQhg4RcPezL7eAmQnEg77p7N0CxISeCQ+DKvPPJEFpi/07FdVA
         mUnIvq5+dxO/JD2TXKLF3kuT79GOzeFXXYBfWV7kX9tcBPpZfspuBYGRB+2ipfJQDKey
         5iSr080p/HIqahexYSR4updpWbYLFPfwAQtmJAAn6y4JsEiYpw2z9iUZTd//oZS9njO4
         rNGuTGk3SkA+TB3lNHeU22w5MSS2VE22bC0zSSsejxjC0cmUe8GxAp9OqpOBpmjPVpd+
         DkHf7ZO4NAU7qfH5/lF/tL/4+CRzEOk97Lk443XmtfSkfixzmx2NOb47cr2Zw46L+LDU
         KDPA==
X-Gm-Message-State: AOAM530HvMiTs4dnqvQUJJjCCgR4laU6SRVe6oR2GjylwzMcig/XoJoO
        EYo56C2P6tjfqP+VFR5sCFQ+bA==
X-Google-Smtp-Source: ABdhPJxNgA/qV9ctFK0tkuLRtF1IVhQU94xfp/kjs1NdQOf53wbvl4vefqcp8QSlxXrpP+6n+i58WA==
X-Received: by 2002:a17:90b:4c45:b0:1d7:b1d:b312 with SMTP id np5-20020a17090b4c4500b001d70b1db312mr23130527pjb.24.1650894169946;
        Mon, 25 Apr 2022 06:42:49 -0700 (PDT)
Received: from localhost.localdomain ([183.83.137.38])
        by smtp.gmail.com with ESMTPSA id c9-20020a63a409000000b0039912d50806sm9810089pgf.87.2022.04.25.06.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 06:42:49 -0700 (PDT)
From:   Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Matteo Lisi <matteo.lisi@engicam.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
        Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
Subject: [PATCH v3 1/3] dt-bindings: arm: fsl: Add Engicam i.Core MX8M Plus EDIMM2.2 Starter Kit
Date:   Mon, 25 Apr 2022 19:12:22 +0530
Message-Id: <20220425134224.368908-1-abbaraju.manojsai@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220418144907.327511-2-abbaraju.manojsai@amarulasolutions.com>
References: <20220418144907.327511-2-abbaraju.manojsai@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.Core MX8M Plus is an EDIMM SoM based on NXP i.MX8M Plus from Engicam.

EDIMM2.2 Starter Kit is an EDIMM 2.2 Form Factor Capacitive Evaluation
Board from Engicam.

i.Core MX8M Plus needs to mount on top of this Evaluation board for
creating complete i.Core MX8M Plus EDIMM2.2 Starter Kit.

Add bindings for it.

Signed-off-by: Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3 :
  - added the device binding of imx8mp soc as per existing convention .
Changes for v2 :
  - added the device binding of imx8mp as per soc order.
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 13aee9fe115e..3cb32d67cf6a 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -909,6 +909,13 @@ properties:
               - toradex,verdin-imx8mp-wifi  # Verdin iMX8M Plus Wi-Fi / BT Modules
           - const: fsl,imx8mp

+      - description: Engicam i.Core MX8M Plus SoM based boards
+        items:
+          - enum:
+              - engicam,icore-mx8mp-edimm2.2       # i.MX8MP Engicam i.Core MX8M Plus EDIMM2.2 Starter Kit
+          - const: engicam,icore-mx8mp             # i.MX8MP Engicam i.Core MX8M Plus SoM
+          - const: fsl,imx8mp
+
       - description: PHYTEC phyCORE-i.MX8MP SoM based boards
         items:
           - const: phytec,imx8mp-phyboard-pollux-rdk # phyBOARD-Pollux RDK
--
2.25.1
