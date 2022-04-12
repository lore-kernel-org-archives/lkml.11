Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DF7C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 01:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbiDLBCQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Apr 2022 21:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242524AbiDLA4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 20:56:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF9B22B0A;
        Mon, 11 Apr 2022 17:49:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96B7C6182C;
        Tue, 12 Apr 2022 00:49:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B4EC385A3;
        Tue, 12 Apr 2022 00:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649724569;
        bh=jshQ9IUIL68LcKjRHPNrDeAoy3xDXn8H3rxW8TYGyuU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EBFT8WTaa2D52Cs2LgfKTNETwsqCRezPu9I11nCRyeP3gtDZUzzasavHB4MjKc5t6
         Y2t6LYFgEP7l3N5EeAP2Sh1aIGmml7g6eUoVJ9G/BhjNQxws/YI9Iffh3IEsgyiMnj
         iG4joJyicP7E0D5sAer92SM5zrdKzgJdVLoZ/4r2tCgUp9wSiSHSaGDYezB1KhEF9n
         6075rwKwSaDAeXB34oUeDP8RfmaAwLrV1ygew/HnMfJcn+xway55rpBMJ8FfBi788s
         u/mQrrvmOC0Y1SCgI5D9Gg1heKIqYItx+hoYpKH7qmiQhpm+gdQGCOPhAxB7Zs/PH0
         PKVJIVftPncrg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Leo (Hanghong) Ma" <hanghong.ma@amd.com>,
        Chris Park <Chris.Park@amd.com>, Alex Hung <alex.hung@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, harry.wentland@amd.com,
        sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, Reza.Amini@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.10 06/30] drm/amd/display: Update VTEM Infopacket definition
Date:   Mon, 11 Apr 2022 20:48:40 -0400
Message-Id: <20220412004906.350678-6-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412004906.350678-1-sashal@kernel.org>
References: <20220412004906.350678-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Leo (Hanghong) Ma" <hanghong.ma@amd.com>

[ Upstream commit c9fbf6435162ed5fb7201d1d4adf6585c6a8c327 ]

[Why & How]
The latest HDMI SPEC has updated the VTEM packet structure,
so change the VTEM Infopacket defined in the driver side to align
with the SPEC.

Reviewed-by: Chris Park <Chris.Park@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Leo (Hanghong) Ma <hanghong.ma@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/display/modules/info_packet/info_packet.c    | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
index 0fdf7a3e96de..96e18050a617 100644
--- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
+++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
@@ -100,7 +100,8 @@ enum vsc_packet_revision {
 //PB7 = MD0
 #define MASK_VTEM_MD0__VRR_EN         0x01
 #define MASK_VTEM_MD0__M_CONST        0x02
-#define MASK_VTEM_MD0__RESERVED2      0x0C
+#define MASK_VTEM_MD0__QMS_EN         0x04
+#define MASK_VTEM_MD0__RESERVED2      0x08
 #define MASK_VTEM_MD0__FVA_FACTOR_M1  0xF0
 
 //MD1
@@ -109,7 +110,7 @@ enum vsc_packet_revision {
 //MD2
 #define MASK_VTEM_MD2__BASE_REFRESH_RATE_98  0x03
 #define MASK_VTEM_MD2__RB                    0x04
-#define MASK_VTEM_MD2__RESERVED3             0xF8
+#define MASK_VTEM_MD2__NEXT_TFR              0xF8
 
 //MD3
 #define MASK_VTEM_MD3__BASE_REFRESH_RATE_07  0xFF
-- 
2.35.1

