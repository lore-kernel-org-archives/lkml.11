Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF97DC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Mar 2022 11:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239773AbiCNLz1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Mar 2022 07:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239702AbiCNLzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 07:55:15 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543F465B9;
        Mon, 14 Mar 2022 04:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hx/o3sUmjfaB0QS0sBoTV1A1xLaFjk7pvkOF4evSYgo=;
  b=Qic/F0v68Rvktz0feHj/1yYFO5ESBbuh8nZm6Nh+x/En/If3rnHwB+Z+
   1+dxponU+nxApNDnXdclRlBijjpqoQg4YJGi2xXE3TkdBI2jMTfFzqRzJ
   +rmRmb1beAj6GEYKfMj7jPxlY9M7MDZ50aBzziV3zdRNEv3jsscw4lB6K
   g=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.90,180,1643670000"; 
   d="scan'208";a="25997338"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 12:53:59 +0100
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Andrzej Hajda <andrzej.hajda@intel.com>
Cc:     kernel-janitors@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/30] drm/bridge: analogix_dp: fix typos in comments
Date:   Mon, 14 Mar 2022 12:53:30 +0100
Message-Id: <20220314115354.144023-7-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220314115354.144023-1-Julia.Lawall@inria.fr>
References: <20220314115354.144023-1-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various spelling mistakes in comments.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index eb590fb8e8d0..c719cd5fba77 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -567,7 +567,7 @@ static int analogix_dp_process_equalizer_training(struct analogix_dp_device *dp)
 	analogix_dp_get_adjust_training_lane(dp, adjust_request);
 
 	if (!analogix_dp_channel_eq_ok(link_status, link_align, lane_count)) {
-		/* traing pattern Set to Normal */
+		/* training pattern Set to Normal */
 		retval = analogix_dp_training_pattern_dis(dp);
 		if (retval < 0)
 			return retval;
@@ -1254,7 +1254,7 @@ static int analogix_dp_bridge_attach(struct drm_bridge *bridge,
 	/*
 	 * NOTE: the connector registration is implemented in analogix
 	 * platform driver, that to say connector would be exist after
-	 * plat_data->attch return, that's why we record the connector
+	 * plat_data->attach return, that's why we record the connector
 	 * point after plat attached.
 	 */
 	if (dp->plat_data->attach) {

