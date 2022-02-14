Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C482BC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Feb 2022 11:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351981AbiBNLz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Feb 2022 06:55:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352167AbiBNLzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:55:54 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAC0C51;
        Mon, 14 Feb 2022 03:55:47 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 8756C223EF;
        Mon, 14 Feb 2022 12:55:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1644839745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Lgm3+ejR5iCeubB0LLMdHYvyTni/SmF/Frp1FWA+zQ=;
        b=Ih6TLdDvJPtLctBVsDxiJhcD2Eb5ETy4cU/e0NdRiw+vZxdYAv66Pml8YcN95UjUf4XryW
        /BXGj0pNOEaGqtBiz/Q6FQ10BvOqGBRsfN4Gjl/3HljIppgnckGvx+5JMPzOEsC2z2Yzrm
        YoHEYnb2PEr4ntfxo4xRfTsWNcQORKc=
From:   Michael Walle <michael@walle.cc>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2 3/3] arm64: dts: ls1028a: add efuse node
Date:   Mon, 14 Feb 2022 12:55:29 +0100
Message-Id: <20220214115529.662948-4-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220214115529.662948-1-michael@walle.cc>
References: <20220214115529.662948-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Layerscape SoCs contain a Security Fuse Processor which is basically a
efuse controller. Add the node, so userspace can read the efuses.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 7d44102d9c6c..4b248cee830a 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -224,6 +224,17 @@ rst: syscon@1e60000 {
 			little-endian;
 		};
 
+		efuse@1e80000 {
+			compatible = "fsl,ls1028a-sfp";
+			reg = <0x0 0x1e80000 0x0 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			ls1028a_uid: unique-id@1c {
+				reg = <0x1c 0x8>;
+			};
+		};
+
 		scfg: syscon@1fc0000 {
 			compatible = "fsl,ls1028a-scfg", "syscon";
 			reg = <0x0 0x1fc0000 0x0 0x10000>;
-- 
2.30.2

