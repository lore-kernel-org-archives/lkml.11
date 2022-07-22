Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DCAC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jul 2022 10:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbiGVKUU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jul 2022 06:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiGVKUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 06:20:17 -0400
Received: from mail-m974.mail.163.com (mail-m974.mail.163.com [123.126.97.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E4E3DDF4D
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 03:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=THWpc
        7mp5zOgTdKtgaYC/1Yv1hebLAaDdItjTt4a1j0=; b=Xk/YZ1e99HF1wy1oudrQn
        7leLFv7hxVc9Vc+QC4pqNhGtIVueLVh40cXY8P0Xa8mIzgrp3X7TTZ616EJCXBUn
        FxloW2fDn3bIGEFQR9vD+aaQLH3Sh9EcclefTkZhlUXizlr3HTVW75hmsu9q/mmk
        kAUrLmdNXVhOQo4tYcEOhY=
Received: from localhost.localdomain (unknown [112.97.59.29])
        by smtp4 (Coremail) with SMTP id HNxpCgAHRnatedpiaF6GQA--.23969S2;
        Fri, 22 Jul 2022 18:19:27 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     herberthbli@tencent.com, herbert@gondor.apana.org.au,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] lib/mpi: Fix typo 'the the' in comment
Date:   Fri, 22 Jul 2022 18:19:22 +0800
Message-Id: <20220722101922.81126-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HNxpCgAHRnatedpiaF6GQA--.23969S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTRqfOrUUUUU
X-Originating-IP: [112.97.59.29]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbCdQ9GZGBbEb3UkgAAsJ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 'the the' with 'the' in the comment.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 lib/mpi/mpiutil.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/mpi/mpiutil.c b/lib/mpi/mpiutil.c
index bc81419f400c..aa8c46544af8 100644
--- a/lib/mpi/mpiutil.c
+++ b/lib/mpi/mpiutil.c
@@ -272,7 +272,7 @@ MPI mpi_set_ui(MPI w, unsigned long u)
 	if (!w)
 		w = mpi_alloc(1);
 	/* FIXME: If U is 0 we have no need to resize and thus possible
-	 * allocating the the limbs.
+	 * allocating the limbs.
 	 */
 	RESIZE_IF_NEEDED(w, 1);
 	w->d[0] = u;
-- 
2.25.1

