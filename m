Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98537C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 01:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1454759AbiDFBJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 21:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232475AbiDEKeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 06:34:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13165DEBB2;
        Tue,  5 Apr 2022 03:19:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51B34B81C9B;
        Tue,  5 Apr 2022 10:19:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9252EC385A0;
        Tue,  5 Apr 2022 10:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649153952;
        bh=sulm2l5MFKxSWxx/4IX0otO2ult3nj9f2nHGUriHALA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XxeBrc+mabrfCNALm7/Yjlu6TZkojacVvSy3V8VbyPU6CCTKB06a6sfODYENCGHCs
         QsyrfhtPEIn5imKS5szrKps06ckRkdKutTPS4SRxZWQQVVR0R+CAYnZ3/eSJn0BsLJ
         nr4GFMYZhngGPRlm/+LC0eJb0ulPi91CCWoRr9IA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jie Hai <haijie1@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 404/599] dmaengine: hisi_dma: fix MSI allocate fail when reload hisi_dma
Date:   Tue,  5 Apr 2022 09:31:38 +0200
Message-Id: <20220405070310.853553440@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070258.802373272@linuxfoundation.org>
References: <20220405070258.802373272@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jie Hai <haijie1@huawei.com>

[ Upstream commit b95044b38425f563404234d96bbb20cc6360c7e1 ]

Remove the loaded hisi_dma driver and reload it, the driver fails
to work properly. The following error is reported in the kernel log:

[ 1475.597609] hisi_dma 0000:7b:00.0: Failed to allocate MSI vectors!
[ 1475.604915] hisi_dma: probe of 0000:7b:00.0 failed with error -28

As noted in "The MSI Driver Guide HOWTO"[1], the number of MSI
interrupt must be a power of two. The Kunpeng DMA driver allocates 30
MSI interrupts. As a result, no space left on device is reported
when the driver is reloaded and allocates interrupt vectors from the
interrupt domain.

This patch changes the number of interrupt vectors allocated by
hisi_dma driver to 32 to avoid this problem.

[1] https://www.kernel.org/doc/html/latest/PCI/msi-howto.html

Fixes: e9f08b65250d ("dmaengine: hisilicon: Add Kunpeng DMA engine support")

Signed-off-by: Jie Hai <haijie1@huawei.com>
Acked-by: Zhou Wang <wangzhou1@hisilicon.com>
Link: https://lore.kernel.org/r/20220216072101.34473-1-haijie1@huawei.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/hisi_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/hisi_dma.c b/drivers/dma/hisi_dma.c
index e1a958ae7925..3e83769615d1 100644
--- a/drivers/dma/hisi_dma.c
+++ b/drivers/dma/hisi_dma.c
@@ -30,7 +30,7 @@
 #define HISI_DMA_MODE			0x217c
 #define HISI_DMA_OFFSET			0x100
 
-#define HISI_DMA_MSI_NUM		30
+#define HISI_DMA_MSI_NUM		32
 #define HISI_DMA_CHAN_NUM		30
 #define HISI_DMA_Q_DEPTH_VAL		1024
 
-- 
2.34.1



