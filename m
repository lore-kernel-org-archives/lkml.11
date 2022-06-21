Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54396C43334
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jun 2022 13:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345557AbiFUNkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jun 2022 09:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbiFUNkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 09:40:41 -0400
Received: from smtpbg.qq.com (smtpbg139.qq.com [175.27.65.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFB22AD
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 06:40:37 -0700 (PDT)
X-QQ-mid: bizesmtp65t1655818767tu45ejch
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 21 Jun 2022 21:39:22 +0800 (CST)
X-QQ-SSF: 0100000000700060B000D00A0000000
X-QQ-FEAT: FXvDfBZI5O6DgV0I3s0IakLWZaVbIOeZptt8jkiqdC1X/yUp5ELNdn8Vvimqw
        kdqB7vxeV000srLFqPrzmvpRv3xMNGqY/WTZykt2a5+hrZU2ouG6aJY0FwkNxIcz91BpQfG
        VqR06qnanaOXzeMMt3XsO3ofR/u0v1o+Xuvjmy/MwCxeN2KgF90IWZySikkpVqMJ8bHPXsH
        NRdlOMeNA03XnMjqUcn+s0TupNOs31NxK4wghTnvYQSVuCs/aZAMQLbyUfXO3/oIHKhjpYk
        JiuqbONKtHaOpWVxC5aL0UXAns7l7YBvcX5cguXNa3+mnNVAM1JO3eagNC3l7urNzzhZOa9
        rm3F+l7prWovBsId6MgNgmymtknZw==
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     airlied@linux.ie, daniel@ffwll.ch
Cc:     bskeggs@redhat.com, kherbst@redhat.com, lyude@redhat.com,
        jiangjian@cdjrlc.com, Julia.Lawall@inria.fr,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau/mmu: drop unexpected word "the" in the comments
Date:   Tue, 21 Jun 2022 21:39:20 +0800
Message-Id: <20220621133920.8112-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is an unexpected word "the" in the comments that need to be dropped

file: drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
line: 1051
 * have the the deepest nesting of page tables.
changed to
 * have the deepest nesting of page tables.

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
index ca74775834dd..ae793f400ba1 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
@@ -1048,7 +1048,7 @@ nvkm_vmm_ctor(const struct nvkm_vmm_func *func, struct nvkm_mmu *mmu,
 	__mutex_init(&vmm->mutex, "&vmm->mutex", key ? key : &_key);
 
 	/* Locate the smallest page size supported by the backend, it will
-	 * have the the deepest nesting of page tables.
+	 * have the deepest nesting of page tables.
 	 */
 	while (page[1].shift)
 		page++;
-- 
2.17.1

