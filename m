Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F96C32772
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 16:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245647AbiHWQzP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 12:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245632AbiHWQyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:54:44 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0968590811
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 07:18:59 -0700 (PDT)
X-QQ-mid: bizesmtp88t1661264325tb54gilq
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 23 Aug 2022 22:18:43 +0800 (CST)
X-QQ-SSF: 0100000000200040B000B00A0000000
X-QQ-FEAT: ILHsT53NKPgLTuHpE6ccSHE70S/G0EX2mN4fT6dumbwx7YjyhfDhsWAnefi8+
        sf6o3pVtUwhUSCFlIAZARgDB8TvsFn2X3rBV3TbDNQMr1l3g2jhdnCTm1rAfpyn1qI0MAhC
        njWcuSxPK4v7kwhUZzuMYr8s9+BxfZYYoF6GJKsD8ebVcZwSL0A8ffznYyVjUZm9b1c0uuR
        IP3PHz6O7iqmUCKsBEi3s63DSxC18sVY1qXfi/PqQwpgd/P0UQMJwePOFAV05D70EA31FBz
        3EGHhjbyuV4twtM3sdGvyIE+ZH6AQYtNObJHvE29D80nu9few/S+8STQ2WMKV7FaNF32MVG
        BZ6qHQ3UgJirabWgIEOp+9Ga1prxOP7idbkoo06zR/cgh65DeO7N79Or6iUBw==
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     zhenyuw@linux.intel.com, zhi.a.wang@intel.com,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        odrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] i915/gvt: fix repeated words in comments
Date:   Tue, 23 Aug 2022 22:18:36 +0800
Message-Id: <20220823141836.14176-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'the'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/gpu/drm/i915/gvt/gtt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gtt.c
index b4f69364f9a1..62e5f27adca9 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.c
+++ b/drivers/gpu/drm/i915/gvt/gtt.c
@@ -2786,7 +2786,7 @@ int intel_gvt_init_gtt(struct intel_gvt *gvt)
  * @gvt: GVT device
  *
  * This function is called at the driver unloading stage, to clean up the
- * the mm components of a GVT device.
+ * mm components of a GVT device.
  *
  */
 void intel_gvt_clean_gtt(struct intel_gvt *gvt)
-- 
2.36.1

