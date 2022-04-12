Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558C1C4707E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 08:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385906AbiDLIx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 04:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359261AbiDLHmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:42:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA4F2C114;
        Tue, 12 Apr 2022 00:21:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76229B81B58;
        Tue, 12 Apr 2022 07:21:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4257C385A1;
        Tue, 12 Apr 2022 07:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649748080;
        bh=RThewDuSSaDhfeV7W7Ch/9tNuzdmzLS9RuWbGQ+yvVI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xqXwXfHc+vOVy+4KFuRsAwMRy0ox25IWcDZsvNtYF0r0CtayzTkUc80Ujmz4ksu8e
         pPoGK8Zaiqo7rC9HhNzGrPiW6+Y01rX37V9Pcz+zHZUWHfMsOOo7FOZz1/+ackeNSx
         ebkDwPjbCmED903yNGhWGSM5bpVLjxIQR0XU1ooE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lijo Lazar <lijo.lazar@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.17 311/343] drm/amdgpu: dont use BACO for reset in S3
Date:   Tue, 12 Apr 2022 08:32:09 +0200
Message-Id: <20220412063000.299598642@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412062951.095765152@linuxfoundation.org>
References: <20220412062951.095765152@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Deucher <alexander.deucher@amd.com>

commit ebc002e3ee78409c42156e62e4e27ad1d09c5a75 upstream.

Seems to cause a reboots or hangs on some systems.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1924
Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1953
Fixes: daf8de0874ab5b ("drm/amdgpu: always reset the asic in suspend (v2)")
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1045,6 +1045,17 @@ bool amdgpu_dpm_is_baco_supported(struct
 
 	if (!pp_funcs || !pp_funcs->get_asic_baco_capability)
 		return false;
+	/* Don't use baco for reset in S3.
+	 * This is a workaround for some platforms
+	 * where entering BACO during suspend
+	 * seems to cause reboots or hangs.
+	 * This might be related to the fact that BACO controls
+	 * power to the whole GPU including devices like audio and USB.
+	 * Powering down/up everything may adversely affect these other
+	 * devices.  Needs more investigation.
+	 */
+	if (adev->in_s3)
+		return false;
 
 	if (pp_funcs->get_asic_baco_capability(pp_handle, &baco_cap))
 		return false;


