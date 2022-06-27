Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBBCC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jun 2022 11:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239480AbiF0L5n (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jun 2022 07:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238394AbiF0LvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 07:51:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC972647;
        Mon, 27 Jun 2022 04:44:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5683AB80DFB;
        Mon, 27 Jun 2022 11:44:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A09F2C3411D;
        Mon, 27 Jun 2022 11:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656330248;
        bh=ZYBHfEZ/4hokI7PHDTYMSTxoY8i1qxcmK4/ccWaOjmc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hg+ONekUs83Tp/66dadqeroqFShpLo0sfpLHO9v83DdqF2bi6GgRD+vDta4rUuYcR
         XRBoQM9sBkk1evnQfF0uyymWbOef0x9w7DrbI8YUZChkYG1qwfxTeF/0X3f+Ef6tdp
         iqtBUpw2CZ83b4Q1J04/umkPWO7qDtM10y9Sg2ws=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaron Ma <aaron.ma@canonical.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Mark Pearson <markpearson@lenovo.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.18 093/181] drm/amd: Revert "drm/amd/display: keep eDP Vdd on when eDP stream is already enabled"
Date:   Mon, 27 Jun 2022 13:21:06 +0200
Message-Id: <20220627111947.255307480@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220627111944.553492442@linuxfoundation.org>
References: <20220627111944.553492442@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit 937e24b7f5595566a64e0f856ebab9147f2e4d1b ]

A variety of Lenovo machines with Rembrandt APUs and OLED panels have
stopped showing the display at login.  This behavior clears up after
leaving it idle and moving the mouse or touching keyboard.

It was bisected to be caused by commit 559e2655220d ("drm/amd/display:
keep eDP Vdd on when eDP stream is already enabled").  Revert this commit
to fix the issue.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2047
Reported-by: Aaron Ma <aaron.ma@canonical.com>
Fixes: 559e2655220d ("drm/amd/display: keep eDP Vdd on when eDP stream is already enabled")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Tested-by: Mark Pearson <markpearson@lenovo.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../display/dc/dce110/dce110_hw_sequencer.c   | 24 ++-----------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 248602c15f3a..6007b847b54f 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1771,29 +1771,9 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 				break;
 			}
 		}
-
-		/*
-		 * TO-DO: So far the code logic below only addresses single eDP case.
-		 * For dual eDP case, there are a few things that need to be
-		 * implemented first:
-		 *
-		 * 1. Change the fastboot logic above, so eDP link[0 or 1]'s
-		 * stream[0 or 1] will all be checked.
-		 *
-		 * 2. Change keep_edp_vdd_on to an array, and maintain keep_edp_vdd_on
-		 * for each eDP.
-		 *
-		 * Once above 2 things are completed, we can then change the logic below
-		 * correspondingly, so dual eDP case will be fully covered.
-		 */
-
-		// We are trying to enable eDP, don't power down VDD if eDP stream is existing
-		if ((edp_stream_num == 1 && edp_streams[0] != NULL) || can_apply_edp_fast_boot) {
+		// We are trying to enable eDP, don't power down VDD
+		if (can_apply_edp_fast_boot)
 			keep_edp_vdd_on = true;
-			DC_LOG_EVENT_LINK_TRAINING("Keep eDP Vdd on\n");
-		} else {
-			DC_LOG_EVENT_LINK_TRAINING("No eDP stream enabled, turn eDP Vdd off\n");
-		}
 	}
 
 	// Check seamless boot support
-- 
2.35.1



