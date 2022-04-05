Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435D9C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 07:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbiDEHl4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 03:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbiDEHlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 03:41:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176AF4B415;
        Tue,  5 Apr 2022 00:39:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7E25B81B16;
        Tue,  5 Apr 2022 07:39:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A270C340EE;
        Tue,  5 Apr 2022 07:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649144361;
        bh=rNPpBKBRIG+5c/2XpbHrij+gsiWtuZImuUhvEM0pvbc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sj4YzuZCnadTku5ipfGj3+YmO4y6g2Wa2uuazvTHZt4/11csqWRCKjQ5l8Vy8K51O
         m3ChJEuM3rzWPW1pVD1ZvyuL2TWx44kEL58EWuQ8OS3uBYRxurjJGRC9zwKA5/XQeo
         4XdhPlBOvAAipF5M7GgG3kmD+dq+/vC5FZBqyXCA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <Mario.Limonciello@amd.com>
Subject: [PATCH 5.17 0008/1126] drm/amdgpu: move PX checking into amdgpu_device_ip_early_init
Date:   Tue,  5 Apr 2022 09:12:35 +0200
Message-Id: <20220405070407.780658190@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070407.513532867@linuxfoundation.org>
References: <20220405070407.513532867@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Deucher <alexander.deucher@amd.com>

commit 901e2be20dc55079997ea1885ea77fc72e6826e7 upstream.

We need to set the APU flag from IP discovery before
we evaluate this code.

Acked-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Mario Limonciello <Mario.Limonciello@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   13 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |   11 -----------
 2 files changed, 13 insertions(+), 11 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -31,6 +31,7 @@
 #include <linux/console.h>
 #include <linux/slab.h>
 #include <linux/iommu.h>
+#include <linux/pci.h>
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_probe_helper.h>
@@ -2073,6 +2074,8 @@ out:
  */
 static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 {
+	struct drm_device *dev = adev_to_drm(adev);
+	struct pci_dev *parent;
 	int i, r;
 
 	amdgpu_device_enable_virtual_display(adev);
@@ -2137,6 +2140,16 @@ static int amdgpu_device_ip_early_init(s
 		break;
 	}
 
+	if (amdgpu_has_atpx() &&
+	    (amdgpu_is_atpx_hybrid() ||
+	     amdgpu_has_atpx_dgpu_power_cntl()) &&
+	    ((adev->flags & AMD_IS_APU) == 0) &&
+	    !pci_is_thunderbolt_attached(to_pci_dev(dev->dev)))
+		adev->flags |= AMD_IS_PX;
+
+	parent = pci_upstream_bridge(adev->pdev);
+	adev->has_pr3 = parent ? pci_pr3_present(parent) : false;
+
 	amdgpu_amdkfd_device_probe(adev);
 
 	adev->pm.pp_feature = amdgpu_pp_feature_mask;
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -152,21 +152,10 @@ static void amdgpu_get_audio_func(struct
 int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 {
 	struct drm_device *dev;
-	struct pci_dev *parent;
 	int r, acpi_status;
 
 	dev = adev_to_drm(adev);
 
-	if (amdgpu_has_atpx() &&
-	    (amdgpu_is_atpx_hybrid() ||
-	     amdgpu_has_atpx_dgpu_power_cntl()) &&
-	    ((flags & AMD_IS_APU) == 0) &&
-	    !pci_is_thunderbolt_attached(to_pci_dev(dev->dev)))
-		flags |= AMD_IS_PX;
-
-	parent = pci_upstream_bridge(adev->pdev);
-	adev->has_pr3 = parent ? pci_pr3_present(parent) : false;
-
 	/* amdgpu_device_init should report only fatal error
 	 * like memory allocation failure or iomapping failure,
 	 * or memory manager initialization failure, it must


