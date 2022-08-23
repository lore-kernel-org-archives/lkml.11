Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FFEC32772
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 08:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343549AbiHWIi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 04:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347785AbiHWIgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 04:36:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2C876752;
        Tue, 23 Aug 2022 01:17:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22BAD61257;
        Tue, 23 Aug 2022 08:17:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28E8FC433D7;
        Tue, 23 Aug 2022 08:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661242639;
        bh=/8UyoVEL/6prq7euy3iXui/QYxwtGVXrnVvgQbV3Lk0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hxlAUA+Ov/Lu93r9VF9S1wh2smigquzLSH8+mx2JQHfIGDYeVlhvr058EZdDoHSff
         WKa8KGaB80xID0OE5Ccd2Unt5W9pCJQNsc8wt2wTrC07HF2g/gN+OTEs68D/CLWlDi
         UPn2Y5/lEK5JZ1ZEhXYLGvhS6kVTUOkTgi2wRr9s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 5.19 131/365] dt-bindings: clock: qcom,gcc-msm8996: add more GCC clock sources
Date:   Tue, 23 Aug 2022 10:00:32 +0200
Message-Id: <20220823080123.671733279@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220823080118.128342613@linuxfoundation.org>
References: <20220823080118.128342613@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

commit 2b4e75a7a7c8d3531a40ebb103b92f88ff693f79 upstream.

Add additional GCC clock sources. This includes PCIe and USB PIPE and
UFS symbol clocks.

Fixes: 2a8aa18c1131 ("dt-bindings: clk: qcom: Fix self-validation, split, and clean cruft")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Link: https://lore.kernel.org/r/20220620071936.1558906-2-dmitry.baryshkov@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/devicetree/bindings/clock/qcom,gcc-msm8996.yaml |   16 ++++++++++
 1 file changed, 16 insertions(+)

--- a/Documentation/devicetree/bindings/clock/qcom,gcc-msm8996.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-msm8996.yaml
@@ -22,16 +22,32 @@ properties:
     const: qcom,gcc-msm8996
 
   clocks:
+    minItems: 3
     items:
       - description: XO source
       - description: Second XO source
       - description: Sleep clock source
+      - description: PCIe 0 PIPE clock (optional)
+      - description: PCIe 1 PIPE clock (optional)
+      - description: PCIe 2 PIPE clock (optional)
+      - description: USB3 PIPE clock (optional)
+      - description: UFS RX symbol 0 clock (optional)
+      - description: UFS RX symbol 1 clock (optional)
+      - description: UFS TX symbol 0 clock (optional)
 
   clock-names:
+    minItems: 3
     items:
       - const: cxo
       - const: cxo2
       - const: sleep_clk
+      - const: pcie_0_pipe_clk_src
+      - const: pcie_1_pipe_clk_src
+      - const: pcie_2_pipe_clk_src
+      - const: usb3_phy_pipe_clk_src
+      - const: ufs_rx_symbol_0_clk_src
+      - const: ufs_rx_symbol_1_clk_src
+      - const: ufs_tx_symbol_0_clk_src
 
   '#clock-cells':
     const: 1


