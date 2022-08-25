Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E4CC64990
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Aug 2022 01:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbiHYBlQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Aug 2022 21:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbiHYBkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 21:40:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8A49C2D8;
        Wed, 24 Aug 2022 18:38:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CBC361A2D;
        Thu, 25 Aug 2022 01:37:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34664C433C1;
        Thu, 25 Aug 2022 01:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661391445;
        bh=VIx/d02QfIo7UUaY+zwbhDs8dbz2nDq89MF6JfDefMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gleO9Mj8RovqHy8FwxBb/xu0eFu2D4vSHX4AmPhmTjhHODeK8YBA9UPGvvzV0bkmA
         YyrNDxlcHVVWQ7/pR5wmCY9orWpSEwFHUkYAJjv8y0Z5q8/HTa1FqUJxJiKDEg+W1f
         elzbxgX8X7g/xs55B/PNBUmLDxVhH+oWQQM4HoWu9gUzDCXoXjMMc5douQtzMaJ/+R
         fElLcZhPWkK4uQuyR/hKHRA/b8LMKro5oMrRNW2/YA+QG22hVFZ01Rhf6KaqHFTJEE
         8eKH9nGeg1wLipK60DDhs2ODPSLFNhaxbeVW7hoBup6JqaRXe8Snb8527su0yuyQSY
         MUnoOR7wO4/Ug==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Josip Pavic <Josip.Pavic@amd.com>, Jun Lei <Jun.Lei@amd.com>,
        Alex Hung <alex.hung@amd.com>, Aric Cyr <aric.cyr@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, harry.wentland@amd.com,
        sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, jiapeng.chong@linux.alibaba.com,
        chiahsuan.chung@amd.com, isabbasso@riseup.net,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.15 03/20] drm/amd/display: Avoid MPC infinite loop
Date:   Wed, 24 Aug 2022 21:36:55 -0400
Message-Id: <20220825013713.22656-3-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220825013713.22656-1-sashal@kernel.org>
References: <20220825013713.22656-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josip Pavic <Josip.Pavic@amd.com>

[ Upstream commit 8de297dc046c180651c0500f8611663ae1c3828a ]

[why]
In some cases MPC tree bottom pipe ends up point to itself.  This causes
iterating from top to bottom to hang the system in an infinite loop.

[how]
When looping to next MPC bottom pipe, check that the pointer is not same
as current to avoid infinite loop.

Reviewed-by: Josip Pavic <Josip.Pavic@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c | 6 ++++++
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c
index 11019c2c62cc..8192f1967e92 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c
@@ -126,6 +126,12 @@ struct mpcc *mpc1_get_mpcc_for_dpp(struct mpc_tree *tree, int dpp_id)
 	while (tmp_mpcc != NULL) {
 		if (tmp_mpcc->dpp_id == dpp_id)
 			return tmp_mpcc;
+
+		/* avoid circular linked list */
+		ASSERT(tmp_mpcc != tmp_mpcc->mpcc_bot);
+		if (tmp_mpcc == tmp_mpcc->mpcc_bot)
+			break;
+
 		tmp_mpcc = tmp_mpcc->mpcc_bot;
 	}
 	return NULL;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c
index 947eb0df3f12..142fc0a3a536 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c
@@ -532,6 +532,12 @@ struct mpcc *mpc2_get_mpcc_for_dpp(struct mpc_tree *tree, int dpp_id)
 	while (tmp_mpcc != NULL) {
 		if (tmp_mpcc->dpp_id == 0xf || tmp_mpcc->dpp_id == dpp_id)
 			return tmp_mpcc;
+
+		/* avoid circular linked list */
+		ASSERT(tmp_mpcc != tmp_mpcc->mpcc_bot);
+		if (tmp_mpcc == tmp_mpcc->mpcc_bot)
+			break;
+
 		tmp_mpcc = tmp_mpcc->mpcc_bot;
 	}
 	return NULL;
-- 
2.35.1

