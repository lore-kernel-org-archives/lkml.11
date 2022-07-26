Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B167C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jul 2022 07:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238497AbiGZHcR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jul 2022 03:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238465AbiGZHbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 03:31:24 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BDE2E9C8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:27:45 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VKUOH31_1658820429;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VKUOH31_1658820429)
          by smtp.aliyun-inc.com;
          Tue, 26 Jul 2022 15:27:11 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH 12/20] drm/amd/display: Clean up some inconsistent indenting
Date:   Tue, 26 Jul 2022 15:25:47 +0800
Message-Id: <20220726072555.91323-12-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20220726072555.91323-1-jiapeng.chong@linux.alibaba.com>
References: <20220726072555.91323-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional modification involved.

smatch warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dwb.c:104 dwb2_enable() warn: inconsistent indenting.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb.c
index 8d3884b306dd..f1490e97b6ce 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb.c
@@ -101,8 +101,8 @@ static bool dwb2_enable(struct dwbc *dwbc, struct dc_dwb_params *params)
 	struct dcn20_dwbc *dwbc20 = TO_DCN20_DWBC(dwbc);
 
 	/* Only chroma scaling (sub-sampling) is supported in DCN2 */
-if ((params->cnv_params.src_width  != params->dest_width) ||
-		(params->cnv_params.src_height != params->dest_height)) {
+	if ((params->cnv_params.src_width  != params->dest_width) ||
+	    (params->cnv_params.src_height != params->dest_height)) {
 
 		DC_LOG_DWB("%s inst = %d, FAILED!LUMA SCALING NOT SUPPORTED", __func__, dwbc20->base.inst);
 		return false;
-- 
2.20.1.7.g153144c

