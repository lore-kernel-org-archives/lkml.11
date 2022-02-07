Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E91EC433FE
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Feb 2022 12:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389675AbiBGLuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Feb 2022 06:50:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384862AbiBGLaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 06:30:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF46C03CA4A;
        Mon,  7 Feb 2022 03:28:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08BD66077B;
        Mon,  7 Feb 2022 11:28:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFBAFC340F1;
        Mon,  7 Feb 2022 11:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644233321;
        bh=D1iJwyfsHLPr5Rqzs8UxZzRupRZ+cg/8d6hqnSL8FKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n/buLgWiw/FS/tztTRImwJpwLkPd6pp65n2AJGtT1ZmHl1vKjrS1fCOVL4mDVPTyC
         dYlUUl6syHS63Tl6RBbiwxAmDzmcgzuCdYzSX8sEXtty42qpTcF5AvisArZp7pRibg
         NMXv10V1npBZrwqAo9XEPRpM7ktav+0iG342GcdM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 5.15 054/110] IB/hfi1: Fix tstats alloc and dealloc
Date:   Mon,  7 Feb 2022 12:06:27 +0100
Message-Id: <20220207103804.114482943@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220207103802.280120990@linuxfoundation.org>
References: <20220207103802.280120990@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>

commit e5cce44aff3be9ad2cd52f63f35edbd706181d50 upstream.

The tstats allocation is done in the accelerated ndo_init function but the
allocation is not tested to succeed.

The deallocation is not done in the accelerated ndo_uninit function.

Resolve issues by testing for an allocation failure and adding the
free_percpu in the uninit function.

Fixes: aa0616a9bd52 ("IB/hfi1: switch to core handling of rx/tx byte/packet counters")
Link: https://lore.kernel.org/r/1642287756-182313-5-git-send-email-mike.marciniszyn@cornelisnetworks.com
Reviewed-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/hfi1/ipoib_main.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- a/drivers/infiniband/hw/hfi1/ipoib_main.c
+++ b/drivers/infiniband/hw/hfi1/ipoib_main.c
@@ -22,26 +22,35 @@ static int hfi1_ipoib_dev_init(struct ne
 	int ret;
 
 	dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
+	if (!dev->tstats)
+		return -ENOMEM;
 
 	ret = priv->netdev_ops->ndo_init(dev);
 	if (ret)
-		return ret;
+		goto out_ret;
 
 	ret = hfi1_netdev_add_data(priv->dd,
 				   qpn_from_mac(priv->netdev->dev_addr),
 				   dev);
 	if (ret < 0) {
 		priv->netdev_ops->ndo_uninit(dev);
-		return ret;
+		goto out_ret;
 	}
 
 	return 0;
+out_ret:
+	free_percpu(dev->tstats);
+	dev->tstats = NULL;
+	return ret;
 }
 
 static void hfi1_ipoib_dev_uninit(struct net_device *dev)
 {
 	struct hfi1_ipoib_dev_priv *priv = hfi1_ipoib_priv(dev);
 
+	free_percpu(dev->tstats);
+	dev->tstats = NULL;
+
 	hfi1_netdev_remove_data(priv->dd, qpn_from_mac(priv->netdev->dev_addr));
 
 	priv->netdev_ops->ndo_uninit(dev);
@@ -166,6 +175,7 @@ static void hfi1_ipoib_netdev_dtor(struc
 	hfi1_ipoib_rxq_deinit(priv->netdev);
 
 	free_percpu(dev->tstats);
+	dev->tstats = NULL;
 }
 
 static void hfi1_ipoib_set_id(struct net_device *dev, int id)


