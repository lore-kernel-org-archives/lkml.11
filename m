Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B113C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Mar 2022 14:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243885AbiC1Ocg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Mar 2022 10:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243861AbiC1Oca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 10:32:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20870434B8;
        Mon, 28 Mar 2022 07:30:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1FC6B80E72;
        Mon, 28 Mar 2022 14:30:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16AA8C3410F;
        Mon, 28 Mar 2022 14:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648477847;
        bh=SRl95RjWY1dF6XaJGOl9tSAZZMHAcJr32gLMJM8D2Qs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KuYcpv4K0ESi2O7521ZxfZY0sKrHBynbr6lRyV8vpazrAo5utgoAXId+VjPFckE1y
         OsUDQK4Re3r6oi5BJQWX7JEE4PHM/KSRUmlNoydx0pnWn76dsWW7EM/uCa9fnbgF8T
         EmYGoIbpEf2CTZV793N1MIukMENdP0px/6ahE02o5Lqipp01huFAHKfD4HSuzHdC6J
         rr+HBJ9rCl02vdr7+irxQ13VaHrmNTOnGRJSgKZs8UFM6LTVHTWsF6AlvutkwqgSRE
         8IjUtGARI/Ose9uPAoAWcKuZ841HKpVuYXckYAmVXOPJd2fvlgn5sRIYE6Fxt+Fl80
         cbGyn51729Vyw==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] arm64: dts: qcom: sm8450: rename interconnect nodes
Date:   Mon, 28 Mar 2022 20:00:30 +0530
Message-Id: <20220328143035.519909-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220328143035.519909-1-vkoul@kernel.org>
References: <20220328143035.519909-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clk-virt and mc-virt interconnect nodes were named interconnect@0 and
interconnect@1. That is incorrect as we don't have unit addresses 0/1
for these node.

This causes warning:
arch/arm64/boot/dts/qcom/sm8450.dtsi:255.27-259.4:
	Warning (unit_address_vs_reg): /interconnect@0:
	node has a unit name, but no reg or ranges property
arch/arm64/boot/dts/qcom/sm8450.dtsi:261.26-265.4:
	Warning (unit_address_vs_reg): /interconnect@1:
	node has a unit name, but no reg or ranges property
arch/arm64/boot/dts/qcom/sm8450.dtsi:255.27-259.4:
	Warning (unique_unit_address_if_enabled): /interconnect@0:
	duplicate unit-address (also used in node /soc@0)

Rename the nodes to interconnect-0 and interconnect-1 to fix the
warning.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 934e29b9e153..b0128d115e7a 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -252,13 +252,13 @@ scm: scm {
 		};
 	};
 
-	clk_virt: interconnect@0 {
+	clk_virt: interconnect-0 {
 		compatible = "qcom,sm8450-clk-virt";
 		#interconnect-cells = <2>;
 		qcom,bcm-voters = <&apps_bcm_voter>;
 	};
 
-	mc_virt: interconnect@1 {
+	mc_virt: interconnect-1 {
 		compatible = "qcom,sm8450-mc-virt";
 		#interconnect-cells = <2>;
 		qcom,bcm-voters = <&apps_bcm_voter>;
-- 
2.34.1

