Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3634C28B2B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Aug 2022 16:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351564AbiHSQIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Aug 2022 12:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351485AbiHSQFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 12:05:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C8265676;
        Fri, 19 Aug 2022 08:55:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9815B614FE;
        Fri, 19 Aug 2022 15:55:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E558C433B5;
        Fri, 19 Aug 2022 15:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660924521;
        bh=vKJTcW23K/iqbaor4OEJk32OFtCXmBnYMC+sI432nH4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VksJdb2N3aMcnLaTziNXmuH3zjHbnsdYxr/oNL6ZQpSFCUb3S/4Hhylk3wTfc+ZYc
         3qZz1sg4a3LSiX4SJpoNjf97NdM6pgBJXKh6H+HDsaEyCykFMFvL9XMQsr0gVLOkBI
         sqNUYLgjPSVS+TcNBWL370M7JfRa3wwWUSWR3g/o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 198/545] drm/vc4: dsi: Add correct stop condition to vc4_dsi_encoder_disable iteration
Date:   Fri, 19 Aug 2022 17:39:28 +0200
Message-Id: <20220819153838.236211973@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220819153829.135562864@linuxfoundation.org>
References: <20220819153829.135562864@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

[ Upstream commit 7bcb9c8d0bc9f3cab8ac2634b056c2e6b63945ca ]

vc4_dsi_encoder_disable is partially an open coded version of
drm_bridge_chain_disable, but it missed a termination condition
in the loop for ->disable which meant that no post_disable
calls were made.

Add in the termination clause.

Fixes: 033bfe7538a1 ("drm/vc4: dsi: Fix bridge chain handling")
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Link: https://lore.kernel.org/r/20220613144800.326124-17-maxime@cerno.tech
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vc4/vc4_dsi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
index 43e86f0b5541..0bda40c2d787 100644
--- a/drivers/gpu/drm/vc4/vc4_dsi.c
+++ b/drivers/gpu/drm/vc4/vc4_dsi.c
@@ -803,6 +803,9 @@ static void vc4_dsi_encoder_disable(struct drm_encoder *encoder)
 	list_for_each_entry_reverse(iter, &dsi->bridge_chain, chain_node) {
 		if (iter->funcs->disable)
 			iter->funcs->disable(iter);
+
+		if (iter == dsi->bridge)
+			break;
 	}
 
 	vc4_dsi_ulps(dsi, true);
-- 
2.35.1



