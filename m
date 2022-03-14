Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A57C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Mar 2022 12:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240314AbiCNMDf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Mar 2022 08:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240336AbiCNMCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 08:02:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944F548E7B;
        Mon, 14 Mar 2022 05:00:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6579C61260;
        Mon, 14 Mar 2022 12:00:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69FA4C340ED;
        Mon, 14 Mar 2022 12:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647259200;
        bh=HsN3ea+pGBixgNb6E6XkYeexSxxETtROPScpPCIEJhw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hNRlma8HSQ4S7bvQqTVF1A3d8CV2XBPIX64Ir2Vuc3jQ2DyGeZwU5FnwARfNwnU34
         SW0J0hNbKIf5jvfszucP9vR8Wunt9t7aAar4g9J5F1Ae6DBYzvvPC8H99fGZMOhvmj
         26L7bogT6FHddQ08UX00NXZ90/P7+LZ+XZKFKD2U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 25/71] net: ethernet: lpc_eth: Handle error for clk_enable
Date:   Mon, 14 Mar 2022 12:53:18 +0100
Message-Id: <20220314112738.637983827@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220314112737.929694832@linuxfoundation.org>
References: <20220314112737.929694832@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiasheng Jiang <jiasheng@iscas.ac.cn>

[ Upstream commit 2169b79258c8be803d2595d6456b1e77129fe154 ]

As the potential failure of the clk_enable(),
it should be better to check it and return error
if fails.

Fixes: b7370112f519 ("lpc32xx: Added ethernet driver")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/nxp/lpc_eth.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/nxp/lpc_eth.c b/drivers/net/ethernet/nxp/lpc_eth.c
index 9e098e40fb1c..a9a9bf2e065a 100644
--- a/drivers/net/ethernet/nxp/lpc_eth.c
+++ b/drivers/net/ethernet/nxp/lpc_eth.c
@@ -1468,6 +1468,7 @@ static int lpc_eth_drv_resume(struct platform_device *pdev)
 {
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct netdata_local *pldat;
+	int ret;
 
 	if (device_may_wakeup(&pdev->dev))
 		disable_irq_wake(ndev->irq);
@@ -1477,7 +1478,9 @@ static int lpc_eth_drv_resume(struct platform_device *pdev)
 			pldat = netdev_priv(ndev);
 
 			/* Enable interface clock */
-			clk_enable(pldat->clk);
+			ret = clk_enable(pldat->clk);
+			if (ret)
+				return ret;
 
 			/* Reset and initialize */
 			__lpc_eth_reset(pldat);
-- 
2.34.1



