Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD364C25B08
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Aug 2022 22:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242375AbiHQWbo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Aug 2022 18:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242118AbiHQWb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 18:31:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A1189CFD;
        Wed, 17 Aug 2022 15:31:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A51BEB81FCD;
        Wed, 17 Aug 2022 22:31:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E09CC433D6;
        Wed, 17 Aug 2022 22:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660775483;
        bh=+f5vUyFk8LNBgRK/tYjlEojdbW+nOMIfmCnMROC/v4o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JMNMys8lOck7EBZXGMb/vbBVIK5gKpCJsL6S6Lul7o8av7Inh72RV9CuhTsZp8dR1
         7afM+eCn/UKArcOq6aSQhqZMUU9NNBZaLWqlU+BKbWTUKeUBZpy1PCmtfYoGGqPmAs
         PvfEV0f2awVQId8/nFyaeSUU39HuBdpqkfuyP0J7a6CQJ1DoJjbYq5wm9QAeIhgx4a
         JDGUZEeMjZYmZBvneM6A1JwdXmD9X7V2NJF8/K2OP2sBKhZnr2asPL3mWEgBRGjPUq
         HOl6mqKbCm/eGo5ERU1fms0ElGOanhzCQcliUpiyHcFrNeD3I06pPfMomqscBgQs+N
         ujd39e7b2+aXQ==
Received: by pali.im (Postfix)
        id 5E49727CB; Thu, 18 Aug 2022 00:31:20 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 2/6] ARM: dts: armada-370: Fix assigned-addresses for every PCIe Root Port
Date:   Thu, 18 Aug 2022 00:30:49 +0200
Message-Id: <20220817223053.31141-3-pali@kernel.org>
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

Fixes: a09a0b7c6ff1 ("arm: mvebu: add PCIe Device Tree informations for Armada 370")
Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/arm/boot/dts/armada-370.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index e26005bc328a..9daece786a53 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -84,7 +84,7 @@
 
 			pcie2: pcie@2,0 {
 				device_type = "pci";
-				assigned-addresses = <0x82002800 0 0x80000 0 0x2000>;
+				assigned-addresses = <0x82001000 0 0x80000 0 0x2000>;
 				reg = <0x1000 0 0 0 0>;
 				#address-cells = <3>;
 				#size-cells = <2>;
-- 
2.20.1

