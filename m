Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D21BC28B2B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Aug 2022 15:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350804AbiHSP5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Aug 2022 11:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350806AbiHSPzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 11:55:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AFB10476C;
        Fri, 19 Aug 2022 08:50:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08275616F9;
        Fri, 19 Aug 2022 15:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC98C433C1;
        Fri, 19 Aug 2022 15:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660924225;
        bh=NZXzu7cVGXXB/nusfk8PNhWsU7Tedr6sdn/56oyxKnY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1BemEo0iVun40nRqozIxbpfug5aEFOve5FaLRhEDA/bMlrfA3Wt+7ShqZ6J9hQArs
         uZtn+mYoT3qYjGi7ryWeAwAByEXinm3h+M8LTEBvzZi3Q3+b0bnOKKq/Bdph8fqRF/
         vBCtnDVC+pWcGeJsW886AizjmeApvxGIBHZKoMMU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robert Marko <robimarko@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 099/545] arm64: dts: qcom: ipq8074: fix NAND node name
Date:   Fri, 19 Aug 2022 17:37:49 +0200
Message-Id: <20220819153833.708274617@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220819153829.135562864@linuxfoundation.org>
References: <20220819153829.135562864@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Marko <robimarko@gmail.com>

[ Upstream commit b39961659ffc3c3a9e3d0d43b0476547b5f35d49 ]

Per schema it should be nand-controller@79b0000 instead of nand@79b0000.
Fix it to match nand-controller.yaml requirements.

Signed-off-by: Robert Marko <robimarko@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Link: https://lore.kernel.org/r/20220621120642.518575-1-robimarko@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index dca040f66f5f..99e2488b92dc 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -383,7 +383,7 @@ qpic_bam: dma@7984000 {
 			status = "disabled";
 		};
 
-		qpic_nand: nand@79b0000 {
+		qpic_nand: nand-controller@79b0000 {
 			compatible = "qcom,ipq8074-nand";
 			reg = <0x079b0000 0x10000>;
 			#address-cells = <1>;
-- 
2.35.1



