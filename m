Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571ECC433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 20:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382875AbiDEU3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 16:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358058AbiDEK15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 06:27:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80453419B4;
        Tue,  5 Apr 2022 03:14:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CEF061562;
        Tue,  5 Apr 2022 10:14:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB56C385A2;
        Tue,  5 Apr 2022 10:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649153640;
        bh=8bNbB20EGvk03pCQkZIGQo84TjZILSkZjlFdPIaHDLo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rS4W51k7rJ51T1A6ltRXZiAqAY1xKkYiufgiSziRAxbWFUYk7Q45Tpfcjbs0BXpUJ
         Ctc675d4+8akPLrnOrYBkGM1q5/S8fxq2R2nEDtuZBwasiH+4TKCWlBeJP97pr7NcP
         SiENo4Mz/KxK9CKfgBi35R31kckVftT3NllRr8UA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 295/599] drm/bridge: dw-hdmi: use safe format when first in bridge chain
Date:   Tue,  5 Apr 2022 09:29:49 +0200
Message-Id: <20220405070307.612149627@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070258.802373272@linuxfoundation.org>
References: <20220405070258.802373272@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neil Armstrong <narmstrong@baylibre.com>

[ Upstream commit 1528038385c0a706aac9ac165eeb24044fef6825 ]

When the dw-hdmi bridge is in first place of the bridge chain, this
means there is no way to select an input format of the dw-hdmi HW
component.

Since introduction of display-connector, negotiation was broken since
the dw-hdmi negotiation code only worked when the dw-hdmi bridge was
in last position of the bridge chain or behind another bridge also
supporting input & output format negotiation.

Commit 7cd70656d128 ("drm/bridge: display-connector: implement bus fmts callbacks")
was introduced to make negotiation work again by making display-connector
act as a pass-through concerning input & output format negotiation.

But in the case where the dw-hdmi is single in the bridge chain, for
example on Renesas SoCs, with the display-connector bridge the dw-hdmi
is no more single, breaking output format.

Reported-by: Biju Das <biju.das.jz@bp.renesas.com>
Bisected-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Tested-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Fixes: 6c3c719936da ("drm/bridge: synopsys: dw-hdmi: add bus format negociation")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
[narmstrong: add proper fixes commit]
Reviewed-by: Robert Foss <robert.foss@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20220204143337.89221-1-narmstrong@baylibre.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 29c0eb4bd754..b10228b9e3a9 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2566,8 +2566,9 @@ static u32 *dw_hdmi_bridge_atomic_get_output_bus_fmts(struct drm_bridge *bridge,
 	if (!output_fmts)
 		return NULL;
 
-	/* If dw-hdmi is the only bridge, avoid negociating with ourselves */
-	if (list_is_singular(&bridge->encoder->bridge_chain)) {
+	/* If dw-hdmi is the first or only bridge, avoid negociating with ourselves */
+	if (list_is_singular(&bridge->encoder->bridge_chain) ||
+	    list_is_first(&bridge->chain_node, &bridge->encoder->bridge_chain)) {
 		*num_output_fmts = 1;
 		output_fmts[0] = MEDIA_BUS_FMT_FIXED;
 
-- 
2.34.1



