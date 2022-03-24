Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4B4C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Mar 2022 09:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349127AbiCXJJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Mar 2022 05:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240160AbiCXJJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 05:09:10 -0400
Received: from mail.meizu.com (edge07.meizu.com [112.91.151.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4468A9D0E2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 02:07:38 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail11.meizu.com
 (172.16.1.15) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 24 Mar
 2022 17:07:29 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Thu, 24 Mar
 2022 17:07:29 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     <patrik.r.jakobsson@gmail.com>, <airlied@linux.ie>,
        <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        "Haowen Bai" <baihaowen@meizu.com>
Subject: [PATCH] drm: gma500: clean up some style problems reported by checkpatch.pl
Date:   Thu, 24 Mar 2022 17:07:28 +0800
Message-ID: <1648112848-29052-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-125.meizu.com (172.16.1.125) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING: Statements should start on a tabstop

WARNING: Missing a blank line after declarations

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 drivers/gpu/drm/gma500/mid_bios.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/gma500/mid_bios.c b/drivers/gpu/drm/gma500/mid_bios.c
index 7e76790..71942c2 100644
--- a/drivers/gpu/drm/gma500/mid_bios.c
+++ b/drivers/gpu/drm/gma500/mid_bios.c
@@ -50,8 +50,8 @@ static void mid_get_fuse_settings(struct drm_device *dev)
 	DRM_INFO("internal display is %s\n",
 		 dev_priv->iLVDS_enable ? "LVDS display" : "MIPI display");
 
-	 /* Prevent runtime suspend at start*/
-	 if (dev_priv->iLVDS_enable) {
+	/* Prevent runtime suspend at start*/
+	if (dev_priv->iLVDS_enable) {
 		dev_priv->is_lvds_on = true;
 		dev_priv->is_mipi_on = false;
 	} else {
@@ -325,6 +325,7 @@ static void mid_get_vbt_data(struct drm_psb_private *dev_priv)
 int mid_chip_setup(struct drm_device *dev)
 {
 	struct drm_psb_private *dev_priv = to_drm_psb_private(dev);
+
 	mid_get_fuse_settings(dev);
 	mid_get_vbt_data(dev_priv);
 	mid_get_pci_revID(dev_priv);
-- 
2.7.4

