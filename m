Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA6AC433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jun 2022 08:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbiFBIEV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jun 2022 04:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbiFBIEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 04:04:11 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D42AB499
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 01:04:09 -0700 (PDT)
Received: from ipservice-092-217-081-045.092.217.pools.vodafone-ip.de ([92.217.81.45] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nwfoJ-0006H9-Cr; Thu, 02 Jun 2022 10:04:03 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/3] clk: imx25: print silicon revision during init
Date:   Thu,  2 Jun 2022 10:03:43 +0200
Message-Id: <20220602080344.208702-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220602080344.208702-1-martin@kaiser.cx>
References: <20220602080344.208702-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print the imx25 silicon revision when the clocks are initialised.

Use the same mechanism as for imx27, i.e. call mx25_revision.
This function is unused at the moment.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/clk/imx/clk-imx25.c | 3 +++
 include/soc/imx/revision.h  | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/clk/imx/clk-imx25.c b/drivers/clk/imx/clk-imx25.c
index 66192fe0a898..263409fca1eb 100644
--- a/drivers/clk/imx/clk-imx25.c
+++ b/drivers/clk/imx/clk-imx25.c
@@ -13,6 +13,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <soc/imx/revision.h>
 
 #include "clk.h"
 
@@ -220,6 +221,8 @@ static int __init __mx25_clocks_init(void __iomem *ccm_base)
 
 	imx_register_uart_clocks(6);
 
+	imx_print_silicon_rev("i.MX25", mx25_revision());
+
 	return 0;
 }
 
diff --git a/include/soc/imx/revision.h b/include/soc/imx/revision.h
index b2a55dafaf0a..b122d2fc8881 100644
--- a/include/soc/imx/revision.h
+++ b/include/soc/imx/revision.h
@@ -22,6 +22,7 @@
 #define IMX_CHIP_REVISION_3_3		0x33
 #define IMX_CHIP_REVISION_UNKNOWN	0xff
 
+int mx25_revision(void);
 int mx27_revision(void);
 int mx31_revision(void);
 int mx35_revision(void);
-- 
2.30.2

