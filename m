Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15848ECAAA1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Aug 2022 11:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbiH3Lc2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Aug 2022 07:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiH3LaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 07:30:09 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8380A21E00;
        Tue, 30 Aug 2022 04:30:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CA752CE1AA6;
        Tue, 30 Aug 2022 11:30:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54C9CC4FEBD;
        Tue, 30 Aug 2022 11:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661859000;
        bh=j1dhx1YqSNY9UPQU8mPTaGXSGfew5NKMLBnGxEcHOCE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nB1vOLaazuvmQk/BTmxjdREpv5sD2Qpw0ohIyjynrusTMw/UO8XQbuRxTo1DwmgWH
         wBAlmRKzwVdhwKI22wifhJFGWGsViYCLbmfzMPPzKHB77aFGIcsdAJgcaWot6wI3ou
         EL1Yep/IWne5qomCox80FWKn99/kaYr+mMwg+MHEl6xrNsqRl01AvbqDicNvGH8w/t
         rzP+nVCZOoR2zdhrhhSixnL0F1SNcKGFs8Fwxpk0T8fP3JUzdzHhELpuFPwPfuLbi8
         UiXAFB9Rd5g/FJHeDAkOGwvhaa6euofcrv6TYVunnQSwp8CMEvgz/ciKYBApRXgXNP
         gm4C7EE2P78mQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oSzRO-00010U-2M; Tue, 30 Aug 2022 13:29:58 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 14/30] dt-bindings: phy: qcom,qmp-pcie: deprecate PIPE clock name
Date:   Tue, 30 Aug 2022 13:29:07 +0200
Message-Id: <20220830112923.3725-15-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220830112923.3725-1-johan+linaro@kernel.org>
References: <20220830112923.3725-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deprecate the PHY node 'clock-names' property which specified that the
PIPE clock name should have a bogus "lane" suffix.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml
index 5466a6d35e2a..324ad7d03a38 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml
@@ -78,6 +78,7 @@ patternProperties:
           - description: PIPE clock
 
       clock-names:
+        deprecated: true
         items:
           - const: pipe0
 
@@ -93,7 +94,6 @@ patternProperties:
     required:
       - reg
       - clocks
-      - clock-names
       - "#clock-cells"
       - clock-output-names
       - "#phy-cells"
@@ -287,7 +287,6 @@ examples:
                   <0xe00 0xf4>;
 
             clocks = <&gcc GCC_PCIE_1_PIPE_CLK>;
-            clock-names = "pipe0";
 
             #clock-cells = <0>;
             clock-output-names = "pcie_1_pipe_clk";
-- 
2.35.1

