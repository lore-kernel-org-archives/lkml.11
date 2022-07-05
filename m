Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07824C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Jul 2022 11:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbiGELle (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Jul 2022 07:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbiGELlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 07:41:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93454165B8;
        Tue,  5 Jul 2022 04:40:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3CADDB817AD;
        Tue,  5 Jul 2022 11:40:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F3BC341DD;
        Tue,  5 Jul 2022 11:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657021256;
        bh=M/7E7Sp2xPyh/sHX0nhw0OO7Yo7WLm4QfvTwayPUVNM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SZKAUXiuDSE7QCcVuWk3uGhIcnD9v/ub/4G6VT1clglFNUny+r6qaV2Y1qMyX8tbD
         ACStLwujvQgbygO8poYYXCd6QlzjJQUaFsp6/H4v2G4QChPlL7gD2D8NREo4xWFSD/
         Cc2gaxtkXGzIlvpFQFTIvDZQtA4uj+Hs/RtXlyI8vSDAkr93XRASSfcDCngLUaBVZD
         HivlR3WG2pBTniDsEvBLrHv6iv+qdE1ZO0hbA2DntCrHDhq4x1rZZ3sDO4ClDMJWug
         ViNVnAh9gt6udJbdFNDxwltwpCqSWTeohNRfRoRWa5E1o0c99lvzrBf7DxW/QVjkyr
         HJQxBFKEtXzcg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o8gvJ-0005xj-Kh; Tue, 05 Jul 2022 13:40:57 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 07/14] arm64: dts: qcom: sm8350: drop USB PHY clock index
Date:   Tue,  5 Jul 2022 13:40:25 +0200
Message-Id: <20220705114032.22787-8-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220705114032.22787-1-johan+linaro@kernel.org>
References: <20220705114032.22787-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The QMP USB PHY provides a single clock so drop the redundant clock
index.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 743cba9b683c..7e399d739cd9 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -2381,7 +2381,7 @@ usb_1_ssphy: phy@88e9200 {
 				      <0 0x088e9800 0 0x200>,
 				      <0 0x088e9a00 0 0x100>;
 				#phy-cells = <0>;
-				#clock-cells = <1>;
+				#clock-cells = <0>;
 				clocks = <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
 				clock-names = "pipe0";
 				clock-output-names = "usb3_phy_pipe_clk_src";
@@ -2411,7 +2411,7 @@ usb_2_ssphy: phy@88ebe00 {
 				      <0 0x088ec000 0 0x200>,
 				      <0 0x088eb200 0 0x1100>;
 				#phy-cells = <0>;
-				#clock-cells = <1>;
+				#clock-cells = <0>;
 				clocks = <&gcc GCC_USB3_SEC_PHY_PIPE_CLK>;
 				clock-names = "pipe0";
 				clock-output-names = "usb3_uni_phy_pipe_clk_src";
-- 
2.35.1

