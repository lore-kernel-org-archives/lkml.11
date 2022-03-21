Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF037C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Mar 2022 23:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbiCUXBY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Mar 2022 19:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233620AbiCUW7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 18:59:17 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2337E32A591
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 15:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=piBh/tjqMdJH263YcMC5WTs7iuvgu1VQYTi2OHIKUPI=; b=WrfLJoy9GqnP0b9IGqTfhorFFL
        NLgE3SSkCmJFiE2jmoWtPp/q7asjGMrwBubHYS2DcgLTuDgsNOHcbrIQ1fQbcn18jZlgLOYpKUBFD
        jAX7SuOaZrYOVQSvuzbOwiPfTV/zKOH9c3XeabYAFBOGCzmttLBvTzeknlHCWCQVIPckPqgbZukfT
        m+CtO0eM2upoLqAd9Bb5ncNkuBLRInBZxYXq1Ozpee4jPjhlejhLSbE7rgNc7/triT0cM4+WwjgnW
        p5lLcaTPfAsLL+E+4EqTeVbM1OMznVTtZmBNwBQJuCWS4iQrQwTKTK6bvk9ewPA/XFOXWwGQYKU4n
        DTVk60LA==;
Received: from [165.90.126.25] (helo=killbill.home)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1nWPLc-0000ww-5f; Mon, 21 Mar 2022 22:13:52 +0100
From:   Melissa Wen <mwen@igalia.com>
To:     emma@anholt.net, airlied@linux.ie, daniel@ffwll.ch
Cc:     Rob Herring <robh@kernel.org>, Melissa Wen <mwen@igalia.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/v3d: cleanup BOs properly when lookup_bos fails
Date:   Mon, 21 Mar 2022 20:13:15 -0100
Message-Id: <20220321211316.1423294-2-mwen@igalia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220321211316.1423294-1-mwen@igalia.com>
References: <20220321211316.1423294-1-mwen@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When v3d_lookup_bos fails to `allocate validated BO pointers`,
job->bo_count was already set to args->bo_count, but job->bo points to
NULL. In this scenario, we must verify that job->bo is not NULL before
iterating on it to proper clean up a job. Also, drm_gem_object_put
already checks that the object passed is not NULL, doing the job->bo[i]
checker redundant.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_gem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
index 92bc0faee84f..926bfc7e07fb 100644
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -358,11 +358,11 @@ v3d_job_free(struct kref *ref)
 	struct v3d_job *job = container_of(ref, struct v3d_job, refcount);
 	int i;
 
-	for (i = 0; i < job->bo_count; i++) {
-		if (job->bo[i])
+	if (job->bo) {
+		for (i = 0; i < job->bo_count; i++)
 			drm_gem_object_put(job->bo[i]);
+		kvfree(job->bo);
 	}
-	kvfree(job->bo);
 
 	dma_fence_put(job->irq_fence);
 	dma_fence_put(job->done_fence);
-- 
2.35.1

