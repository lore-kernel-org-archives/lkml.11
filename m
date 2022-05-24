Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8070CC433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 May 2022 08:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbiEXIMO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 May 2022 04:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbiEXIMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 04:12:10 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15562FFE5
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 01:12:07 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R711e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VEHD8XS_1653379916;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VEHD8XS_1653379916)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 24 May 2022 16:12:04 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, Likun.Gao@amd.com, flora.cui@amd.com,
        yifan1.zhang@amd.com, luben.tuikov@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] drm/amdgpu/discovery: make amdgpu_discovery_get_mall_info static
Date:   Tue, 24 May 2022 16:11:54 +0800
Message-Id: <20220524081154.35061-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This symbol is not used outside of amdgpu_discovery.c, so marks it static.

Fixes the following w1 warning:

drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1364:5: warning: no
previous prototype for ‘amdgpu_discovery_get_mall_info’
[-Wmissing-prototypes].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 881570dced41..16cdfb30b013 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1361,7 +1361,7 @@ union mall_info {
 	struct mall_info_v1_0 v1;
 };
 
-int amdgpu_discovery_get_mall_info(struct amdgpu_device *adev)
+static int amdgpu_discovery_get_mall_info(struct amdgpu_device *adev)
 {
 	struct binary_header *bhdr;
 	union mall_info *mall_info;
-- 
2.20.1.7.g153144c

