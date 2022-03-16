Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69F1C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Mar 2022 15:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357247AbiCPPP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Mar 2022 11:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240433AbiCPPPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 11:15:01 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B69D44771;
        Wed, 16 Mar 2022 08:13:37 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id C5F061F44681
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647443615;
        bh=6XdHparrNynql5aI5JDISRsUDYEhB7brv5rqIJfGbOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LQdSkPXBBpWphzqB2vlbw3lyC7guiYbHqG7S+Fkajzu0NGPBLZnROInbMF1zm/ef3
         dD0jPE2IiFpeSOlvQD0Q/AnMe317I8a60t2IUMUfsPRa3m8huuwnoNqyVeVPwW+3IW
         LuGwM3bfzuuSFAFa6VY/q5jcmHnp93iZiSrS1xAzf2lupNXzVhOkXNL6ilgQ0tNFg/
         QdGHdQq03NAkQEfMOJK3pxQbMWBZdpHsEymAi0hoaF8V/S/bm18a46K36l6CL4T+3z
         3QVxnJ8OIQ8s5TpKudfVdlQdvvkLJW4xOikvxLq2qEG2wBDXhqpVY7PWMcWtJBCQo7
         omarGcoGldLiA==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH v1 03/10] arm64: dts: mediatek: asurada: Add system-wide power supplies
Date:   Wed, 16 Mar 2022 11:13:20 -0400
Message-Id: <20220316151327.564214-4-nfraprado@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220316151327.564214-1-nfraprado@collabora.com>
References: <20220316151327.564214-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add system-wide power supplies present on all of the boards in the
Asurada family.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---

 .../boot/dts/mediatek/mt8192-asurada.dtsi     | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
index e10636298639..5cb7580a13cf 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
@@ -19,6 +19,70 @@ memory@40000000 {
 		device_type = "memory";
 		reg = <0 0x40000000 0 0x80000000>;
 	};
+
+	/* system wide LDO 1.8V power rail */
+	pp1800_ldo_g: pp1800-ldo-g {
+		compatible = "regulator-fixed";
+		regulator-name = "pp1800_ldo_g";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&pp3300_g>;
+	};
+
+	/* system wide switching 3.3V power rail */
+	pp3300_g: pp3300-g {
+		compatible = "regulator-fixed";
+		regulator-name = "pp3300_g";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&ppvar_sys>;
+	};
+
+	/* system wide LDO 3.3V power rail */
+	pp3300_ldo_z: pp3300-ldo-z {
+		compatible = "regulator-fixed";
+		regulator-name = "pp3300_ldo_z";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&ppvar_sys>;
+	};
+
+	/* separately switched 3.3V power rail */
+	pp3300_u: pp3300-u {
+		compatible = "regulator-fixed";
+		regulator-name = "pp3300_u";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		/* enable pin wired to GPIO controlled by EC */
+		vin-supply = <&pp3300_g>;
+	};
+
+	/* system wide switching 5.0V power rail */
+	pp5000_a: pp5000-a {
+		compatible = "regulator-fixed";
+		regulator-name = "pp5000_a";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&ppvar_sys>;
+	};
+
+	/* system wide semi-regulated power rail from battery or USB */
+	ppvar_sys: ppvar-sys {
+		compatible = "regulator-fixed";
+		regulator-name = "ppvar_sys";
+		regulator-always-on;
+		regulator-boot-on;
+	};
 };
 
 &pio {
-- 
2.35.1

