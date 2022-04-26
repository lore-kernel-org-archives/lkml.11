Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43680C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Apr 2022 10:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348699AbiDZKWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Apr 2022 06:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348677AbiDZKWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:22:21 -0400
Received: from nksmu.kylinos.cn (mailgw.kylinos.cn [123.150.8.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D756222BE0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 02:51:20 -0700 (PDT)
X-UUID: cb54dad43a4a412d87d0d65462c07a3b-20220426
X-UUID: cb54dad43a4a412d87d0d65462c07a3b-20220426
Received: from cs2c.com.cn [(172.17.111.24)] by nksmu.kylinos.cn
        (envelope-from <pengfuyuan@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 2097729756; Tue, 26 Apr 2022 17:49:40 +0800
X-ns-mid: postfix-6267C08B-6075918069
Received: from localhost.localdomain (unknown [172.20.4.120])
        by cs2c.com.cn (NSMail) with ESMTPA id 6B230383B46C;
        Tue, 26 Apr 2022 09:51:07 +0000 (UTC)
From:   pengfuyuan <pengfuyuan@kylinos.cn>
To:     Liviu Dudau <liviu.dudau@arm.com>
Cc:     Brian Starkey <brian.starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        pengfuyuan <pengfuyuan@kylinos.cn>
Subject: [PATCH] drm/arm/mali-dp: Fix spelling typo in comment
Date:   Tue, 26 Apr 2022 17:51:06 +0800
Message-Id: <20220426095106.34437-1-pengfuyuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix spelling typo in comment.

Signed-off-by: pengfuyuan <pengfuyuan@kylinos.cn>
---
 drivers/gpu/drm/arm/malidp_regs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/malidp_regs.h b/drivers/gpu/drm/arm/malidp_regs.h
index 514c50dcb74d..59f63cc2b304 100644
--- a/drivers/gpu/drm/arm/malidp_regs.h
+++ b/drivers/gpu/drm/arm/malidp_regs.h
@@ -145,7 +145,7 @@
 #define     MALIDP_SE_COEFFTAB_DATA_MASK	0x3fff
 #define     MALIDP_SE_SET_COEFFTAB_DATA(x) \
 		((x) & MALIDP_SE_COEFFTAB_DATA_MASK)
-/* Enhance coeffents reigster offset */
+/* Enhance coeffents register offset */
 #define MALIDP_SE_IMAGE_ENH			0x3C
 /* ENH_LIMITS offset 0x0 */
 #define     MALIDP_SE_ENH_LOW_LEVEL		24
-- 
2.25.1

