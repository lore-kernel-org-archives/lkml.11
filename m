Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FE8C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Feb 2022 20:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344297AbiBJUmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Feb 2022 15:42:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344288AbiBJUme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 15:42:34 -0500
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1242F108B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 12:42:33 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.88,359,1635199200"; 
   d="scan'208";a="5603082"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 21:42:32 +0100
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     kernel-janitors@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] net: moxa: use GFP_KERNEL
Date:   Thu, 10 Feb 2022 21:42:15 +0100
Message-Id: <20220210204223.104181-2-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220210204223.104181-1-Julia.Lawall@inria.fr>
References: <20220210204223.104181-1-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Platform_driver probe functions aren't called with locks
held and thus don't need GFP_ATOMIC. Use GFP_KERNEL instead.

Problem found with Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/net/ethernet/moxa/moxart_ether.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/moxa/moxart_ether.c b/drivers/net/ethernet/moxa/moxart_ether.c
index 15179b9529e1..afb7dcadb8d2 100644
--- a/drivers/net/ethernet/moxa/moxart_ether.c
+++ b/drivers/net/ethernet/moxa/moxart_ether.c
@@ -510,14 +510,14 @@ static int moxart_mac_probe(struct platform_device *pdev)
 	}
 
 	priv->tx_buf_base = kmalloc_array(priv->tx_buf_size, TX_DESC_NUM,
-					  GFP_ATOMIC);
+					  GFP_KERNEL);
 	if (!priv->tx_buf_base) {
 		ret = -ENOMEM;
 		goto init_fail;
 	}
 
 	priv->rx_buf_base = kmalloc_array(priv->rx_buf_size, RX_DESC_NUM,
-					  GFP_ATOMIC);
+					  GFP_KERNEL);
 	if (!priv->rx_buf_base) {
 		ret = -ENOMEM;
 		goto init_fail;

