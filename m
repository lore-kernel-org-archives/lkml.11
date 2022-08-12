Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCEDC25B06
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Aug 2022 03:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236816AbiHLDLR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Aug 2022 23:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbiHLDLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 23:11:11 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12AB199245;
        Thu, 11 Aug 2022 20:11:09 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 3A4231E80D77;
        Fri, 12 Aug 2022 11:09:00 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jdzEI2JOMAJ2; Fri, 12 Aug 2022 11:08:57 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: liqiong@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id B80A41E80D0F;
        Fri, 12 Aug 2022 11:08:56 +0800 (CST)
From:   Li Qiong <liqiong@nfschina.com>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        yuzhe@nfschina.com, renyu@nfschina.com, jiaming@nfschina.com,
        kernel-janitors@vger.kernel.org, Li Qiong <liqiong@nfschina.com>
Subject: [PATCH] net: lan966x: fix checking for return value of platform_get_irq_byname()
Date:   Fri, 12 Aug 2022 11:09:54 +0800
Message-Id: <20220812030954.24050-1-liqiong@nfschina.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The platform_get_irq_byname() returns non-zero IRQ number
or negative error number. "if (irq)" always true, chang it
to "if (irq > 0)"

Signed-off-by: Li Qiong <liqiong@nfschina.com>
---
 drivers/net/ethernet/microchip/lan966x/lan966x_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
index 1d6e3b641b2e..d928b75f3780 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
@@ -710,7 +710,7 @@ static void lan966x_cleanup_ports(struct lan966x *lan966x)
 	disable_irq(lan966x->xtr_irq);
 	lan966x->xtr_irq = -ENXIO;
 
-	if (lan966x->ana_irq) {
+	if (lan966x->ana_irq > 0) {
 		disable_irq(lan966x->ana_irq);
 		lan966x->ana_irq = -ENXIO;
 	}
@@ -718,10 +718,10 @@ static void lan966x_cleanup_ports(struct lan966x *lan966x)
 	if (lan966x->fdma)
 		devm_free_irq(lan966x->dev, lan966x->fdma_irq, lan966x);
 
-	if (lan966x->ptp_irq)
+	if (lan966x->ptp_irq > 0)
 		devm_free_irq(lan966x->dev, lan966x->ptp_irq, lan966x);
 
-	if (lan966x->ptp_ext_irq)
+	if (lan966x->ptp_ext_irq > 0)
 		devm_free_irq(lan966x->dev, lan966x->ptp_ext_irq, lan966x);
 }
 
@@ -1049,7 +1049,7 @@ static int lan966x_probe(struct platform_device *pdev)
 	}
 
 	lan966x->ana_irq = platform_get_irq_byname(pdev, "ana");
-	if (lan966x->ana_irq) {
+	if (lan966x->ana_irq > 0) {
 		err = devm_request_threaded_irq(&pdev->dev, lan966x->ana_irq, NULL,
 						lan966x_ana_irq_handler, IRQF_ONESHOT,
 						"ana irq", lan966x);
-- 
2.11.0

