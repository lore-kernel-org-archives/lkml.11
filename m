Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060E9C48BD1
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Apr 2022 15:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbiDAPPL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Apr 2022 11:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350829AbiDAOsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 10:48:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E044046B29;
        Fri,  1 Apr 2022 07:38:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B928360F69;
        Fri,  1 Apr 2022 14:37:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BBDDC36AE2;
        Fri,  1 Apr 2022 14:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648823873;
        bh=9SwZjN5pei0120WJ30KOigmqHH8xQmOIc1MenG8KrVk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VAqyKiexRogIOki6IIvkCo2ttbP9L28UcYkIRDdAdEQxEmpgI7qYT3hhhGEZrVm2e
         UvhIoEROb4LUlw+r+KK3J04L9FpOKJfTMeiJUOfb2K4zKsgK/IuvedjMlch+1FSLLB
         RdmKItjHohul2cp7y1CZ1KPvARQoL3OZDQsRaiAppOoquuMMI02NpnXiSpzYAw/uTP
         2d5t39Y9b3bxraKKhh49/k0qbHf4iDEzYD+JRMNWf97fvJbx5hKdUIui697yz5Gbcb
         gx0UL5JRYgtb1uochR33lnt41GUvzLOEDD/kunQSulgZC42spB3sqMPHnYuzSUd6lV
         bM7xc81jb1w4w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dale Zhao <dale.zhao@amd.com>, Aric Cyr <Aric.Cyr@amd.com>,
        Wayne Lin <wayne.lin@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, harry.wentland@amd.com,
        sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, Jun.Lei@amd.com, aric.cyr@amd.com,
        Jimmy.Kizito@amd.com, wenjing.liu@amd.com,
        nicholas.kazlauskas@amd.com, mario.kleiner.de@gmail.com,
        Dmytro.Laktyushkin@amd.com, Jerry.Zuo@amd.com,
        meenakshikumar.somasundaram@amd.com, eric.bernstein@amd.com,
        Martin.Leung@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.15 03/98] drm/amd/display: Add signal type check when verify stream backends same
Date:   Fri,  1 Apr 2022 10:36:07 -0400
Message-Id: <20220401143742.1952163-3-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220401143742.1952163-1-sashal@kernel.org>
References: <20220401143742.1952163-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dale Zhao <dale.zhao@amd.com>

[ Upstream commit 047db281c026de5971cedb5bb486aa29bd16a39d ]

[Why]
For allow eDP hot-plug feature, the stream signal may change to VIRTUAL
when plug-out and back to eDP when plug-in. OS will still setPathMode
with same timing for each plugging, but eDP gets no stream update as we
don't check signal type changing back as keeping it VIRTUAL. It's also
unsafe for future cases that stream signal is switched with same timing.

[How]
Check stream signal type change include previous HDMI signal case.

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Dale Zhao <dale.zhao@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 7ae409f7dcf8..108f3854cd2a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1599,6 +1599,9 @@ static bool are_stream_backends_same(
 	if (is_timing_changed(stream_a, stream_b))
 		return false;
 
+	if (stream_a->signal != stream_b->signal)
+		return false;
+
 	if (stream_a->dpms_off != stream_b->dpms_off)
 		return false;
 
-- 
2.34.1

