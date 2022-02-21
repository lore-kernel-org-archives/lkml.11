Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62801C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 10:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353590AbiBUKLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 05:11:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353226AbiBUJ5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 04:57:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2610846646;
        Mon, 21 Feb 2022 01:25:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE97D60FE0;
        Mon, 21 Feb 2022 09:25:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BCBAC340E9;
        Mon, 21 Feb 2022 09:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645435506;
        bh=R4TuLef2DSgjZ3rFzWIyayhSS9Db1ZXijWzAtPi6lX0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i3tyon1FaPaiL5/OiqcIaPOa6tHcBM5RhnJuAOBiAtYQR2CkMXv4AzOo8UpfxWQK5
         qn74usyIAK7Ihj7eI9e7HS+Q2xJFfM+XFuUhz2jRayyVRkmr1rO9ete78e7l6OVxsa
         RHSedNW9GguXky+yLYcCBcrGxpy9KYPc+BArJHRY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 5.16 180/227] dmaengine: stm32-dmamux: Fix PM disable depth imbalance in stm32_dmamux_probe
Date:   Mon, 21 Feb 2022 09:49:59 +0100
Message-Id: <20220221084940.797979682@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221084934.836145070@linuxfoundation.org>
References: <20220221084934.836145070@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miaoqian Lin <linmq006@gmail.com>

commit e831c7aba950f3ae94002b10321279654525e5ec upstream.

The pm_runtime_enable will increase power disable depth.
If the probe fails, we should use pm_runtime_disable() to balance
pm_runtime_enable().

Fixes: 4f3ceca254e0 ("dmaengine: stm32-dmamux: Add PM Runtime support")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Reviewed-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
Link: https://lore.kernel.org/r/20220108085336.11992-1-linmq006@gmail.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/stm32-dmamux.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/dma/stm32-dmamux.c
+++ b/drivers/dma/stm32-dmamux.c
@@ -292,10 +292,12 @@ static int stm32_dmamux_probe(struct pla
 	ret = of_dma_router_register(node, stm32_dmamux_route_allocate,
 				     &stm32_dmamux->dmarouter);
 	if (ret)
-		goto err_clk;
+		goto pm_disable;
 
 	return 0;
 
+pm_disable:
+	pm_runtime_disable(&pdev->dev);
 err_clk:
 	clk_disable_unprepare(stm32_dmamux->clk);
 


