Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A437C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 09:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347912AbiDEJ2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 05:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239559AbiDEIUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:20:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA71C636C;
        Tue,  5 Apr 2022 01:16:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67CDA60B0F;
        Tue,  5 Apr 2022 08:16:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73072C385A0;
        Tue,  5 Apr 2022 08:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649146588;
        bh=wnO/W1VKyil+x2hzjyqb7HU+6IrSK8quU5k/yT2LCuw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wvaKmJf2zAdbVu3uA/1rIrK+fOFrj8Q2rA64J7IY7lBF24nXT1gUPR6/YFPQJyRqn
         51juS3ivYDWDlblKJvX/EapvRdBpYdsLGXytPDvOGiJKvynZSgWGL+tGrnOZMuZuDK
         IiDD3xRRAYOX/8jGin7vbqdcHTTQbYTWublCre08=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hao Chen <chenhao288@hisilicon.com>,
        Guangbin Huang <huangguangbin2@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.17 0818/1126] net: hns3: add netdev reset check for hns3_set_tunable()
Date:   Tue,  5 Apr 2022 09:26:05 +0200
Message-Id: <20220405070431.574524114@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070407.513532867@linuxfoundation.org>
References: <20220405070407.513532867@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hao Chen <chenhao288@hisilicon.com>

[ Upstream commit f5cd60169f981ca737c9e49c446506dfafc90a35 ]

When pci device reset failed, it does uninit operation and priv->ring
is NULL, it causes accessing NULL pointer error.

Add netdev reset check for hns3_set_tunable() to fix it.

Fixes: 99f6b5fb5f63 ("net: hns3: use bounce buffer when rx page can not be reused")
Signed-off-by: Hao Chen <chenhao288@hisilicon.com>
Signed-off-by: Guangbin Huang <huangguangbin2@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index 7591772c9a6b..1f6d6faeec24 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -1764,9 +1764,6 @@ static int hns3_set_tx_spare_buf_size(struct net_device *netdev,
 	struct hnae3_handle *h = priv->ae_handle;
 	int ret;
 
-	if (hns3_nic_resetting(netdev))
-		return -EBUSY;
-
 	h->kinfo.tx_spare_buf_size = data;
 
 	ret = hns3_reset_notify(h, HNAE3_DOWN_CLIENT);
@@ -1797,6 +1794,11 @@ static int hns3_set_tunable(struct net_device *netdev,
 	struct hnae3_handle *h = priv->ae_handle;
 	int i, ret = 0;
 
+	if (hns3_nic_resetting(netdev) || !priv->ring) {
+		netdev_err(netdev, "failed to set tunable value, dev resetting!");
+		return -EBUSY;
+	}
+
 	switch (tuna->id) {
 	case ETHTOOL_TX_COPYBREAK:
 		priv->tx_copybreak = *(u32 *)data;
-- 
2.34.1



