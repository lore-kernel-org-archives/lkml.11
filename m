Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E223EC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jun 2022 02:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356102AbiFVCoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jun 2022 22:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbiFVCoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 22:44:04 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 31A382DA89
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 19:44:03 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 694DC1E80CD1;
        Wed, 22 Jun 2022 10:43:55 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id g-aAP4y71aKv; Wed, 22 Jun 2022 10:43:52 +0800 (CST)
Received: from localhost.localdomain (unknown [112.64.61.97])
        (Authenticated sender: jiaming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id D94A21E80C7D;
        Wed, 22 Jun 2022 10:43:51 +0800 (CST)
From:   Zhang Jiaming <jiaming@nfschina.com>
To:     airlied@linux.ie, daniel@ffwll.ch, joe@perches.com
Cc:     lyude@redhat.com, kherbst@redhat.com, bskeggs@redhat.com,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, liqiong@nfschina.com,
        renyu@nfschina.com, Zhang Jiaming <jiaming@nfschina.com>
Subject: [PATCH v2] drm/nouveau/mmu: Fix a typo
Date:   Wed, 22 Jun 2022 10:42:36 +0800
Message-Id: <20220622024236.12533-1-jiaming@nfschina.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220622015249.8390-1-jiaming@nfschina.com>
References: <20220622015249.8390-1-jiaming@nfschina.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a typo in comments. Change 'neeed' to 'needed'.

Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
index 8bf00b396ec1..8b11dfa0998d 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
@@ -280,7 +280,7 @@ nvkm_vmm_unref_ptes(struct nvkm_vmm_iter *it, bool pfn, u32 ptei, u32 ptes)
 	if (desc->type == SPT && (pgt->refs[0] || pgt->refs[1]))
 		nvkm_vmm_unref_sptes(it, pgt, desc, ptei, ptes);
 
-	/* PT no longer neeed?  Destroy it. */
+	/* PT no longer needed?  Destroy it. */
 	if (!pgt->refs[type]) {
 		it->lvl++;
 		TRA(it, "%s empty", nvkm_vmm_desc_type(desc));
-- 
2.25.1

