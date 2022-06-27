Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22781C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jun 2022 11:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237954AbiF0Lt1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jun 2022 07:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238080AbiF0Lrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 07:47:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DD3E0C9;
        Mon, 27 Jun 2022 04:39:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D607B81123;
        Mon, 27 Jun 2022 11:39:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E11C3411D;
        Mon, 27 Jun 2022 11:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656329965;
        bh=6B5uUYwWf1fmHLXAP5QerfJShSxa6q+o1Lx1NcBbvLY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NJB5eVXZVrTPMZozSL0Go+vy4SYBFnU7XR3YgOZWnVP9WEhOcE4hnY5O69A0XUkiV
         sIDgSl+gYCrHM4t5u7Bo/WPNpq8ZJdwYyeWjah2uRK7uhCEAa/VzX5Gi8GsPTwN3dQ
         W7cED11wxb2XsHxBjOuQbI1LQn0KTbZBo/oLfDC0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Wheeler <daniel.wheeler@amd.com>,
        Wenjing Liu <Wenjing.Liu@amd.com>,
        Alan Liu <HaoPing.Liu@amd.com>,
        George Shen <george.shen@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.18 037/181] drm/amd/display: Fix typo in override_lane_settings
Date:   Mon, 27 Jun 2022 13:20:10 +0200
Message-Id: <20220627111945.638007868@linuxfoundation.org>
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

From: George Shen <george.shen@amd.com>

commit 98b02e9f002b21944176774cf420c4d674f6201c upstream.

[Why]
The function currently skips overriding the drive
settings of the first lane.

[How]
Change for loop to start at 0 instead of 1.

Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -944,7 +944,7 @@ static void override_lane_settings(const
 
 		return;
 
-	for (lane = 1; lane < LANE_COUNT_DP_MAX; lane++) {
+	for (lane = 0; lane < LANE_COUNT_DP_MAX; lane++) {
 		if (lt_settings->voltage_swing)
 			lane_settings[lane].VOLTAGE_SWING = *lt_settings->voltage_swing;
 		if (lt_settings->pre_emphasis)


