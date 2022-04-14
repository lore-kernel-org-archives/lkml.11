Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271D3C4167D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 15:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356592AbiDNPTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 11:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347585AbiDNN7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:59:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CAF3E0F4;
        Thu, 14 Apr 2022 06:50:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F92061DAA;
        Thu, 14 Apr 2022 13:50:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3ABC385A5;
        Thu, 14 Apr 2022 13:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649944206;
        bh=+AkGY8+PhTH+ThLmE3nSHtM39Y6w3htVNAPSTX1ghcM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uqLKbm0N9jKm+HPT+TUPnXS725NLGS4NcIGsImTh7kbF5dj9ggWRQFc4xLgla7obh
         l5JMvzfA9nVj3a7UOL/F9rSJOzVATKKTIjOXpVhg0R1iXTBuNA3VM8uunZuxR1e3qE
         YC3EX73n01YRf+JmDToGmviaGgUuORikZVmDa4Xc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 430/475] drm/imx: Fix memory leak in imx_pd_connector_get_modes
Date:   Thu, 14 Apr 2022 15:13:35 +0200
Message-Id: <20220414110907.097967340@linuxfoundation.org>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220414110855.141582785@linuxfoundation.org>
References: <20220414110855.141582785@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: José Expósito <jose.exposito89@gmail.com>

[ Upstream commit bce81feb03a20fca7bbdd1c4af16b4e9d5c0e1d3 ]

Avoid leaking the display mode variable if of_get_drm_display_mode
fails.

Fixes: 76ecd9c9fb24 ("drm/imx: parallel-display: check return code from of_get_drm_display_mode()")
Addresses-Coverity-ID: 1443943 ("Resource leak")
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Link: https://lore.kernel.org/r/20220108165230.44610-1-jose.exposito89@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/imx/parallel-display.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imx/parallel-display.c b/drivers/gpu/drm/imx/parallel-display.c
index be55548f352a..e24272428744 100644
--- a/drivers/gpu/drm/imx/parallel-display.c
+++ b/drivers/gpu/drm/imx/parallel-display.c
@@ -68,8 +68,10 @@ static int imx_pd_connector_get_modes(struct drm_connector *connector)
 		ret = of_get_drm_display_mode(np, &imxpd->mode,
 					      &imxpd->bus_flags,
 					      OF_USE_NATIVE_MODE);
-		if (ret)
+		if (ret) {
+			drm_mode_destroy(connector->dev, mode);
 			return ret;
+		}
 
 		drm_mode_copy(mode, &imxpd->mode);
 		mode->type |= DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
-- 
2.35.1



