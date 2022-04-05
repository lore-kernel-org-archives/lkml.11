Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE899C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 00:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445044AbiDFAx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 20:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356769AbiDEKYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 06:24:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6858DBF53B;
        Tue,  5 Apr 2022 03:08:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B3F76179D;
        Tue,  5 Apr 2022 10:08:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A12E4C385A0;
        Tue,  5 Apr 2022 10:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649153338;
        bh=xakmxZtCSnxgVfsDrqj19Nm5hkpjREj2jKL0vzK4tiU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hkt64Huk4Ixs6G5K2WsQjI6gyPvqmvwXOVqCUx2AnewCiMDNILBKaR/2I1Q09KHIz
         sdM2Ct60hkcgH1xT+O+EU/0wMWG73J34/HifddCt6pNRXgfhVCDLBAjYPJn1ofE3h+
         S4Srh7+wEGqCDiPlzJDN8qZ9JZgdAYXX9NPcy6Q4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 187/599] media: staging: media: zoran: fix usage of vb2_dma_contig_set_max_seg_size
Date:   Tue,  5 Apr 2022 09:28:01 +0200
Message-Id: <20220405070304.406826520@linuxfoundation.org>
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

From: Corentin Labbe <clabbe@baylibre.com>

[ Upstream commit 241f5b67fb48def58643f279dfb8468bdd54b443 ]

vb2_dma_contig_set_max_seg_size need to have a size in parameter and not
a DMA_BIT_MASK().
While fixing this issue, also fix error handling of all DMA size
setting.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: d4ae3689226e5 ("media: zoran: device support only 32bit DMA address")
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/media/zoran/zoran_card.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/zoran/zoran_card.c b/drivers/staging/media/zoran/zoran_card.c
index dfc60e2e9dd7..721f1decb0a7 100644
--- a/drivers/staging/media/zoran/zoran_card.c
+++ b/drivers/staging/media/zoran/zoran_card.c
@@ -1068,8 +1068,10 @@ static int zoran_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 	if (err)
-		return -ENODEV;
-	vb2_dma_contig_set_max_seg_size(&pdev->dev, DMA_BIT_MASK(32));
+		return err;
+	err = vb2_dma_contig_set_max_seg_size(&pdev->dev, U32_MAX);
+	if (err)
+		return err;
 
 	nr = zoran_num++;
 	if (nr >= BUZ_MAX) {
-- 
2.34.1



