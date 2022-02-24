Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EB0C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Feb 2022 15:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236288AbiBXP36 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Feb 2022 10:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236264AbiBXP3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:29:55 -0500
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89EE1BE4C2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:29:22 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:598d:7788:288b:e4f])
        by michel.telenet-ops.be with bizsmtp
        id z3VK260070fvPgN063VKob; Thu, 24 Feb 2022 16:29:19 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nNG3S-001rz5-NJ; Thu, 24 Feb 2022 16:29:18 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nNG3S-00Ciky-9h; Thu, 24 Feb 2022 16:29:18 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] clk: COMMON_CLK_LAN966X should depend on SOC_LAN966
Date:   Thu, 24 Feb 2022 16:29:17 +0100
Message-Id: <eb102eae05e5667b9bd342a0c387f7f262d24bda.1645716471.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LAN966x Generic Clock Controller is only present on Microchip
LAN966x SoCs.  Hence add a dependency on SOC_LAN966, to prevent asking
the user about this driver when configuring a kernel without LAN966x SoC
support.

Fixes: 54104ee023333e3b ("clk: lan966x: Add lan966x SoC clock driver")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/clk/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index c390e26dadf471f5..1c82a3e1129d4342 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -232,6 +232,7 @@ config COMMON_CLK_GEMINI
 
 config COMMON_CLK_LAN966X
 	bool "Generic Clock Controller driver for LAN966X SoC"
+	depends on SOC_LAN966 || COMPILE_TEST
 	help
 	  This driver provides support for Generic Clock Controller(GCK) on
 	  LAN966X SoC. GCK generates and supplies clock to various peripherals
-- 
2.25.1

