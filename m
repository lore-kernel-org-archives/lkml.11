Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD94C433FE
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Feb 2022 20:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbiBPUim (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Feb 2022 15:38:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiBPUih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 15:38:37 -0500
Received: from smtp.smtpout.orange.fr (smtp10.smtpout.orange.fr [80.12.242.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95272AF3CB
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 12:38:24 -0800 (PST)
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id KR40nslflEuQ2KR41nMhWF; Wed, 16 Feb 2022 21:38:23 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Wed, 16 Feb 2022 21:38:23 +0100
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        netdev@vger.kernel.org
Subject: [PATCH] net: nixge: Use GFP_KERNEL instead of GFP_ATOMIC when possible
Date:   Wed, 16 Feb 2022 21:38:11 +0100
Message-Id: <28d2c8e05951ad02a57eb48333672947c8bb4f81.1645043881.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NIXGE_MAX_JUMBO_FRAME_SIZE is over 9000 bytes and RX_BD_NUM 128.

So this loop allocates more than 1 Mo of memory.

Previous memory allocations in this function already use GFP_KERNEL, so
use __netdev_alloc_skb_ip_align() and an explicit GFP_KERNEL instead of a
implicit GFP_ATOMIC.

This gives more opportunities of successful allocation.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/ethernet/ni/nixge.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ni/nixge.c b/drivers/net/ethernet/ni/nixge.c
index 07a00dd9cfe0..4b3482ce90a1 100644
--- a/drivers/net/ethernet/ni/nixge.c
+++ b/drivers/net/ethernet/ni/nixge.c
@@ -324,8 +324,9 @@ static int nixge_hw_dma_bd_init(struct net_device *ndev)
 					 + sizeof(*priv->rx_bd_v) *
 					 ((i + 1) % RX_BD_NUM));
 
-		skb = netdev_alloc_skb_ip_align(ndev,
-						NIXGE_MAX_JUMBO_FRAME_SIZE);
+		skb = __netdev_alloc_skb_ip_align(ndev,
+						  NIXGE_MAX_JUMBO_FRAME_SIZE,
+						  GFP_KERNEL);
 		if (!skb)
 			goto out;
 
-- 
2.32.0

