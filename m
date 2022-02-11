Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C513FC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Feb 2022 06:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346437AbiBKGw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Feb 2022 01:52:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240722AbiBKGw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 01:52:26 -0500
Received: from plekste.mt.lv (bute.mt.lv [IPv6:2a02:610:7501:2000::195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A19265A;
        Thu, 10 Feb 2022 22:52:26 -0800 (PST)
Received: from [2a02:610:7501:feff:1ccf:41ff:fe50:18b9] (helo=localhost.localdomain)
        by plekste.mt.lv with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <gatis@mikrotik.com>)
        id 1nIPmx-00043i-K7; Fri, 11 Feb 2022 08:52:15 +0200
From:   Gatis Peisenieks <gatis@mikrotik.com>
To:     chris.snook@gmail.com, davem@davemloft.net, kuba@kernel.org,
        hkallweit1@gmail.com, jesse.brandeburg@intel.com,
        dchickles@marvell.com, tully@mikrotik.com, antons@mikrotik.com,
        eric.dumazet@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gatis Peisenieks <gatis@mikrotik.com>
Subject: [PATCH net] atl1c: fix tx timeout after link flap on Mikrotik 10/25G NIC
Date:   Fri, 11 Feb 2022 08:51:23 +0200
Message-Id: <20220211065123.4187615-1-gatis@mikrotik.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If NIC had packets in tx queue at the moment link down event
happened, it could result in tx timeout when link got back up.

Since device has more than one tx queue we need to reset them
accordingly.

Fixes: 057f4af2b171 ("atl1c: add 4 RX/TX queue support for Mikrotik 10/25G NIC")
Signed-off-by: Gatis Peisenieks <gatis@mikrotik.com>
---
 drivers/net/ethernet/atheros/atl1c/atl1c_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
index da595242bc13..f50604f3e541 100644
--- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
+++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
@@ -900,7 +900,7 @@ static void atl1c_clean_tx_ring(struct atl1c_adapter *adapter,
 		atl1c_clean_buffer(pdev, buffer_info);
 	}
 
-	netdev_reset_queue(adapter->netdev);
+	netdev_tx_reset_queue(netdev_get_tx_queue(adapter->netdev, queue));
 
 	/* Zero out Tx-buffers */
 	memset(tpd_ring->desc, 0, sizeof(struct atl1c_tpd_desc) *
-- 
2.31.1

