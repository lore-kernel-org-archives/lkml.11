Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486BDC2BB41
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Aug 2022 14:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbiHPOYZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Aug 2022 10:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235809AbiHPOYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 10:24:23 -0400
Received: from smtp.smtpout.orange.fr (smtp01.smtpout.orange.fr [80.12.242.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC3161D9F
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 07:24:21 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id NxUOonfIjLFqbNxUPoHQGV; Tue, 16 Aug 2022 16:24:20 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 16 Aug 2022 16:24:20 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/2] stmmac: intel: Simplify intel_eth_pci_remove()
Date:   Tue, 16 Aug 2022 16:24:15 +0200
Message-Id: <2aeb1a03d07c686efd8b3e6fc8ff2d45cd7da1e8.1660659689.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <d7c8c1dadf40df3a7c9e643f76ffadd0ccc1ad1b.1660659689.git.christophe.jaillet@wanadoo.fr>
References: <d7c8c1dadf40df3a7c9e643f76ffadd0ccc1ad1b.1660659689.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point to call pcim_iounmap_regions() in the remove function,
this frees a managed resource that would be release by the framework
anyway.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
Change in v2:
  * (no code change)
  * Remove the text added below the --- in v1 (see link below if
    needed)
  * Add Reviewed-by:

v1:
  https://lore.kernel.org/all/9f82d58aa4a6c34ec3c734399a4792d3aa23297f.1659204745.git.christophe.jaillet@wanadoo.fr/
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index 4f2b82a884b9..9af25be42401 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -1136,8 +1136,6 @@ static void intel_eth_pci_remove(struct pci_dev *pdev)
 
 	clk_disable_unprepare(priv->plat->stmmac_clk);
 	clk_unregister_fixed_rate(priv->plat->stmmac_clk);
-
-	pcim_iounmap_regions(pdev, BIT(0));
 }
 
 static int __maybe_unused intel_eth_pci_suspend(struct device *dev)
-- 
2.34.1

