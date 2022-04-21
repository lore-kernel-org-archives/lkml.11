Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D32C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Apr 2022 02:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383820AbiDUCvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Apr 2022 22:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiDUCvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 22:51:02 -0400
Received: from mail.meizu.com (edge07.meizu.com [112.91.151.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B06BE3D;
        Wed, 20 Apr 2022 19:48:13 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail11.meizu.com
 (172.16.1.15) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 21 Apr
 2022 10:48:06 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Thu, 21 Apr
 2022 10:48:05 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
CC:     Haowen Bai <baihaowen@meizu.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] tsnep: Remove useless null check before call of_node_put()
Date:   Thu, 21 Apr 2022 10:48:03 +0800
Message-ID: <1650509283-26168-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to add null check before call of_node_put(), since the
implementation of of_node_put() has done it.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 drivers/net/ethernet/engleder/tsnep_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/engleder/tsnep_main.c b/drivers/net/ethernet/engleder/tsnep_main.c
index 904f3304727e..49c93aa38862 100644
--- a/drivers/net/ethernet/engleder/tsnep_main.c
+++ b/drivers/net/ethernet/engleder/tsnep_main.c
@@ -1091,8 +1091,7 @@ static int tsnep_mdio_init(struct tsnep_adapter *adapter)
 	retval = of_mdiobus_register(adapter->mdiobus, np);
 
 out:
-	if (np)
-		of_node_put(np);
+	of_node_put(np);
 
 	return retval;
 }
-- 
2.7.4

