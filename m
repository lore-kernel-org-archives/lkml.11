Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECBEC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jul 2022 07:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbiGZHc3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jul 2022 03:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiGZHbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 03:31:41 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129442E9E4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:27:49 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VKUPgsP_1658820434;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VKUPgsP_1658820434)
          by smtp.aliyun-inc.com;
          Tue, 26 Jul 2022 15:27:16 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH 13/20] drm/amd/display: Clean up some inconsistent indenting
Date:   Tue, 26 Jul 2022 15:25:48 +0800
Message-Id: <20220726072555.91323-13-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20220726072555.91323-1-jiapeng.chong@linux.alibaba.com>
References: <20220726072555.91323-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional modification involved.

smatch warnings:

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_mpc.c:305 mpc20_get_ogam_current() warn: inconsistent indenting.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 .../gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c  | 36 +++++++++----------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c
index 15734db0cdea..3d307dd58e9a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c
@@ -299,24 +299,24 @@ static enum dc_lut_mode mpc20_get_ogam_current(struct mpc *mpc, int mpcc_id)
 	uint32_t state_mode;
 	struct dcn20_mpc *mpc20 = TO_DCN20_MPC(mpc);
 
-	REG_GET(MPCC_OGAM_LUT_RAM_CONTROL[mpcc_id],
-			MPCC_OGAM_CONFIG_STATUS, &state_mode);
-
-		switch (state_mode) {
-		case 0:
-			mode = LUT_BYPASS;
-			break;
-		case 1:
-			mode = LUT_RAM_A;
-			break;
-		case 2:
-			mode = LUT_RAM_B;
-			break;
-		default:
-			mode = LUT_BYPASS;
-			break;
-		}
-		return mode;
+	REG_GET(MPCC_OGAM_LUT_RAM_CONTROL[mpcc_id], MPCC_OGAM_CONFIG_STATUS, &state_mode);
+
+	switch (state_mode) {
+	case 0:
+		mode = LUT_BYPASS;
+		break;
+	case 1:
+		mode = LUT_RAM_A;
+		break;
+	case 2:
+		mode = LUT_RAM_B;
+		break;
+	default:
+		mode = LUT_BYPASS;
+		break;
+	}
+
+	return mode;
 }
 
 static void mpc2_program_lutb(struct mpc *mpc, int mpcc_id,
-- 
2.20.1.7.g153144c

