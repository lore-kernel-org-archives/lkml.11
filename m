Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27ACFC2BBE5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Jul 2022 12:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237673AbiGEMTf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Jul 2022 08:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235494AbiGEMM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 08:12:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AEA193ED;
        Tue,  5 Jul 2022 05:10:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B135E61876;
        Tue,  5 Jul 2022 12:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B894BC36AE2;
        Tue,  5 Jul 2022 12:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657023020;
        bh=qgwxdVO/HM/raQbr8pI20444W5XTMtXNLil76eb/GuQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pZOSQ4/6vadcetBMUkxVwifwdW9FiZm2hVDdOdOxtd9BfnAdpKK22bBaqRA7OFr3p
         ZExNu/qxJkN36DFVEpz2IgsFFcDTJF6cq4PEmEbvfKY/3PWgrNcwiVqvz8l2DShvvZ
         tQ777JI7z13Kz8ilO9+NMg6v7tUxd2ABYKjabmCI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Harry Wentland <harry.wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH 5.15 01/98] Revert "drm/amdgpu/display: set vblank_disable_immediate for DC"
Date:   Tue,  5 Jul 2022 13:57:19 +0200
Message-Id: <20220705115617.613236383@linuxfoundation.org>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220705115617.568350164@linuxfoundation.org>
References: <20220705115617.568350164@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Deucher <alexander.deucher@amd.com>

commit a775e4e4941bf2f326aa36c58f67bd6c96cac717 upstream.

This reverts commit 92020e81ddbeac351ea4a19bcf01743f32b9c800.

This causes stuttering and timeouts with DMCUB for some users
so revert it until we understand why and safely enable it
to save power.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1887
Acked-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c           |    1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    3 ---
 2 files changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -333,6 +333,7 @@ int amdgpu_irq_init(struct amdgpu_device
 	if (!amdgpu_device_has_dc_support(adev)) {
 		if (!adev->enable_virtual_display)
 			/* Disable vblank IRQs aggressively for power-saving */
+			/* XXX: can this be enabled for DC? */
 			adev_to_drm(adev)->vblank_disable_immediate = true;
 
 		r = drm_vblank_init(adev_to_drm(adev), adev->mode_info.num_crtc);
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3838,9 +3838,6 @@ static int amdgpu_dm_initialize_drm_devi
 	}
 #endif
 
-	/* Disable vblank IRQs aggressively for power-saving. */
-	adev_to_drm(adev)->vblank_disable_immediate = true;
-
 	/* loops over all connectors on the board */
 	for (i = 0; i < link_cnt; i++) {
 		struct dc_link *link = NULL;


