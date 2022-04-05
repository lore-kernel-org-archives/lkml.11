Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7665CC4321E
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 12:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379412AbiDEL57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 07:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245021AbiDEIxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:53:02 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A63DB8;
        Tue,  5 Apr 2022 01:49:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EBB77CE1C16;
        Tue,  5 Apr 2022 08:49:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C271C385A1;
        Tue,  5 Apr 2022 08:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649148581;
        bh=+vB/c5TYSJXJNmD9pjNpxLmLtUsmHAcZ/hjWBUHuL58=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BPOgxaO91HjIjqdUkjaaWnvctIQxlhz668FDP78dQXTg2BO61x/DdsO+zN7ndpmPC
         1EUFRQIiYJaS0vvZBQF3AdDLVDVh9s21n7cpFU3K0wJwjFt1VfWgEWJzplcQqEJwke
         dE74BuW52X0At4NTNDupt2kTo/nphaBCWVTa7o7k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Steven Price <steven.price@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.16 0407/1017] drm/panfrost: Check for error num after setting mask
Date:   Tue,  5 Apr 2022 09:22:00 +0200
Message-Id: <20220405070406.369395892@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070354.155796697@linuxfoundation.org>
References: <20220405070354.155796697@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiasheng Jiang <jiasheng@iscas.ac.cn>

[ Upstream commit 44ab30b056149bd59dd7989a593dd25ead6007fd ]

Because of the possible failure of the dma_supported(), the
dma_set_mask_and_coherent() may return error num.
Therefore, it should be better to check it and return the error if
fails.

Fixes: f3ba91228e8e ("drm/panfrost: Add initial panfrost driver")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
[Steve: fix Fixes: line]
Reviewed-by: Steven Price <steven.price@arm.com>
Signed-off-by: Steven Price <steven.price@arm.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20220106030326.2620942-1-jiasheng@iscas.ac.cn
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panfrost/panfrost_gpu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
index bbe628b306ee..f8355de6e335 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
@@ -360,8 +360,11 @@ int panfrost_gpu_init(struct panfrost_device *pfdev)
 
 	panfrost_gpu_init_features(pfdev);
 
-	dma_set_mask_and_coherent(pfdev->dev,
+	err = dma_set_mask_and_coherent(pfdev->dev,
 		DMA_BIT_MASK(FIELD_GET(0xff00, pfdev->features.mmu_features)));
+	if (err)
+		return err;
+
 	dma_set_max_seg_size(pfdev->dev, UINT_MAX);
 
 	irq = platform_get_irq_byname(to_platform_device(pfdev->dev), "gpu");
-- 
2.34.1



