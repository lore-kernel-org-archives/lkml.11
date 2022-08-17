Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F80C32772
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Aug 2022 22:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241977AbiHQWbl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Aug 2022 18:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238139AbiHQWb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 18:31:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40CDA0613;
        Wed, 17 Aug 2022 15:31:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F562B81FCA;
        Wed, 17 Aug 2022 22:31:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E37D3C433C1;
        Wed, 17 Aug 2022 22:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660775483;
        bh=lHd7vnnYU6Dz+Jab0H5NYF/IEToVYVp1pW3Ig8y0c9g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ww890qtMa5QbJRaFq8/lU6A+LC57nOWCU77F8n4yNNu6SmIimxI6IJKiJmD/ajSBl
         nRfhYRWBygHUgA4itR/hoj74cs7jxsiHSHfvE4TnUzLS0ns7xt62b6R31+B/jxAzdN
         yGlgwiJy3DZF+zYUF9H5Dn/zh971Jc31yjD1Sc+3pNtKKiP+B/5b8pT3fQRuk2Kyam
         kAZlXGaeuw6u48sO7Dz5V8JMTIkdG9OQ/xtWHwNAngkbVF41RaoHkx55uYQwJ112Qa
         w5qeBm6CmcnHBsXxvQ7upBqdQ+KYOW5tYlmOJX07CmOX8JmAVnM24LxO10bqVH8zTA
         bPlS7fJjCdJPQ==
Received: by pali.im (Postfix)
        id 9EDEA77A; Thu, 18 Aug 2022 00:31:22 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 4/6] ARM: dts: armada-375: Fix assigned-addresses for every PCIe Root Port
Date:   Thu, 18 Aug 2022 00:30:51 +0200
Message-Id: <20220817223053.31141-5-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220817223053.31141-1-pali@kernel.org>
References: <20220817223053.31141-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BDF of resource in DT assigned-addresses property of Marvell PCIe Root Port
(PCI-to-PCI bridge) should match BDF in address part in that DT node name
as specified resource belongs to Marvell PCIe Root Port itself.

Fixes: 4de59085091f ("ARM: mvebu: add Device Tree description of the Armada 375 SoC")
Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/arm/boot/dts/armada-375.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
index 8df7e46ce961..178a1f1dde4e 100644
--- a/arch/arm/boot/dts/armada-375.dtsi
+++ b/arch/arm/boot/dts/armada-375.dtsi
@@ -597,7 +597,7 @@
 
 			pcie1: pcie@2,0 {
 				device_type = "pci";
-				assigned-addresses = <0x82000800 0 0x44000 0 0x2000>;
+				assigned-addresses = <0x82001000 0 0x44000 0 0x2000>;
 				reg = <0x1000 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
-- 
2.20.1

