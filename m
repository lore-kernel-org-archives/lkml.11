Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CBCC433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Apr 2022 15:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359153AbiDCPSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Apr 2022 11:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbiDCPSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 11:18:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84271D0EF
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 08:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=V6sH+g86l/Gc0arpRwq9DTzlLgDsZvIIMYn0mNrAsdM=; b=sGdljc04ZPiKBo0uzq+te6hrUJ
        e3BVx3oEQjxmXHXyiFKZJ3QSQuJ0l1EaPhzatJ2zp0P3aWWxVOWM6uLlLOHyER1r6/CV7PEUQjsny
        R7mzEBT0Z6GXFqdoLd6JrGwLUu7dHvkF5LVNV1YNYJA0aDm0LPtWX8c1FMosoVSLSwvnFfgPWw3s2
        nwDuNeYmP/+jdDc7NI51x7Qgobwq4qoolb5r87ztoXJ+vEIyR7KXHJNgoYSw0vnsSkSZneP1+4b9n
        hUQWJs0AC4ot7xx891GQpjDTZlX5sZ0dHLco2zocDAcmUUrGHe8Dvp+oEj7T2Y0SkgvmtQWCfkTAy
        EG9rLPug==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nb1y3-00BgU9-Vh; Sun, 03 Apr 2022 15:16:40 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Allen Chen <allen.chen@ite.com.tw>,
        Robert Foss <robert.foss@linaro.org>,
        Hermes Wu <hermes.wu@ite.com.tw>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/bridge: fix it6505 Kconfig terms
Date:   Sun,  3 Apr 2022 08:16:37 -0700
Message-Id: <20220403151637.15546-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix around 50 undefined references when DRM_ITE_IT6505=y while
DRM_DP_AUX_BUS=m and DRM_DP_HELPER=m.

Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Allen Chen <allen.chen@ite.com.tw>
Cc: Robert Foss <robert.foss@linaro.org>
Cc: Hermes Wu <hermes.wu@ite.com.tw>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
---
 drivers/gpu/drm/bridge/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

--- linux-next-20220401.orig/drivers/gpu/drm/bridge/Kconfig
+++ linux-next-20220401/drivers/gpu/drm/bridge/Kconfig
@@ -78,6 +78,8 @@ config DRM_ITE_IT6505
         tristate "ITE IT6505 DisplayPort bridge"
         depends on OF
         select DRM_KMS_HELPER
+	select DRM_DP_AUX_BUS
+	select DRM_DP_HELPER
         select EXTCON
         help
           ITE IT6505 DisplayPort bridge chip driver.
