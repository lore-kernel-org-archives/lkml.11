Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6348CC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 00:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1583941AbiDEX5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 19:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349071AbiDEJtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:49:03 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959B6A94F9;
        Tue,  5 Apr 2022 02:39:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 789C6CE1C99;
        Tue,  5 Apr 2022 09:39:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69C0EC385A3;
        Tue,  5 Apr 2022 09:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649151589;
        bh=gTcQxgbW4COQXq5fMU0aviuScxbT25guRukRsR9GfNw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tni8DkpuGHoW/0MkmbmpZDQc6HSTO02kE983DdYgDT9PSH3BA2p8kclHxFka4DMLL
         fMBC84esS61ENAVsFIDRdG6IkmLL3e7vkf7qNWsOOZrjL5z5UeoSoDKUUpgROBtuE3
         oFabRj+rVYGrJCXidmK/NxrttvvIoKpWZAmqlX5g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 453/913] iommu/ipmmu-vmsa: Check for error num after setting mask
Date:   Tue,  5 Apr 2022 09:25:15 +0200
Message-Id: <20220405070353.427613641@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070339.801210740@linuxfoundation.org>
References: <20220405070339.801210740@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiasheng Jiang <jiasheng@iscas.ac.cn>

[ Upstream commit 1fdbbfd5099f797a4dac05e7ef0192ba4a9c39b4 ]

Because of the possible failure of the dma_supported(), the
dma_set_mask_and_coherent() may return error num.
Therefore, it should be better to check it and return the error if
fails.

Fixes: 1c894225bf5b ("iommu/ipmmu-vmsa: IPMMU device is 40-bit bus master")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
Reviewed-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Link: https://lore.kernel.org/r/20220106024302.2574180-1-jiasheng@iscas.ac.cn
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/ipmmu-vmsa.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index d38ff29a76e8..96708cd2757f 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -982,7 +982,9 @@ static int ipmmu_probe(struct platform_device *pdev)
 	bitmap_zero(mmu->ctx, IPMMU_CTX_MAX);
 	mmu->features = of_device_get_match_data(&pdev->dev);
 	memset(mmu->utlb_ctx, IPMMU_CTX_INVALID, mmu->features->num_utlbs);
-	dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(40));
+	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(40));
+	if (ret)
+		return ret;
 
 	/* Map I/O memory and request IRQ. */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
2.34.1



