Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2124C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jun 2022 00:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236999AbiFTAKn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jun 2022 20:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236615AbiFTAKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 20:10:42 -0400
Received: from EX-PRD-EDGE01.vmware.com (EX-PRD-EDGE01.vmware.com [208.91.3.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6416BDC0;
        Sun, 19 Jun 2022 17:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
    s=s1024; d=vmware.com;
    h=from:to:cc:subject:date:message-id:mime-version:content-type;
    bh=WgE4jC6uoXiOarh99EjXMspYkBqjSPnVZsFaU6AfPZ0=;
    b=ThEKLKt+hqXlbanLxgseYsNMMrQ1uexq/ZguFk+BCcjuSlJGxEbr4meKZnBsyi
      gyUgQ1DyzYKappHBzy346Alf8W4p5W/czXa9HjLLgNL5HAvtWRwYRTw9kuV0pT
      i5hMnhEiNYgtwfDum2P+heVP4oRgiXZAM9D+2LrL7z3l//4=
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX-PRD-EDGE01.vmware.com (10.188.245.6) with Microsoft SMTP Server id
 15.1.2308.20; Sun, 19 Jun 2022 17:10:13 -0700
Received: from htb-1n-eng-dhcp122.eng.vmware.com (unknown [10.20.114.216])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 8F2D32023C;
        Sun, 19 Jun 2022 17:10:35 -0700 (PDT)
Received: by htb-1n-eng-dhcp122.eng.vmware.com (Postfix, from userid 0)
        id 5474EAA489; Sun, 19 Jun 2022 17:10:35 -0700 (PDT)
From:   Ronak Doshi <doshir@vmware.com>
To:     <netdev@vger.kernel.org>
CC:     Ronak Doshi <doshir@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Guolin Yang <gyang@vmware.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] vmxnet3: disable overlay offloads if UPT device does not support
Date:   Sun, 19 Jun 2022 17:10:13 -0700
Message-ID: <20220620001014.27048-1-doshir@vmware.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX-PRD-EDGE01.vmware.com: doshir@vmware.com does not
 designate permitted sender hosts)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'Commit 6f91f4ba046e ("vmxnet3: add support for capability registers")'
added support for capability registers. These registers are used
to advertize capabilities of the device.

The patch updated the dev_caps to disable outer checksum offload if
PTCR register does not support it. However, it missed to update
other overlay offloads. This patch fixes this issue.

Fixes: 6f91f4ba046e ("vmxnet3: add support for capability registers")
Signed-off-by: Ronak Doshi <doshir@vmware.com>
---
 drivers/net/vmxnet3/vmxnet3_drv.c     | 9 ++++++++-
 drivers/net/vmxnet3/vmxnet3_ethtool.c | 6 ++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index 1565e1808a19..19c414733747 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -3365,10 +3365,17 @@ vmxnet3_declare_features(struct vmxnet3_adapter *adapter)
 		adapter->dev_caps[0] = VMXNET3_READ_BAR1_REG(adapter, VMXNET3_REG_CMD);
 		spin_unlock_irqrestore(&adapter->cmd_lock, flags);
 
+		if (!(adapter->dev_caps[0] & (1UL << VMXNET3_CAP_GENEVE_CHECKSUM_OFFLOAD)) &&
+		    !(adapter->dev_caps[0] & (1UL << VMXNET3_CAP_VXLAN_CHECKSUM_OFFLOAD)) &&
+		    !(adapter->dev_caps[0] & (1UL << VMXNET3_CAP_GENEVE_TSO)) &&
+		    !(adapter->dev_caps[0] & (1UL << VMXNET3_CAP_VXLAN_TSO))) {
+			netdev->hw_enc_features &= ~NETIF_F_GSO_UDP_TUNNEL;
+			netdev->hw_features &= ~NETIF_F_GSO_UDP_TUNNEL;
+		}
 		if (!(adapter->dev_caps[0] & (1UL << VMXNET3_CAP_GENEVE_OUTER_CHECKSUM_OFFLOAD)) &&
 		    !(adapter->dev_caps[0] & (1UL << VMXNET3_CAP_VXLAN_OUTER_CHECKSUM_OFFLOAD))) {
 			netdev->hw_enc_features &= ~NETIF_F_GSO_UDP_TUNNEL_CSUM;
-			netdev->features &= ~NETIF_F_GSO_UDP_TUNNEL_CSUM;
+			netdev->hw_features &= ~NETIF_F_GSO_UDP_TUNNEL_CSUM;
 		}
 	}
 
diff --git a/drivers/net/vmxnet3/vmxnet3_ethtool.c b/drivers/net/vmxnet3/vmxnet3_ethtool.c
index ce3993282c0f..c3eaf1b864ed 100644
--- a/drivers/net/vmxnet3/vmxnet3_ethtool.c
+++ b/drivers/net/vmxnet3/vmxnet3_ethtool.c
@@ -346,6 +346,12 @@ static void vmxnet3_enable_encap_offloads(struct net_device *netdev, netdev_feat
 		adapter->dev_caps[0] = VMXNET3_READ_BAR1_REG(adapter, VMXNET3_REG_CMD);
 		spin_unlock_irqrestore(&adapter->cmd_lock, flags);
 
+		if (!(adapter->dev_caps[0] & (1UL << VMXNET3_CAP_GENEVE_CHECKSUM_OFFLOAD)) &&
+		    !(adapter->dev_caps[0] & (1UL << VMXNET3_CAP_VXLAN_CHECKSUM_OFFLOAD)) &&
+		    !(adapter->dev_caps[0] & (1UL << VMXNET3_CAP_GENEVE_TSO)) &&
+		    !(adapter->dev_caps[0] & (1UL << VMXNET3_CAP_VXLAN_TSO))) {
+			netdev->hw_enc_features &= ~NETIF_F_GSO_UDP_TUNNEL;
+		}
 		if (!(adapter->dev_caps[0] & (1UL << VMXNET3_CAP_GENEVE_OUTER_CHECKSUM_OFFLOAD)) &&
 		    !(adapter->dev_caps[0] & (1UL << VMXNET3_CAP_VXLAN_OUTER_CHECKSUM_OFFLOAD))) {
 			netdev->hw_enc_features &= ~NETIF_F_GSO_UDP_TUNNEL_CSUM;
-- 
2.11.0

