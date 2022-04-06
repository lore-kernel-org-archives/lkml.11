Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90623C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 10:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242075AbiDFK4g (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Apr 2022 06:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237608AbiDFKzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 06:55:22 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F3E0515FAC;
        Wed,  6 Apr 2022 00:17:16 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.90,239,1643641200"; 
   d="scan'208";a="115876438"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 06 Apr 2022 16:17:16 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id E5F0441D0712;
        Wed,  6 Apr 2022 16:17:14 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] reset: Kconfig: Make RESET_RZG2L_USBPHY_CTRL depend on ARCH_RZG2L
Date:   Wed,  6 Apr 2022 08:16:47 +0100
Message-Id: <20220406071647.14037-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USBPHY Control block is identical on Renesas RZ/G2L and RZ/V2L SoC's,
so instead of adding dependency for each SoC's add dependency on
ARCH_RZG2L. The ARCH_RZG2L config option is already selected by
ARCH_R9A07G044 and ARCH_R9A07G054.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/reset/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index b496028b6bfa..e0fc80e041ea 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -183,7 +183,7 @@ config RESET_RASPBERRYPI
 
 config RESET_RZG2L_USBPHY_CTRL
 	tristate "Renesas RZ/G2L USBPHY control driver"
-	depends on ARCH_R9A07G044 || COMPILE_TEST
+	depends on ARCH_RZG2L || COMPILE_TEST
 	help
 	  Support for USBPHY Control found on RZ/G2L family. It mainly
 	  controls reset and power down of the USB/PHY.
-- 
2.17.1

