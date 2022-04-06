Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00663C433FE
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 12:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbiDFMjp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Apr 2022 08:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbiDFMi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:38:29 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459D7576837
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 01:40:23 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4B3F11A13A5;
        Wed,  6 Apr 2022 10:40:15 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 00A8E1A129E;
        Wed,  6 Apr 2022 10:40:15 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id CE566183AC4F;
        Wed,  6 Apr 2022 16:40:12 +0800 (+08)
From:   Sandor.yu@nxp.com
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        andrzej.hajda@intel.com, narmstrong@baylibre.com,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com
Cc:     Sandor.yu@nxp.com, shengjiu.wang@nxp.com, cai.huoqing@linux.dev,
        maxime@cerno.tech, harry.wentland@amd.com,
        hverkuil-cisco@xs4all.nl, amuel@sholland.org
Subject: [PATCH v1 3/5] drm: bridge: dw_hdmi: Enable GCP only for Deep Color
Date:   Wed,  6 Apr 2022 16:48:35 +0800
Message-Id: <ebd9830fe35d79153cb0051bed0d255fb004fb63.1649230434.git.Sandor.yu@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1649230434.git.Sandor.yu@nxp.com>
References: <cover.1649230434.git.Sandor.yu@nxp.com>
In-Reply-To: <cover.1649230434.git.Sandor.yu@nxp.com>
References: <cover.1649230434.git.Sandor.yu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sandor Yu <Sandor.yu@nxp.com>

HDMI1.4b specification section 6.5.3:
Source shall only send GCPs with non-zero CD to sinks
that indicate support for Deep Color.

DW HDMI GPC default enabled, clear gpc_auto bit for bpp 24.

Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index b11577de4836..c7b11582529e 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -1160,6 +1160,14 @@ static void hdmi_video_packetize(struct dw_hdmi *hdmi)
 		HDMI_VP_PR_CD_DESIRED_PR_FACTOR_MASK);
 	hdmi_writeb(hdmi, val, HDMI_VP_PR_CD);
 
+	val = hdmi_readb(hdmi, HDMI_FC_DATAUTO3);
+	if (color_depth == 4)
+		/* disable Auto GCP when bpp 24 */
+		val &= ~0x4;
+	else
+		val |= 0x4;
+	hdmi_writeb(hdmi, val, HDMI_FC_DATAUTO3);
+
 	hdmi_modb(hdmi, HDMI_VP_STUFF_PR_STUFFING_STUFFING_MODE,
 		  HDMI_VP_STUFF_PR_STUFFING_MASK, HDMI_VP_STUFF);
 
-- 
2.25.1

