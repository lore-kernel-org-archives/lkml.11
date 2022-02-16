Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3D1C43217
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Feb 2022 20:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbiBPUQp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Feb 2022 15:16:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiBPUQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 15:16:42 -0500
Received: from smtp.smtpout.orange.fr (smtp10.smtpout.orange.fr [80.12.242.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967615FA1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 12:16:25 -0800 (PST)
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id KQiqnsZojEuQ2KQirnMe4b; Wed, 16 Feb 2022 21:16:23 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Wed, 16 Feb 2022 21:16:23 +0100
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] net: ll_temac: Use GFP_KERNEL instead of GFP_ATOMIC when possible
Date:   Wed, 16 Feb 2022 21:16:16 +0100
Message-Id: <694abd65418b2b3974106a82d758e3474c65ae8f.1645042560.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

XTE_MAX_JUMBO_FRAME_SIZE is over 9000 bytes and the default value for
'rx_bd_num' is RX_BD_NUM_DEFAULT	(i.e. 1024)

So this loop allocates more than 9 Mo of memory.

Previous memory allocations in this function already use GFP_KERNEL, so
use __netdev_alloc_skb_ip_align() and an explicit GFP_KERNEL instead of a
implicit GFP_ATOMIC.

This gives more opportunities of successful allocation.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/ethernet/xilinx/ll_temac_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/ll_temac_main.c b/drivers/net/ethernet/xilinx/ll_temac_main.c
index b900ab5aef2a..0547a3fde561 100644
--- a/drivers/net/ethernet/xilinx/ll_temac_main.c
+++ b/drivers/net/ethernet/xilinx/ll_temac_main.c
@@ -361,8 +361,9 @@ static int temac_dma_bd_init(struct net_device *ndev)
 		lp->rx_bd_v[i].next = cpu_to_be32(lp->rx_bd_p
 			+ sizeof(*lp->rx_bd_v) * ((i + 1) % lp->rx_bd_num));
 
-		skb = netdev_alloc_skb_ip_align(ndev,
-						XTE_MAX_JUMBO_FRAME_SIZE);
+		skb = __netdev_alloc_skb_ip_align(ndev,
+						  XTE_MAX_JUMBO_FRAME_SIZE,
+						  GFP_KERNEL);
 		if (!skb)
 			goto out;
 
-- 
2.32.0

