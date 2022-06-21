Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B95EC43334
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jun 2022 16:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353704AbiFUQHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jun 2022 12:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353686AbiFUQHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 12:07:34 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DA363B4;
        Tue, 21 Jun 2022 09:07:32 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id eq6so12694308edb.6;
        Tue, 21 Jun 2022 09:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ogkf5Ukl+CuQggmQ823HfWD79KHuQNHGRJztDxCaGzE=;
        b=eaSpaNHxFzndeLG8tpbkAL3av5yuAtZYrV0DBIA04sgfEyJVlLvxqfbSxbfUUivFZv
         2hGbJL7Iu2KkANliMScg7r3NDNHAAOwdSHqgbyBuSM6w+DyTYkLf3G/grZo+YXdNKBlr
         giYSrMp9RA2N3HTBr7iJr+6jpVsKNlb25MPliZvzDRuKQbIlI3cEQRLbleY6saJNPCKu
         1JsIPX3ochF+9C2cw+Qw4VQlIABNPWs8UQJxgopgJxsR2VEo1GVstSAZUMOm+wOINwad
         IHf0mw+NpXP+AXoNhg7frOrlpZUEOlwNFHamPx4K8cyMJDbHFfJRzMOZQImnVCesMAeC
         6Xbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ogkf5Ukl+CuQggmQ823HfWD79KHuQNHGRJztDxCaGzE=;
        b=mhqN8PZp60IxP213Xsli4VgJZaKkbYHAWG9EjJm0j39ApQHDy5M+/uJEArUdVppB7y
         L9hvETGWCq3ONXbOWSgSAK1ReuJZ8ktDjYhtV8CHBH0GJ7+LB85R0Z1Nt5sEOZse1GBK
         QMGlEpRLUIkgbNbR6YApIhHxuvDOaww8exd99sNeEi7GhMd7qf1R5By9idU2KkHgwZGr
         eiE5szsIMAXPSSamFJhAHQq4rDr/kZX+1QovWe4vnk2BZVU7FcDW31BgQ14rSj3wQv/e
         C8Kv6Qjn9VIPEk443+Pd+69LlsjgPQP55N8+Wv2jL/6qRKk0Jj1OhTYIt//krNF6HHQL
         E7Fw==
X-Gm-Message-State: AJIora/SkghBIctSitFDMgtMAJ3UB7tmbt9hLESwT8xeMrHzntcsiC/s
        i5GazMX4dCROzgyodtk+FK8=
X-Google-Smtp-Source: AGRyM1uNVRaBXmfIUfA0uziPrBwe+OcObVEYHAxR9T1Y2dShkmHLDrPUGC//TS6mQiijKioA5yNFfw==
X-Received: by 2002:a05:6402:1774:b0:435:7fea:8c02 with SMTP id da20-20020a056402177400b004357fea8c02mr14085854edb.213.1655827651406;
        Tue, 21 Jun 2022 09:07:31 -0700 (PDT)
Received: from localhost.localdomain ([185.107.57.61])
        by smtp.gmail.com with ESMTPSA id p6-20020a17090653c600b00722e0b1fa8esm1772943ejo.164.2022.06.21.09.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 09:07:31 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] dt-bindings: clock: qcom,msm8996-apcc: Fix clocks
Date:   Tue, 21 Jun 2022 20:06:20 +0400
Message-Id: <20220621160621.24415-6-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220621160621.24415-1-y.oudjana@protonmail.com>
References: <20220621160621.24415-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yassine Oudjana <y.oudjana@protonmail.com>

The clocks currently listed in clocks and clock-names are the ones
supplied by this clock controller, not the ones it consumes. Replace
them with the only clock it consumes - the on-board oscillator (XO),
and make the properties required.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 .../bindings/clock/qcom,msm8996-apcc.yaml         | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml b/Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml
index a20cb10636dd..c4971234fef8 100644
--- a/Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml
@@ -26,22 +26,18 @@ properties:
 
   clocks:
     items:
-      - description: Primary PLL clock for power cluster (little)
-      - description: Primary PLL clock for perf cluster (big)
-      - description: Alternate PLL clock for power cluster (little)
-      - description: Alternate PLL clock for perf cluster (big)
+      - description: XO source
 
   clock-names:
     items:
-      - const: pwrcl_pll
-      - const: perfcl_pll
-      - const: pwrcl_alt_pll
-      - const: perfcl_alt_pll
+      - const: xo
 
 required:
   - compatible
   - reg
   - '#clock-cells'
+  - clocks
+  - clock-names
 
 additionalProperties: false
 
@@ -51,4 +47,7 @@ examples:
         compatible = "qcom,msm8996-apcc";
         reg = <0x6400000 0x90000>;
         #clock-cells = <1>;
+
+        clocks = <&xo_board>;
+        clock-names = "xo";
     };
-- 
2.36.1

