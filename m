Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6713C4707F
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Mar 2022 12:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242406AbiCNM3x (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Mar 2022 08:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243874AbiCNMVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 08:21:21 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7143810BC;
        Mon, 14 Mar 2022 05:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VH4JLLVTmsGjZM12TeV9tkCYfL9x4NOujHU4Jgu+w1I=;
  b=L3CXpax2DaNttb9lDffzBgJzlv8QFSW1v5rEwdDwwuvtUyy7/mpbG6iX
   /WY7B1Pp7OxOx5CSLVvbFeFgK55HhM32oZ7Ebx7cCX8bp6RpBRp2UwMBv
   d3MNv+Ns7ff4VorRWJmuPPyY04juf4MHXdfBhjYHAjJIqzZlrjlX1moTG
   U=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.90,180,1643670000"; 
   d="scan'208";a="25997363"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 12:54:00 +0100
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     kernel-janitors@vger.kernel.org,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 29/30] drm/amdgpu: fix typos in comments
Date:   Mon, 14 Mar 2022 12:53:53 +0100
Message-Id: <20220314115354.144023-30-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220314115354.144023-1-Julia.Lawall@inria.fr>
References: <20220314115354.144023-1-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various spelling mistakes in comments.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index fe660a8e150f..970b065e9a6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -340,7 +340,7 @@ static void amdgpu_cs_get_threshold_for_moves(struct amdgpu_device *adev,
 	if (free_vram >= 128 * 1024 * 1024 || free_vram >= total_vram / 8) {
 		s64 min_us;
 
-		/* Be more aggresive on dGPUs. Try to fill a portion of free
+		/* Be more aggressive on dGPUs. Try to fill a portion of free
 		 * VRAM now.
 		 */
 		if (!(adev->flags & AMD_IS_APU))
@@ -1280,7 +1280,7 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 			continue;
 
 		/*
-		 * Work around dma_resv shortcommings by wrapping up the
+		 * Work around dma_resv shortcomings by wrapping up the
 		 * submission in a dma_fence_chain and add it as exclusive
 		 * fence.
 		 */

