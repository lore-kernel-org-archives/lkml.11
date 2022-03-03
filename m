Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69F3C433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Mar 2022 10:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbiCCKJ1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Mar 2022 05:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiCCKJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 05:09:23 -0500
Received: from smtpproxy21.qq.com (smtpbg701.qq.com [203.205.195.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D2A16EAB3
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 02:08:37 -0800 (PST)
X-QQ-mid: bizesmtp77t1646302102tifg48as
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 03 Mar 2022 18:08:16 +0800 (CST)
X-QQ-SSF: 01400000002000C0G000000A0000000
X-QQ-FEAT: 9ftZnmyzxdiuYvImBqaq6XcFBwVql4EFTku9zVY40XIjBWyily0jygL3wvtJF
        laxJIHN2bciK5YnuT7+S/RWLy8aEC3vhbgVPyCqwwTAviBukykHM3mFfXbKYAaxlghwO7jc
        jiFhC5HCHtL7/LON5Qv+CzYQjpWEtrP05wpaw85EAgwcqk1W+13sH8b2yJfVtNIL30qMyCi
        GBsF6Axyf9lbXfAuX+9Fc9QdOKIBO5lIv1PRckIvSd8ailwQgec5U0qBY+reivgRaYC/BkA
        ahgzlEDOow464eLZysBlnreZOG0e0QQdZWPOvbXiOR04T74F4wQGUPswHao0ErF9gsk0Uyf
        aI0GgrP3tbZnpmu01r45wENdOz46Xky0lK8t0F0qcHsBLCz3OTbuloUwjAx9A==
X-QQ-GoodBg: 1
From:   Meng Tang <tangmeng@uniontech.com>
To:     davem@davemloft.net, kuba@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com
Cc:     netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Meng Tang <tangmeng@uniontech.com>
Subject: [PATCH] bcm63xx_enet: Use platform_get_irq() to get the interrupt
Date:   Thu,  3 Mar 2022 18:08:15 +0800
Message-Id: <20220303100815.25605-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on
static allocation of IRQ resources in DT core code, this
causes an issue when using hierarchical interrupt domains
using "interrupts" property in the node as this bypassed
the hierarchical setup and messed up the irq chaining.

In preparation for removal of static setup of IRQ resource
from DT core code use platform_get_irq().

Signed-off-by: Meng Tang <tangmeng@uniontech.com>
---
 drivers/net/ethernet/broadcom/bcm63xx_enet.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bcm63xx_enet.c b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
index b04e423c446a..c1b97e8c55ef 100644
--- a/drivers/net/ethernet/broadcom/bcm63xx_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
@@ -1716,17 +1716,17 @@ static int bcm_enet_probe(struct platform_device *pdev)
 	struct bcm_enet_priv *priv;
 	struct net_device *dev;
 	struct bcm63xx_enet_platform_data *pd;
-	struct resource *res_irq, *res_irq_rx, *res_irq_tx;
+	int irq, irq_rx, irq_tx;
 	struct mii_bus *bus;
 	int i, ret;
 
 	if (!bcm_enet_shared_base[0])
 		return -EPROBE_DEFER;
 
-	res_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	res_irq_rx = platform_get_resource(pdev, IORESOURCE_IRQ, 1);
-	res_irq_tx = platform_get_resource(pdev, IORESOURCE_IRQ, 2);
-	if (!res_irq || !res_irq_rx || !res_irq_tx)
+	irq = platform_get_irq(pdev, 0);
+	irq_rx = platform_get_irq(pdev, 1);
+	irq_tx = platform_get_irq(pdev, 2);
+	if (irq < 0 || irq_rx < 0 || irq_tx < 0)
 		return -ENODEV;
 
 	dev = alloc_etherdev(sizeof(*priv));
@@ -1748,9 +1748,9 @@ static int bcm_enet_probe(struct platform_device *pdev)
 		goto out;
 	}
 
-	dev->irq = priv->irq = res_irq->start;
-	priv->irq_rx = res_irq_rx->start;
-	priv->irq_tx = res_irq_tx->start;
+	dev->irq = priv->irq = irq;
+	priv->irq_rx = irq_rx;
+	priv->irq_tx = irq_tx;
 
 	priv->mac_clk = devm_clk_get(&pdev->dev, "enet");
 	if (IS_ERR(priv->mac_clk)) {
-- 
2.20.1



