Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB63C43334
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jun 2022 10:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiFWKPW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jun 2022 06:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiFWKPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 06:15:18 -0400
Received: from smtpbg.qq.com (smtpbg138.qq.com [106.55.201.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF9A49F9F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 03:15:14 -0700 (PDT)
X-QQ-mid: bizesmtp80t1655979295tq1gavlg
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 23 Jun 2022 18:14:50 +0800 (CST)
X-QQ-SSF: 01000000008000B0C000B00A0000000
X-QQ-FEAT: qpGeUh0uYB9S1TzaUBc1+BFLhEgoP88Y8lak3PyjSnXOH66GM4RrMOqIgHykO
        ErGJfCB20o+zSjTY6lHkeKoiYQlLIL66dJ3AeJivoSvBmbp/e0rkw5VGOxBpo8vvj/9bHGR
        qvyJGXa0RKmx6iFqjkZu/hQ/ICSBWpTPCbBhUW37n6/lPKzYKAZp3V1XQ7uxx4Nom/wLn9Q
        AXC3ZzzqoRWdpPvil9xcdqtenONfOn/JVgK/Z7dqT/tsI7ObL1kQrBdDOCYwNzcEv9PUmMu
        QIfsjn0Pv+TS9efMQaiFBCjZvhnvUQisgGSDWxmQr2+C0ca5EqWAo8vhORlIh6xgYYqEQWP
        FhzDiVza4CtcfJ5k5TBrIxVtT4uqA==
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     airlied@linux.ie, daniel@ffwll.ch
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, Philip.Yang@amd.com, Felix.Kuehling@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] drm/amdgpu: drop unexpected word 'for' in comments
Date:   Thu, 23 Jun 2022 18:14:48 +0800
Message-Id: <20220623101448.30188-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam10
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is an unexpected word 'for' in the comments that need to be dropped

file - drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
line - 245

 * position and also advance the position for for Vega10

changed to:

 * position and also advance the position for Vega10

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
index 3df146579ad9..1d5af50331e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
@@ -242,7 +242,7 @@ int amdgpu_ih_process(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih)
  * @entry: IV entry
  *
  * Decodes the interrupt vector at the current rptr
- * position and also advance the position for for Vega10
+ * position and also advance the position for Vega10
  * and later GPUs.
  */
 void amdgpu_ih_decode_iv_helper(struct amdgpu_device *adev,
-- 
2.17.1

