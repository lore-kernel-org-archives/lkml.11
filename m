Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B67DC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 09:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350903AbiBUJgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 04:36:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348779AbiBUJ1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 04:27:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70312636C;
        Mon, 21 Feb 2022 01:11:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05E5C60B1E;
        Mon, 21 Feb 2022 09:11:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D86C7C340E9;
        Mon, 21 Feb 2022 09:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645434718;
        bh=fGDP0OZh7M9YwAIVBFrQdQ/1bd+Aa+ktRPvGVdtaMZw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oS3mCAcuIWMYxzP5K0MTFCm9/8B3lfsO1Q+iRT9cMzZXXLZ9CyZg/IMKzOmoBY6J5
         Aj0iBJRGxc57633Bb0UrsSWDB/NYS3gHJCePS9IXAE0PjTVJbatZlwTpoT11jVNdKe
         YhNA+RWc0MjC2mpDc5vJcFxN38GCxSAGyWQYXJPU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Radu Bulie <radu-andrei.bulie@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.15 106/196] dpaa2-eth: Initialize mutex used in one step timestamping path
Date:   Mon, 21 Feb 2022 09:48:58 +0100
Message-Id: <20220221084934.480983015@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221084930.872957717@linuxfoundation.org>
References: <20220221084930.872957717@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Radu Bulie <radu-andrei.bulie@nxp.com>

commit 07dd44852be89386ab12210df90a2d78779f3bff upstream.

1588 Single Step Timestamping code path uses a mutex to
enforce atomicity for two events:
- update of ptp single step register
- transmit ptp event packet

Before this patch the mutex was not initialized. This
caused unexpected crashes in the Tx function.

Fixes: c55211892f463 ("dpaa2-eth: support PTP Sync packet one-step timestamping")
Signed-off-by: Radu Bulie <radu-andrei.bulie@nxp.com>
Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -4329,7 +4329,7 @@ static int dpaa2_eth_probe(struct fsl_mc
 	}
 
 	INIT_WORK(&priv->tx_onestep_tstamp, dpaa2_eth_tx_onestep_tstamp);
-
+	mutex_init(&priv->onestep_tstamp_lock);
 	skb_queue_head_init(&priv->tx_skbs);
 
 	priv->rx_copybreak = DPAA2_ETH_DEFAULT_COPYBREAK;


