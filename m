Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483E7C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Mar 2022 07:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbiCSHdQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Mar 2022 03:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240305AbiCSHdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 03:33:13 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F47812FF8B
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 00:31:53 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id q19so6621219pgm.6
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 00:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=QzDLV0cCeAb+rv+fxj0RGmela1ApQSWzei1cauVEwFA=;
        b=LEVXNTeZJJ80nn6qVqrPjCAcSkk/56tEmue/nPO2/9UaeSJgvFWzXfIFRecH5iE4E3
         WNUnWW2FcXS6nhGW7Qz0yr19v5QN36AmkPB/xP0YyNJFTL/LNX9OXsZHHzfjtXozSPHu
         2rmlM7OOZD0bzRcGj+d0TSmQ9xZAMJyPvXgVmivjyNWZARh1l9uca/IA+QVR6Pr21xMw
         cr/rVjdkDM0PIP5m4rtUTDFQKYWxfqR5424AiBoIC5fmpk0Vw9KJkP0KIV92HQNhSzqI
         wfuEjNXXHmFnn1SHyvhh+zHf5Mzw3Yvb7j32ptAEfGJbB64TVCqp0RkQFFpJW9yutlW5
         66Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QzDLV0cCeAb+rv+fxj0RGmela1ApQSWzei1cauVEwFA=;
        b=LciCBjkHD2TffFqd++IQfo34h+Y6bKPLGOzYmDLX3GG1rYAdoQMAZ1vBLjJRZLTq9S
         mVn8/srPLFjB2wf1dZSTBUw1PN9ez4ORRzmGeEZL1E/zpRdG6nRx2RpFTXpZga+O/bEm
         wRttnt0ef9P88OCTxkUfK02KFAddBuPQhz0qhYRR0G3L+hVApLwIJrZpimVjBY+TnpOQ
         tuDdlqLQ4ZDeiREMOkcbaJ3blq2v9J1gTPxVC/WZ0x5ISIoKgAG64u7hLcMTeF4SYryB
         X8lV7Qraw5mLMeSLnvYVz2P3P1v+PYZr1/Dm/v/zOP3LDgOfnQ6sWcwGjLUVwb7qPUar
         biCg==
X-Gm-Message-State: AOAM533cxLWLbyO3S1unOVMdZlioscVBUU5p1gpKXhy71Gb+9cuZSCmH
        rEujp48rAmEkLdTJScVhdDBgGrk37zNj8g==
X-Google-Smtp-Source: ABdhPJzdkru/fjwamVbwAzLqdlW6FlPJy3EfUcUF/R5TE/jyds0+NPhvAtL1tF5jNkXNCDVjjzP/2g==
X-Received: by 2002:a05:6a00:24cd:b0:4f7:2340:a6cf with SMTP id d13-20020a056a0024cd00b004f72340a6cfmr13894631pfv.36.1647675112656;
        Sat, 19 Mar 2022 00:31:52 -0700 (PDT)
Received: from ubuntu.huawei.com ([119.3.119.18])
        by smtp.googlemail.com with ESMTPSA id s30-20020a056a001c5e00b004f73f27aa40sm11358882pfw.161.2022.03.19.00.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 00:31:52 -0700 (PDT)
From:   Xiaomeng Tong <xiam0nd.tong@gmail.com>
To:     christian.koenig@amd.com, ray.huang@amd.com, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Xiaomeng Tong <xiam0nd.tong@gmail.com>
Subject: [PATCH] ttm: remove check of list iterator against head outside the loop
Date:   Sat, 19 Mar 2022 15:31:43 +0800
Message-Id: <20220319073143.30184-1-xiam0nd.tong@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When list_for_each_entry() completes the iteration over the whole list
without breaking the loop, the iterator value will be a bogus pointer
computed based on the head element.

While it is safe to use the pointer to determine if it was computed
based on the head element with &pos->member == head, using the iterator
variable after the loop should be avoided.

In preparation to limiting the scope of a list iterator to the list
traversal loop, use a dedicated pointer to point to the found element [1].

Link: https://lore.kernel.org/all/YhdfEIwI4EdtHdym@kroah.com/

Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
---
 drivers/gpu/drm/ttm/ttm_bo.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index db3dc7ef5382..413b5bbf2414 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -673,36 +673,36 @@ int ttm_mem_evict_first(struct ttm_device *bdev,
 			struct ww_acquire_ctx *ticket)
 {
 	struct ttm_buffer_object *bo = NULL, *busy_bo = NULL;
+	struct ttm_buffer_object *iter;
 	bool locked = false;
 	unsigned i;
 	int ret;
 
 	spin_lock(&bdev->lru_lock);
 	for (i = 0; i < TTM_MAX_BO_PRIORITY; ++i) {
-		list_for_each_entry(bo, &man->lru[i], lru) {
+		list_for_each_entry(iter, &man->lru[i], lru) {
 			bool busy;
 
-			if (!ttm_bo_evict_swapout_allowable(bo, ctx, place,
+			if (!ttm_bo_evict_swapout_allowable(iter, ctx, place,
 							    &locked, &busy)) {
 				if (busy && !busy_bo && ticket !=
-				    dma_resv_locking_ctx(bo->base.resv))
-					busy_bo = bo;
+				    dma_resv_locking_ctx(iter->base.resv))
+					busy_bo = iter;
 				continue;
 			}
 
-			if (!ttm_bo_get_unless_zero(bo)) {
+			if (!ttm_bo_get_unless_zero(iter)) {
 				if (locked)
-					dma_resv_unlock(bo->base.resv);
+					dma_resv_unlock(iter->base.resv);
 				continue;
 			}
+
+			bo = iter;
 			break;
 		}
 
-		/* If the inner loop terminated early, we have our candidate */
-		if (&bo->lru != &man->lru[i])
+		if (bo)
 			break;
-
-		bo = NULL;
 	}
 
 	if (!bo) {
-- 
2.17.1

