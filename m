Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D936C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jun 2022 09:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbiFGJFm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 05:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238875AbiFGJFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 05:05:11 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20120CA3FC;
        Tue,  7 Jun 2022 02:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654592710; x=1686128710;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y0b/gx80TGhLtYHMOPQ93yc4whRx4q+feLOznlFnaV4=;
  b=fVIo2ecWBSqz5ud4pjMdfpB7b8OaNejoR3+j/SSlBMeGz/NzBTx9DsKe
   L4ZvAwgUEeFtBnI9n14N/gi1+mwYgc2QBwL0P0G29ET5KPEGOM5n7Ib3X
   +QmzgHEZvvt5XHgb3zNwwWt78AvehA4Jimfq3xi2KxmbLkeOFpzCzeWvS
   nTbiixa7jeZpAP+xZTt7WqB/sPjByMDsNcw4TZgjeDGkarmHveCFv+ZDv
   jDdWXVGYq0Jxi5+GdpMXE6izUGt6VirfAp2vq6LL+9aliKNm3a1K9DA52
   FE8PfhlM+bZHMObc8K40s7xeULeGGslT6Sv+v+4DbNFcGsFx83qytCj2e
   g==;
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="167384994"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Jun 2022 02:05:09 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 7 Jun 2022 02:05:08 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 7 Jun 2022 02:05:06 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <claudiu.beznea@microchip.com>,
        <nicolas.ferre@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH 2/2] ARM: dts: at91: sama5d2_icp: fix eeprom compatibles
Date:   Tue, 7 Jun 2022 12:04:55 +0300
Message-ID: <20220607090455.80433-2-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220607090455.80433-1-eugen.hristev@microchip.com>
References: <20220607090455.80433-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The eeprom memories on the board are microchip 24aa025e48, which are 2 Kbits
and are compatible with at24c02 not at24c32.

Fixes: 68a95ef72cefe ("ARM: dts: at91: sama5d2-icp: add SAMA5D2-ICP")
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d2_icp.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sama5d2_icp.dts b/arch/arm/boot/dts/at91-sama5d2_icp.dts
index 806eb1d911d7c..164201a8fbf2d 100644
--- a/arch/arm/boot/dts/at91-sama5d2_icp.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_icp.dts
@@ -329,21 +329,21 @@ &i2c1 {
 	status = "okay";
 
 	eeprom@50 {
-		compatible = "atmel,24c32";
+		compatible = "atmel,24c02";
 		reg = <0x50>;
 		pagesize = <16>;
 		status = "okay";
 	};
 
 	eeprom@52 {
-		compatible = "atmel,24c32";
+		compatible = "atmel,24c02";
 		reg = <0x52>;
 		pagesize = <16>;
 		status = "disabled";
 	};
 
 	eeprom@53 {
-		compatible = "atmel,24c32";
+		compatible = "atmel,24c02";
 		reg = <0x53>;
 		pagesize = <16>;
 		status = "disabled";
-- 
2.25.1

