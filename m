Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29F3C433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 01:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346003AbiDLBFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Apr 2022 21:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345357AbiDLA6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 20:58:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B607F2FFF4;
        Mon, 11 Apr 2022 17:51:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1B7A60B2B;
        Tue, 12 Apr 2022 00:51:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D1DC385A3;
        Tue, 12 Apr 2022 00:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649724691;
        bh=9xbv4Za1TAFFjhycOtOVFTWQ4NxLGGzJlFohKfULByU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GCen/5S3n/1hGRb7pnUsmk3xPRGwc5z6Vp/QNWNlcqfFzr/TZFsSV8SHgQOmVIkAb
         mFs+3RWDiqxXoUG5rd4s+YQUwPDpkZHsHZTjwx/xv2k+YVxYWgEsWfL0Ix+7NxWADy
         Xosh3sftb7UhgukgwDfhTVsmtLINxHS0AN5rp0xJjIRTHouhSX9d4g3pX3c1rqJM7y
         oc8JoLDuoat9Y7bszp3yEFtV8TejRI6CEXaS3/qvTM3tVaJvgWL109YaegWyZwlaPj
         iMglvgJzg8JbjL4TqWlIcj/jsEzhes8hZ06DyieYaAW8FDS0IlvlrRDgkOBOIZEHbw
         ilyu8O++qbVDg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Roman Li <Roman.Li@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
        Alex Hung <alex.hung@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, harry.wentland@amd.com,
        sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, nicholas.kazlauskas@amd.com,
        qingqing.zhuo@amd.com, contact@emersion.fr, shenshih@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 16/21] drm/amd/display: Fix allocate_mst_payload assert on resume
Date:   Mon, 11 Apr 2022 20:50:35 -0400
Message-Id: <20220412005042.351105-16-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412005042.351105-1-sashal@kernel.org>
References: <20220412005042.351105-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Li <Roman.Li@amd.com>

[ Upstream commit f4346fb3edf7720db3f7f5e1cab1f667cd024280 ]

[Why]
On resume we do link detection for all non-MST connectors.
MST is handled separately. However the condition for telling
if connector is on mst branch is not enough for mst hub case.
Link detection for mst branch link leads to mst topology reset.
That causes assert in dc_link_allocate_mst_payload()

[How]
Use link type as indicator for mst link.

Reviewed-by: Wayne Lin <Wayne.Lin@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Roman Li <Roman.Li@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8e4d863c7570..a83d33a92650 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1210,7 +1210,8 @@ static int dm_resume(void *handle)
 		 * this is the case when traversing through already created
 		 * MST connectors, should be skipped
 		 */
-		if (aconnector->mst_port)
+		if (aconnector->dc_link &&
+		    aconnector->dc_link->type == dc_connection_mst_branch)
 			continue;
 
 		mutex_lock(&aconnector->hpd_lock);
-- 
2.35.1

