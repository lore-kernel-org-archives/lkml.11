Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDF1C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Mar 2022 11:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241191AbiCGLjo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Mar 2022 06:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240630AbiCGLjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 06:39:41 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903D022B29;
        Mon,  7 Mar 2022 03:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646653127; x=1678189127;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PNhoQUuxv6ZTZ8pXldFPdRP+qDfnktJ77T039WzFaeE=;
  b=VcKiQ/n5hBM4lNRLFTFAE7iIAA/Z+/nG6E5z/0Ev64YqGnK8klJXnpLA
   WuTgXkEwIYRvETIF4A+oiMV25FvLbJ65S6nR1wVowWjN3M6/Vf3qmx2hQ
   3F6qcQIoFUBgZtFlCIrsskBdn/tZ1ZzUwgWimelIS0EqbSQQ9g1EhIyEJ
   s7j2jvR2347i+YQVu4q5E2PNv4Zmpb5hAXbsPupyGmxr2pQ6tiBw5X3dz
   Zwz+EtY3+98hY53l/ACROvgvEQ4JzwY5tH9WR4DgQDUVMoWa0JoHAlP5S
   7rhLWE+RINQiPgGI08NmMToiB9Y1PndlfFLeF8oq+HGoBRfe50cZsH9Ap
   g==;
X-IronPort-AV: E=Sophos;i="5.90,162,1643698800"; 
   d="scan'208";a="164763027"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Mar 2022 04:38:46 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 7 Mar 2022 04:38:46 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 7 Mar 2022 04:38:42 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <nicolas.ferre@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <claudiu.beznea@microchip.com>,
        <tudor.ambarus@microchip.com>, <robh+dt@kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH] ARM: dts: at91: sama7g5ek: enable pull-up on flexcom3 console lines
Date:   Mon, 7 Mar 2022 13:38:27 +0200
Message-ID: <20220307113827.2419331-1-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Flexcom3 is used as board console serial. There are no pull-ups on these
lines on the board. This means that if a cable is not connected (that has
pull-ups included), stray characters could appear on the console as the
floating pins voltage levels are interpreted as incoming characters.
To avoid this problem, enable the internal pull-ups on these lines.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 arch/arm/boot/dts/at91-sama7g5ek.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91-sama7g5ek.dts b/arch/arm/boot/dts/at91-sama7g5ek.dts
index 08685a10eda1d..dd047a8523907 100644
--- a/arch/arm/boot/dts/at91-sama7g5ek.dts
+++ b/arch/arm/boot/dts/at91-sama7g5ek.dts
@@ -495,7 +495,7 @@ pinctrl_flx0_default: flx0_default {
 	pinctrl_flx3_default: flx3_default {
 		pinmux = <PIN_PD16__FLEXCOM3_IO0>,
 			 <PIN_PD17__FLEXCOM3_IO1>;
-		bias-disable;
+		bias-pull-up;
 	};
 
 	pinctrl_flx4_default: flx4_default {
-- 
2.25.1

