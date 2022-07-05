Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95AF2C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Jul 2022 12:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239208AbiGEMh2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Jul 2022 08:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237994AbiGEM0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 08:26:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0872C19285;
        Tue,  5 Jul 2022 05:19:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A85961AC4;
        Tue,  5 Jul 2022 12:19:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A337BC341C7;
        Tue,  5 Jul 2022 12:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657023568;
        bh=TupROn0Prk4o53TYY45aB41rFTApt8nlnhVS/4hr67w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YHAz3fhnMhtg1TUj0dyWe896NyqJFuBw4wZg40Ld7aXIpkjq0tKJpvx5TVgdZcmp3
         5Dx5h1PkXkNGnW5wV+bpQUy6YSsqffa9LS3mA8DC+cXjLF2KV8vJQ6viiyv8e4q+Dk
         0k44mpmqRqdFVyL5SUXM/rou3vZu6E3ml4/w8OSI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.18 086/102] drm/msm/gem: Fix error return on fence id alloc fail
Date:   Tue,  5 Jul 2022 13:58:52 +0200
Message-Id: <20220705115620.854107113@linuxfoundation.org>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220705115618.410217782@linuxfoundation.org>
References: <20220705115618.410217782@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

[ Upstream commit 08de214138cdea438a0dfcb10d355a6650c6017c ]

This was a typo, we didn't actually want to return zero.

Fixes: a61acbbe9cf8 ("drm/msm: Track "seqno" fences by idr")
Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Patchwork: https://patchwork.freedesktop.org/patch/491145/
Link: https://lore.kernel.org/r/20220624184528.4036837-1-robdclark@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/msm_gem_submit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index c6d60c8d286d..fec4e3973287 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -913,7 +913,7 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 						    INT_MAX, GFP_KERNEL);
 	}
 	if (submit->fence_id < 0) {
-		ret = submit->fence_id = 0;
+		ret = submit->fence_id;
 		submit->fence_id = 0;
 	}
 
-- 
2.35.1



