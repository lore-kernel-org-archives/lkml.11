Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BC8C282E7
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Aug 2022 21:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242670AbiHOVFI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Aug 2022 17:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347622AbiHOVCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 17:02:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A01CB5EC;
        Mon, 15 Aug 2022 12:14:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 514FC60F27;
        Mon, 15 Aug 2022 19:14:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35445C433B5;
        Mon, 15 Aug 2022 19:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660590845;
        bh=KcEV8SKvsjL468XkPQvCHNAT9nTCGEg25sQJaScv6vE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FJMIE1uHqRV733J8vdWkcMPQ9bmi44MUW1pihXuGQhKi0zczI1Xp4PEIt2BfqFO+7
         EJHhUWJrDtsX5SVo6ZDJfAH0rgcmvtqLUoFRXuaU85n+9PD6QSAQ7DY3MtFXCzRm9j
         PjLBTH4d9DPogI/bqynnlaCi2VT0xOGbe6MFhLtU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.18 0389/1095] drm/vc4: dsi: Register dsi0 as the correct vc4 encoder type
Date:   Mon, 15 Aug 2022 19:56:28 +0200
Message-Id: <20220815180445.778843063@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220815180429.240518113@linuxfoundation.org>
References: <20220815180429.240518113@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

[ Upstream commit 4d9273c978d4c1af15d7874c10c732ec83d444d0 ]

vc4_dsi was registering both dsi0 and dsi1 as VC4_ENCODER_TYPE_DSI1
which seemed to work OK for a single DSI display, but fails
if there are two DSI displays connected.

Update to register the correct type.

Fixes: 4078f5757144 ("drm/vc4: Add DSI driver")
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Link: https://lore.kernel.org/r/20220613144800.326124-15-maxime@cerno.tech
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vc4/vc4_dsi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
index 81a6c4e9576d..97a258c934af 100644
--- a/drivers/gpu/drm/vc4/vc4_dsi.c
+++ b/drivers/gpu/drm/vc4/vc4_dsi.c
@@ -1518,7 +1518,8 @@ static int vc4_dsi_bind(struct device *dev, struct device *master, void *data)
 		return -ENOMEM;
 
 	INIT_LIST_HEAD(&dsi->bridge_chain);
-	vc4_dsi_encoder->base.type = VC4_ENCODER_TYPE_DSI1;
+	vc4_dsi_encoder->base.type = dsi->variant->port ?
+			VC4_ENCODER_TYPE_DSI1 : VC4_ENCODER_TYPE_DSI0;
 	vc4_dsi_encoder->dsi = dsi;
 	dsi->encoder = &vc4_dsi_encoder->base.base;
 
-- 
2.35.1



