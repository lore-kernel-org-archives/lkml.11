Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E16C43217
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 10:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242223AbiDNKTj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 06:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242213AbiDNKT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 06:19:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA6773049;
        Thu, 14 Apr 2022 03:16:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC4F161E87;
        Thu, 14 Apr 2022 10:16:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA5FAC385BB;
        Thu, 14 Apr 2022 10:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649931417;
        bh=/yBPOid0HYN61SS0bnXkLI6nxZr2F8UTOQPyXqecBkg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EYP/9tAFlIGGjOIsynnK0+IvsVWoW1m11BcG5SSEnuJYE2lB0j/3Jms3a9wkQDV6R
         UGPMPrsCzL65BUeRg4nc/QleTtWQ6jCq4r4OW/xK41mintTtvVSsqy0zjOuxLRfIEZ
         ov/yS7qRNtJvb/0u/zRP0vWWol91CGwvXt6tBJ5sSZRFxo03bQ6xQFcvh1Y3Lnr7jS
         bL5apdR/5N/zBACf9T7nc7bBH/V3t0nKKvaZFtkj5BgZffThB3mTLkYTaTTGTIoLSx
         7luddkxhGxXbETvY7sTMsMsxA0RmbHjHlRaafKuxNnyFthiD5xU5LQ6p6qXoCUFKJ6
         6RewLJ8AsYlBA==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] arm64: dts: qcom: sm8450: Fix missing iommus for qup1
Date:   Thu, 14 Apr 2022 15:46:29 +0530
Message-Id: <20220414101630.1189052-7-vkoul@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220414101630.1189052-1-vkoul@kernel.org>
References: <20220414101630.1189052-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qupv3_id_1 was missing iommus property which cause any dma transaction
to fail and board crash. So add the missing iommus.

Fixes: 5188049c9b36 ("arm64: dts: qcom: Add base SM8450 DTSI")
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 067568c13448..88ec7fe455cf 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -1386,6 +1386,9 @@ qupv3_id_1: geniqup@ac0000 {
 			clock-names = "m-ahb", "s-ahb";
 			clocks = <&gcc GCC_QUPV3_WRAP_1_M_AHB_CLK>,
 				 <&gcc GCC_QUPV3_WRAP_1_S_AHB_CLK>;
+			iommus = <&apps_smmu 0x43 0x0>;
+			interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>;
+			interconnect-names = "qup-core";
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges;
-- 
2.34.1

