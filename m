Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E2BC47080
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 07:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355718AbiDLH3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 03:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351765AbiDLHMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:12:54 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9ACD94;
        Mon, 11 Apr 2022 23:52:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2A8B8CE1C09;
        Tue, 12 Apr 2022 06:52:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F100C385A8;
        Tue, 12 Apr 2022 06:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649746339;
        bh=RThewDuSSaDhfeV7W7Ch/9tNuzdmzLS9RuWbGQ+yvVI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uhUdPlaWpgZgzvJbHD8O39R/SJnmlNphU2sFkAVm0ck36bTgzzI+cMoHSkEO5I4aq
         KO/BjkWWouBfzts47lOFesbVylhgIYi1dRtfjvvYBCRyyKUZwAmSEhKzBfP42JxtZ6
         3rPJ08gjtYmtMYVBt7CmCYI4G43nUT31+VPJ+9b0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lijo Lazar <lijo.lazar@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.15 247/277] drm/amdgpu: dont use BACO for reset in S3
Date:   Tue, 12 Apr 2022 08:30:50 +0200
Message-Id: <20220412062949.191054033@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412062942.022903016@linuxfoundation.org>
References: <20220412062942.022903016@linuxfoundation.org>
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


