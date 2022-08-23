Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847E2C32774
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 11:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358901AbiHWLz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 07:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359246AbiHWLwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 07:52:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C41BD51D4;
        Tue, 23 Aug 2022 02:32:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5AFE612D6;
        Tue, 23 Aug 2022 09:32:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A940CC4314C;
        Tue, 23 Aug 2022 09:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661247152;
        bh=N6Hrsh66fIpJqgREzVXpH3vUpho0BglNX6qFgtggWPg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ku3aHorX/Yjwfwlk+4DR79/3Za8ZgtrWuA2vhJYJuuU31CQwP4OJ+CQEu3PwHGDG9
         tpdjngrPJ/ZUZcscnQnzZTVk1h34uuNar+FjfEYt8v5s71LoVY/BA7eS1xSVkpkWAv
         Z48DolEI8cFg/amydj0qUUTbOwiB415n8n/GWNjI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chen Lin <chen.lin5@zte.com.cn>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.4 327/389] dpaa2-eth: trace the allocated address instead of page struct
Date:   Tue, 23 Aug 2022 10:26:45 +0200
Message-Id: <20220823080129.174178043@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220823080115.331990024@linuxfoundation.org>
References: <20220823080115.331990024@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Lin <chen45464546@163.com>

commit e34f49348f8b7a53205b6f77707a3a6a40cf420b upstream.

We should trace the allocated address instead of page struct.

Fixes: 27c874867c4e ("dpaa2-eth: Use a single page per Rx buffer")
Signed-off-by: Chen Lin <chen.lin5@zte.com.cn>
Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Link: https://lore.kernel.org/r/20220811151651.3327-1-chen45464546@163.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -971,8 +971,8 @@ static int add_bufs(struct dpaa2_eth_pri
 		buf_array[i] = addr;
 
 		/* tracing point */
-		trace_dpaa2_eth_buf_seed(priv->net_dev,
-					 page, DPAA2_ETH_RX_BUF_RAW_SIZE,
+		trace_dpaa2_eth_buf_seed(priv->net_dev, page_address(page),
+					 DPAA2_ETH_RX_BUF_RAW_SIZE,
 					 addr, priv->rx_buf_size,
 					 bpid);
 	}


