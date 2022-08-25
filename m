Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF331C3F6B0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Aug 2022 01:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbiHYBii (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Aug 2022 21:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbiHYBiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 21:38:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC2E9C1D5;
        Wed, 24 Aug 2022 18:36:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5755C61A28;
        Thu, 25 Aug 2022 01:36:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50ED6C433D6;
        Thu, 25 Aug 2022 01:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661391390;
        bh=j7YPlUqWrZukik2jTjuhTBMfAeiXABvybpPiI7ZOqxY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AguuIZfG5p2WZQ3iit/kVTj/JznNd6hX905i4h+cy1I1iNlBYlphT/KA2EmWLPJNL
         ocGqn0q1EH46GMSy8cfIfRtUbFp++G7LCvgXn9QCtSDD/QyTzlXUAWa8mZrfz4IqZg
         tvSbzE3Dg/+v2fWiQCry8J2Zge8ObSYtDWNeK1UDuBB4xTKD/Ud0ynBdZE9CFbtrY0
         WoqolGKkNvCgC13/bgBKwa0kl4ScPStsn6JZwk1Ch5PhGOzgF2gbv4eBSsPz10Uxf+
         UNcuNfK9+QjiB3QVegV+U8GzoCeS+OlhIKpxsWFEuWCXYMTqOKftKzoL79eHPDGCo3
         f3OIY9q4CMPaw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tom Chung <chiahsuan.chung@amd.com>,
        Sun peng Li <Sunpeng.Li@amd.com>,
        Brian Chang <Brian.Chang@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, harry.wentland@amd.com,
        sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, nicholas.kazlauskas@amd.com, Jun.Lei@amd.com,
        meenakshikumar.somasundaram@amd.com, martin.leung@amd.com,
        alvin.lee2@amd.com, Samson.Tam@amd.com, alex.hung@amd.com,
        joshua.aberback@amd.com, wenjing.liu@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.19 26/38] drm/amd/display: Fix plug/unplug external monitor will hang while playback MPO video
Date:   Wed, 24 Aug 2022 21:33:49 -0400
Message-Id: <20220825013401.22096-26-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220825013401.22096-1-sashal@kernel.org>
References: <20220825013401.22096-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Chung <chiahsuan.chung@amd.com>

[ Upstream commit e98459c06e3d45c2229b097f7b8cdd412357fa2f ]

[Why]
Pipes for MPO primary and overlay will be power down and power up during
plug/unplug external monitor while MPO video playback.
But the pipes were the same after plug/unplug and should not need to be
power down and power up or it will make page flip interrupt disabled and
cause hang issue.

[How]
Add pipe split change condition that not only check the top pipe pointer
but also check the index of top pipe if both top pipes are available.

Reviewed-by: Sun peng Li <Sunpeng.Li@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 7d69341acca0..9dbd965d8afb 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1067,8 +1067,15 @@ static void disable_dangling_plane(struct dc *dc, struct dc_state *context)
 		struct dc_stream_state *old_stream =
 				dc->current_state->res_ctx.pipe_ctx[i].stream;
 		bool should_disable = true;
-		bool pipe_split_change =
-			context->res_ctx.pipe_ctx[i].top_pipe != dc->current_state->res_ctx.pipe_ctx[i].top_pipe;
+		bool pipe_split_change = false;
+
+		if ((context->res_ctx.pipe_ctx[i].top_pipe) &&
+			(dc->current_state->res_ctx.pipe_ctx[i].top_pipe))
+			pipe_split_change = context->res_ctx.pipe_ctx[i].top_pipe->pipe_idx !=
+				dc->current_state->res_ctx.pipe_ctx[i].top_pipe->pipe_idx;
+		else
+			pipe_split_change = context->res_ctx.pipe_ctx[i].top_pipe !=
+				dc->current_state->res_ctx.pipe_ctx[i].top_pipe;
 
 		for (j = 0; j < context->stream_count; j++) {
 			if (old_stream == context->streams[j]) {
-- 
2.35.1

