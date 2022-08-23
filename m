Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F96C32772
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 16:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244295AbiHWQ5H (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 12:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343954AbiHWQ4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:56:12 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB0C79A73
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 07:17:08 -0700 (PDT)
X-QQ-mid: bizesmtp67t1661264209tmandx92
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 23 Aug 2022 22:16:48 +0800 (CST)
X-QQ-SSF: 0100000000200040B000B00A0000000
X-QQ-FEAT: DRnj/z+SqadpCEghBpgq7LJX/PHMdriy6At6rgB/GbbTYMVqDsOAUEfaumTrn
        ARfWW62rl5r3QX97oJaACzGsWiEYmakVBq5PefJ91/KNXLL/aE4KW7r+rN8nu7jLVkma5k4
        b3zBBfNAuvxYC50rmHZbBiKvpFETEE3uWiMfA8awxSTW6vUDAQh/WMyvtyltUWL1+1lzZ6L
        /xFKnGsnOZq/sDwKjfju3HcW0fmU8E+71KPjlBbePDfwT5SB3zK8tKB+a8Rvo67viFzmnLE
        nfUiTTT+2QIfz7r/AxAlhu9iSfcv+eevNOmqqElGXVMBctlwcIKP1nYBzK5KvtMr1tLrxud
        io+ZWyOhs3kaognV5dPX0tyFM96q0gYnZIBOzLZG4LwMD1MJjWJEPkQ7GQk3A==
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] drm/i915: fix repeated words in comments
Date:   Tue, 23 Aug 2022 22:16:39 +0800
Message-Id: <20220823141639.13053-1-wangjianli@cdjrlc.com>
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
 drivers/gpu/drm/i915/i915_irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_irq.c b/drivers/gpu/drm/i915/i915_irq.c
index 73cebc6aa650..783a6ca41a61 100644
--- a/drivers/gpu/drm/i915/i915_irq.c
+++ b/drivers/gpu/drm/i915/i915_irq.c
@@ -65,7 +65,7 @@
 
 /*
  * Interrupt statistic for PMU. Increments the counter only if the
- * interrupt originated from the the GPU so interrupts from a device which
+ * interrupt originated from the GPU so interrupts from a device which
  * shares the interrupt line are not accounted.
  */
 static inline void pmu_irq_stats(struct drm_i915_private *i915,
-- 
2.36.1

