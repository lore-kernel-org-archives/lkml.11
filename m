Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5EAC0502E
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Aug 2022 08:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbiH1IoF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Aug 2022 04:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbiH1Inv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 04:43:51 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146042E6B6
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 01:43:50 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id br21so1603706lfb.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 01:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Q6WIZMI8PqvhPXoz0HyicdGQenyGUyI3TjjgKVNKINY=;
        b=sC2vowPO1zpncuyiuQCH7P8bQ+3hUi6bvUMcI2xmeKUDA89bts9QmffA3+1EAzo35Q
         sunqQK33PZK6fNBWYiGuYqs5ST8dKL32D6C7vt+rLb9C1czOCSH7jtP0mFii9PV6Eble
         snuj2Ie1BAbxHyRSLDAB/f8u/l5eBlWmtZ3sYKm2Mop2usow1RNlW26AuFR1kJCPdsVN
         zuVxIanW5LQHBw90dQuWwQJjD4h/iakNG9c0HYFhirF90B+A/zOvg+gFMzH6q+fDIyuJ
         QzbQ//thWu/rWb66QNCVB0iOpd8ZWee/dqdrdZyJeCBhLXOJ5vYCk1kIYQJbMGiWbhbM
         gciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Q6WIZMI8PqvhPXoz0HyicdGQenyGUyI3TjjgKVNKINY=;
        b=LYAVKSvworkkqnT5l2Zl8DNYk9LtUsLstV01yjNjVmieQ2fThQB9L+fGMTI0sL7T23
         0gzmqtgb8kUBt1Q32It4qcTi+0g8bH6irT1+yTsfGgLVai5P1TGjjDkqIZQ8NcXxXFde
         gRtTaPZ4bJ2rRnpewlGBq8KHMbIj2xRCKncphK0lUq+JSmFnbJX/yihmtX9gjdZhCVbo
         7wt2PcZpojhgof/x63cwBrGrOjVQ3kvsjlyCEaOda9Cq9RG7vht/E1qj3ZNH72OT13bg
         kw53nB3k5U9kmFumjGDNFU+cQ4dEZYHUOx6rAIVUUCzM6Pb+WxLX6yiur77DhOECt8XD
         unww==
X-Gm-Message-State: ACgBeo01koyUjSQaPnFAxOUW10PvLs1GzqwMbpiXb36JA7VyY0916sBL
        GwRRWSNZTFm5R+8R0IKyKnT3Gw==
X-Google-Smtp-Source: AA6agR76Ug6vFeYkaVN1bifoZeICxZub+SU7oeSakCwQsBLIRqaip1HldJekDfcAETJQbeTwR0LRIw==
X-Received: by 2002:a19:5f53:0:b0:492:f5a8:2da9 with SMTP id a19-20020a195f53000000b00492f5a82da9mr4567762lfj.184.1661676229643;
        Sun, 28 Aug 2022 01:43:49 -0700 (PDT)
Received: from krzk-bin.starman.ee (82.131.98.15.cable.starman.ee. [82.131.98.15])
        by smtp.gmail.com with ESMTPSA id c6-20020ac25f66000000b0048afe02c925sm890114lfc.219.2022.08.28.01.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 01:43:49 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 04/14] arm64: dts: qcom: pmk8350: drop incorrect io-channel-ranges
Date:   Sun, 28 Aug 2022 11:43:31 +0300
Message-Id: <20220828084341.112146-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220828084341.112146-1-krzysztof.kozlowski@linaro.org>
References: <20220828084341.112146-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 044b32fa5229 ("dt-bindings:iio:qcom-spmi-vadc drop
incorrect io-channel-ranges from example") the io-channel-ranges are not
allowed in the Qualcomm SPMI PMIC ADC and anyway they are not correct
for IIO provider.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/pmk8350.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/pmk8350.dtsi b/arch/arm64/boot/dts/qcom/pmk8350.dtsi
index 0f94c46a1444..97c9f8ece2a6 100644
--- a/arch/arm64/boot/dts/qcom/pmk8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmk8350.dtsi
@@ -41,7 +41,6 @@ pmk8350_vadc: adc@3100 {
 			interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
 			interrupt-names = "eoc-int-en-set";
 			#io-channel-cells = <1>;
-			io-channel-ranges;
 		};
 
 		pmk8350_adc_tm: adc-tm@3400 {
-- 
2.34.1

