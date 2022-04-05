Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC531C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 07:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbiDEHxl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 03:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbiDEHrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 03:47:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D9FA146B;
        Tue,  5 Apr 2022 00:44:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D99A7616C6;
        Tue,  5 Apr 2022 07:44:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B65C340EE;
        Tue,  5 Apr 2022 07:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649144654;
        bh=VenW7vLzvFAZIPkgA7zsJp5l095WQskP/irONiRtHdY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MFHoWbR9HfN7ne2jVPuh9rD9Cv+xam2FhM+zYkXKD52imdm0/KXU//D4cdVRIH4f3
         LWJH5CKzv1WHRJiMpRGKX3xPk9gp1bt9IrYuPUe6luYoq0aKWqKfXVeDeXY8ev1j0q
         clZ6lBoV47mP+lOI5j2peHiVgHUjZsRzEuMEafWI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jordan Crouse <jordan@cosmicpenguin.net>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 5.17 0122/1126] arm64: dts: qcom: sm8250: Fix MSI IRQ for PCIe1 and PCIe2
Date:   Tue,  5 Apr 2022 09:14:29 +0200
Message-Id: <20220405070411.155237772@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070407.513532867@linuxfoundation.org>
References: <20220405070407.513532867@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

commit 1b7101e8124b450f2d6a35591e9cbb478c143ace upstream.

Fix the MSI IRQ used for PCIe instances 1 and 2.

Cc: stable@vger.kernel.org
Fixes: e53bdfc00977 ("arm64: dts: qcom: sm8250: Add PCIe support")
Reported-by: Jordan Crouse <jordan@cosmicpenguin.net>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Link: https://lore.kernel.org/r/20220112035556.5108-1-manivannan.sadhasivam@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -1801,7 +1801,7 @@
 			ranges = <0x01000000 0x0 0x40200000 0x0 0x40200000 0x0 0x100000>,
 				 <0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x1fd00000>;
 
-			interrupts = <GIC_SPI 306 IRQ_TYPE_EDGE_RISING>;
+			interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
@@ -1907,7 +1907,7 @@
 			ranges = <0x01000000 0x0 0x64200000 0x0 0x64200000 0x0 0x100000>,
 				 <0x02000000 0x0 0x64300000 0x0 0x64300000 0x0 0x3d00000>;
 
-			interrupts = <GIC_SPI 236 IRQ_TYPE_EDGE_RISING>;
+			interrupts = <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;


