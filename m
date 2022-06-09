Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF873C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jun 2022 11:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244437AbiFILmV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jun 2022 07:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244198AbiFILlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:41:04 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A41B1DC850
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 04:40:24 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id w27so30761539edl.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 04:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8KUiL3np2ygfecmy1I7ARIj+Q5w0zv0RhTyVvk3vWH4=;
        b=ZfKVGFlwB0drMUpClH6ongnfbVocJ0aqGHXDS1dsMV50ImoeWbAyRxLd/rHuTeXR/T
         AJwBFWLIJtbVf9dNdY7wpfGDOFdrfspUlyU2+AU7m4YhuhcWezFGQGA4s/SkHBf7xihy
         LHBsvGnEUhPmiLPWiGMVeBGXQSZi1eORQEj9fNDnPskVHaJtQ4aa7Mvt9LUzAJD/UpLg
         vFBwTXazpJwJOWp/63jYbRprEyF9akD8QtIPCgh2PgUF98CksArZKHjoTxyTcSE6CrLH
         hldtJEqSIW+bIYkShF4H5En8f+ReUjh0DAQwEzwigzMtSH/Fkq12OiZ3L0nH/++Yr804
         22KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8KUiL3np2ygfecmy1I7ARIj+Q5w0zv0RhTyVvk3vWH4=;
        b=DRiHPYq9Bd1yuo/pjr5caUWN2iqF0zm5lf49tKgG2oleMB7x7VD1uAFGfqLTSbtVXZ
         yW/Dq/y9RHNHWrisQb6/Yi3PVAQ3bKja8HkkYD3BEy6VXr4MUTrwHLQJmuZhT1+FQv2F
         CAfl0DUk3AjNp5bDfsnSTE30RT5ImbcHneeg60//5cHqWdFn9v2r58jz6Nj4+coTj3Tl
         Mk09UrDIrXeqH9uxMAoWxvUojcNc6GM8u3IiVeenpe57J8dlQqnD5lDIqU+AxMhHWfKS
         cK9c4+ttM90Xin7vEkhAp2HfLGiIC96xoYnSSUfdygqGtmc8NKUN64W3eWdFniDBunOO
         72cQ==
X-Gm-Message-State: AOAM531gUCRAebgtHeA1s4weFSXZOF0AK8rJltTX8HIvZ5sKWP0RRizH
        yM69TPsB3lHmoCbP7po59VZN3g==
X-Google-Smtp-Source: ABdhPJxWyUWnpnMAnMIiVKwloAstsGYLRows2ba9PpTywVn/DLl1wCQGuTV0zQouD8RF+lfJ+Mtqvg==
X-Received: by 2002:a05:6402:17c8:b0:42d:dc6f:f17c with SMTP id s8-20020a05640217c800b0042ddc6ff17cmr45215591edy.17.1654774823223;
        Thu, 09 Jun 2022 04:40:23 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id q1-20020a170906360100b006ff59151e34sm10638441ejb.39.2022.06.09.04.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 04:40:22 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 29/48] arm64: dts: qcom: sdm630-sony-xperia-nile: drop unneeded status from gpio-keys
Date:   Thu,  9 Jun 2022 13:40:02 +0200
Message-Id: <20220609114002.380563-10-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org>
References: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nodes do not need explicit status=okay.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
index 42e89f41eb7d..48720026423d 100644
--- a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
@@ -88,7 +88,6 @@ cam_vana_rear_vreg: cam_vana_rear_vreg {
 	};
 
 	gpio-keys {
-		status = "okay";
 		compatible = "gpio-keys";
 
 		key-camera-focus {
-- 
2.34.1

