Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283F9C25B08
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Aug 2022 20:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345793AbiHOUrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Aug 2022 16:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345895AbiHOUpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 16:45:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D061B69DC;
        Mon, 15 Aug 2022 12:08:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35F33B81109;
        Mon, 15 Aug 2022 19:08:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D41AC433D7;
        Mon, 15 Aug 2022 19:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660590503;
        bh=iX+5KEpxJzjiGKEqljQi558Jg2Yeyr5xlw5iP2CRKK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ij8H25rsEty8GQlc0duet/gxeXxZ8EjYDQ3RQGZ9Jj20temLc2dV0cAcRDPaw3V35
         MXYsaQydTW+VSiTHqgHpDf6n1QlYvpbxuNaQn7hY3H4MFkVEXr5xIDEdOcRbLeLbKZ
         YvbofzSb39pye1DNwehY/vYO4E3xJN23AsoShYzk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.18 0263/1095] arm64: dts: qcom: sc7280: fix PCIe clock reference
Date:   Mon, 15 Aug 2022 19:54:22 +0200
Message-Id: <20220815180440.627111474@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220815180429.240518113@linuxfoundation.org>
References: <20220815180429.240518113@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan+linaro@kernel.org>

[ Upstream commit 330fc08dbdd913ac37a31f8aec1a88f68e39ae39 ]

The recent commit that dropped the PCIe PHY clock index failed to update
the PCIe node reference.

Fixes: 531c738fb360 ("arm64: dts: qcom: sc7280: drop PCIe PHY clock index")
Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Link: https://lore.kernel.org/r/20220707064222.15717-1-johan+linaro@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 86898d0b4124..793ac9715da2 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -1839,7 +1839,7 @@ pcie1: pci@1c08000 {
 
 			clocks = <&gcc GCC_PCIE_1_PIPE_CLK>,
 				 <&gcc GCC_PCIE_1_PIPE_CLK_SRC>,
-				 <&pcie1_lane 0>,
+				 <&pcie1_lane>,
 				 <&rpmhcc RPMH_CXO_CLK>,
 				 <&gcc GCC_PCIE_1_AUX_CLK>,
 				 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
-- 
2.35.1



