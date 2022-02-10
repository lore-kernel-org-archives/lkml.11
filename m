Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA36C433FE
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Feb 2022 22:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345003AbiBJWe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Feb 2022 17:34:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238570AbiBJWe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 17:34:56 -0500
Received: from smtp.smtpout.orange.fr (smtp03.smtpout.orange.fr [80.12.242.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C0110AA
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 14:34:56 -0800 (PST)
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id II1dnjIzz9r2MII1enUsYH; Thu, 10 Feb 2022 23:34:55 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 10 Feb 2022 23:34:55 +0100
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Simon Horman <simon.horman@corigine.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        John Hurley <john.hurley@netronome.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        oss-drivers@corigine.com, netdev@vger.kernel.org
Subject: [PATCH v2 1/2] nfp: flower: Fix a potential leak in nfp_tunnel_add_shared_mac()
Date:   Thu, 10 Feb 2022 23:34:52 +0100
Message-Id: <4acb805751f2cf5de8d69e9602a88ec39feff9fc.1644532467.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ida_simple_get() returns an id between min (0) and max (NFP_MAX_MAC_INDEX)
inclusive.
So NFP_MAX_MAC_INDEX (0xff) is a valid id.

In order for the error handling path to work correctly, the 'invalid'
value for 'ida_idx' should not be in the 0..NFP_MAX_MAC_INDEX range,
inclusive.

So set it to -1.

Fixes: 20cce8865098 ("nfp: flower: enable MAC address sharing for offloadable devs")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c b/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
index cd50db779dda..9244b35e3855 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
@@ -922,8 +922,8 @@ nfp_tunnel_add_shared_mac(struct nfp_app *app, struct net_device *netdev,
 			  int port, bool mod)
 {
 	struct nfp_flower_priv *priv = app->priv;
-	int ida_idx = NFP_MAX_MAC_INDEX, err;
 	struct nfp_tun_offloaded_mac *entry;
+	int ida_idx = -1, err;
 	u16 nfp_mac_idx = 0;
 
 	entry = nfp_tunnel_lookup_offloaded_macs(app, netdev->dev_addr);
@@ -997,7 +997,7 @@ nfp_tunnel_add_shared_mac(struct nfp_app *app, struct net_device *netdev,
 err_free_entry:
 	kfree(entry);
 err_free_ida:
-	if (ida_idx != NFP_MAX_MAC_INDEX)
+	if (ida_idx != -1)
 		ida_simple_remove(&priv->tun.mac_off_ids, ida_idx);
 
 	return err;
-- 
2.32.0

