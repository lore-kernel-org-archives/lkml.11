Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9946CC35295
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 09:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387223AbiDLJGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 05:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359241AbiDLHmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:42:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566422A268;
        Tue, 12 Apr 2022 00:21:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16542B81B62;
        Tue, 12 Apr 2022 07:21:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C961C385A5;
        Tue, 12 Apr 2022 07:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649748063;
        bh=LveDTNz49FYcxLOtDFHSOrot2rhbCYmOg4T9rw6dpMs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GVuE2r5KsUbeHJ4RT/lu9VHo4h6zxLR0EEVvri5IsU9rSkYE4mDzGp0St86SUMa1A
         WwH/Heqw6vBV4fLw+duv5bXcpYr6DlzGoDF37IXeiIAsusAX8cb3bs8aPEIk3jXkm8
         vI/gscOZvfRe8WXv331GaTY561uOcHw1FKOO8w+0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Benjamin Marty <info@benjaminmarty.ch>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.17 306/343] drm/amdgpu/display: change pipe policy for DCN 2.1
Date:   Tue, 12 Apr 2022 08:32:04 +0200
Message-Id: <20220412063000.156159554@linuxfoundation.org>
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

From: Benjamin Marty <info@benjaminmarty.ch>

commit 879791ad8bf3dc5453061cad74776a617b6e3319 upstream.

Fixes crash on MST Hub disconnect.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1849
Fixes: ee2698cf79cc ("drm/amd/display: Changed pipe split policy to allow for multi-display pipe split")
Signed-off-by: Benjamin Marty <info@benjaminmarty.ch>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -873,7 +873,7 @@ static const struct dc_debug_options deb
 		.clock_trace = true,
 		.disable_pplib_clock_request = true,
 		.min_disp_clk_khz = 100000,
-		.pipe_split_policy = MPC_SPLIT_DYNAMIC,
+		.pipe_split_policy = MPC_SPLIT_AVOID_MULT_DISP,
 		.force_single_disp_pipe_split = false,
 		.disable_dcc = DCC_ENABLE,
 		.vsr_support = true,


