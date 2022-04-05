Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2702C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 06:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbiDEHAG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 03:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbiDEHAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 03:00:00 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519367EA1A
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 23:58:02 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id k23so21189938ejd.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 23:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6a4whhXq8xdge76IgYoCHrL2FoyW/DFqlQKK+cWx+tE=;
        b=ZJHLcRL1YakrmvRFLp+ZmgaXLIrXF09PvNE0fog849Gfwq0K/2YZqFhVASIXjKLsa8
         /2tMxswNPcZN/5CIUGMZ5rxk5qKvvFyMlLtBWIm0DdXUyevLAIf4lMjmJKYLvUb71y31
         zXXrlewGt+iqiAcLU/vY3RfxO/TH7rSbeZCXq3AAME9i2dvIzKpgWsDQQkiUQaXosqEr
         DynSQu7JKbeHVU5wihC68XGNAxxtA3znpnqE2r9ycfPBUt7O15hVRh9noWO/ykkVInVq
         XlIMaPxP7iQF2N6ZQTHQen6ucu5cXOvSwSch62+eck2V/918Gt8MoZyEuvHoGWZpU4wo
         LReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6a4whhXq8xdge76IgYoCHrL2FoyW/DFqlQKK+cWx+tE=;
        b=EEcz9jtkEB+U7UxycJUPSbZp7KXD0QsbMBzE6U+IL64g575VE72qeWiOxvUdckaugD
         InA3iCcBXYjCzD0sviS54iCizoX1hiEw+20RtaovPOQQp6v/iZDbXyo05IkvCzUVXbhA
         XG5TxhciJqzsSrE1ExZKAuD8E9kETjzGLn4hPdlmhTlzbuntk4GZwUthZ/YYq/QDO7jD
         fEdtlbaqCjluCHeQL5wxXuLIcQiKvblUfPTfx0Fpwp5Rf2dSDnS3QoJcaC6qhSdNiY+8
         IGEPClSdq1iSvyvcxLBh+ra379TSM30fnK2Ri+Nck6705rnB4bHwHxHvHID+YIrK9rEJ
         slwA==
X-Gm-Message-State: AOAM530phiW3PIbEGQqjVbctD2MmwYKenRTxKCDD9MvRkz9j9TeNSjrA
        EihEtmqJ57w39W/f8vHXO4P5gg==
X-Google-Smtp-Source: ABdhPJyfNzFcFmbqujbKXQBjJG49OBM/Nn2E4LiD8zF9LmxpEc1HW4phIcgCY72UAywHtZnsOGPjrw==
X-Received: by 2002:a17:906:3042:b0:6cd:20ed:7c5c with SMTP id d2-20020a170906304200b006cd20ed7c5cmr1994575ejd.241.1649141880927;
        Mon, 04 Apr 2022 23:58:00 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id f17-20020a056402355100b0041925e80963sm6367419edd.41.2022.04.04.23.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 23:58:00 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 2/3] arm64: dts: qcom: msm8916: rename WCNSS child name to bluetooth
Date:   Tue,  5 Apr 2022 08:57:51 +0200
Message-Id: <20220405065752.27389-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220405065752.27389-1-krzysztof.kozlowski@linaro.org>
References: <20220405065752.27389-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "bluetooth" is more popular and more descriptive than "bt", for a
Bluetooth device.  The WCNSS DT schema will expect such naming.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. None.
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index cf0482fdf69d..9a496b7b78fb 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1788,7 +1788,7 @@ wcnss_ctrl: wcnss {
 
 					qcom,mmio = <&pronto>;
 
-					bt {
+					bluetooth {
 						compatible = "qcom,wcnss-bt";
 					};
 
-- 
2.32.0

