Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26260C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 May 2022 14:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244922AbiEYO6W (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 May 2022 10:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244892AbiEYO6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 10:58:14 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526D2AEE10
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 07:58:14 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: alyssa)
        with ESMTPSA id B43D81F450F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653490693;
        bh=V/KfHPBGZosfbKnwVHQPcXJblhj5zBtBpc0Z5yGRgrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WRQHhRiAFVBl75rpUn357RwSiO3Ibg5i7H5HD80WWA47v2CIh4h04LlD2pld3R5kC
         JnRx2TrbiCB6fYd5FerW2SxAIZuR34ir3EZTxm6Pb+ChtF8k5b0MM/YEi4PvfHhYIB
         acxZqLeD9ysQIrR9s2ekfZSezWPsVqQ6TvVR5kYgTt8jrEBgOq6LmYqy51LCntGtlF
         eT1TPhFSM8rx9dr/HD3qlKWEWkKIhUWabzpp9FrITzLIRcUIGl9BUaFcaVLp1jreOY
         n1oEKNn1Krhl8x5CI+V3Xu6linExP5xVh+Jth4Ob7dQ8FPGRI36HBnuT/fE8kQs8MS
         RFUk1lXfIfUYw==
From:   Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/9] drm/panfrost: Constify argument to has_hw_issue
Date:   Wed, 25 May 2022 10:57:48 -0400
Message-Id: <20220525145754.25866-4-alyssa.rosenzweig@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220525145754.25866-1-alyssa.rosenzweig@collabora.com>
References: <20220525145754.25866-1-alyssa.rosenzweig@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Logically, this function is free of side effects, so any pointers it
takes should be const. Needed to avoid a warning in the next patch.

Signed-off-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Reviewed-by: Steven Price <steven.price@arm.com>
---
 drivers/gpu/drm/panfrost/panfrost_issues.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_issues.h b/drivers/gpu/drm/panfrost/panfrost_issues.h
index 41a714ce6fce..14670ee58ace 100644
--- a/drivers/gpu/drm/panfrost/panfrost_issues.h
+++ b/drivers/gpu/drm/panfrost/panfrost_issues.h
@@ -251,7 +251,7 @@ enum panfrost_hw_issue {
 
 #define hw_issues_g76 0
 
-static inline bool panfrost_has_hw_issue(struct panfrost_device *pfdev,
+static inline bool panfrost_has_hw_issue(const struct panfrost_device *pfdev,
 					 enum panfrost_hw_issue issue)
 {
 	return test_bit(issue, pfdev->features.hw_issues);
-- 
2.35.1

