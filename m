Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF27C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jul 2022 07:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239645AbiGXHhZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jul 2022 03:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbiGXHhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 03:37:23 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D80613F30;
        Sun, 24 Jul 2022 00:37:18 -0700 (PDT)
X-QQ-mid: bizesmtp80t1658648218tccj66q4
Received: from localhost.localdomain ( [125.70.163.183])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 24 Jul 2022 15:36:56 +0800 (CST)
X-QQ-SSF: 01000000002000007000B00A0000000
X-QQ-FEAT: 7jw2iSiCazoMav4Yzpx3ytw6EPmuPE4/jr5WrcEa/tATwFc9DCuRRags72aEm
        Ni4wJKPcbIzFuMp9rzpXMacoJrYGVH3rW/3F0kQ+/mgtJPAL1MOL57hrgwv4ZYZwPYfiCKM
        T8rwhYhM+7rwqqgy4cydyqW+VX6w8F+YgXIqnqrnd/Hona7FX0NSw0M9BTWNDtHPcHIFDxt
        t6zCE2HGk0bQZpekv88T2NWDfoI3fA6ghFcYA3yw2VKGa+FQLXPzPdHArsm6u0peE4dH+mU
        mNDfJblYFIwudRKXCOxpcsmC+QEaXdpRsLPfUTueF9Gl+Bf6jRTEKRUN8WIOxNA5vZebPeA
        4qqWGSF2YQnpSWSaPpaRc6Nlk/HI8E37yaR3YjmVD4lGMyMXuJ88gYJ3udjHQ==
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch, wangqing@vivo.com, dan.carpenter@oracle.com,
        bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] msm/adreno: fix repeated words in comments
Date:   Sun, 24 Jul 2022 15:36:50 +0800
Message-Id: <20220724073650.16460-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'in'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 9f76f5b15759..9303a011b81d 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -1277,7 +1277,7 @@ static int a6xx_gmu_rpmh_arc_votes_init(struct device *dev, u32 *votes,
 		}
 
 		/*
-		 * Look for a level in in the secondary list that matches. If
+		 * Look for a level in the secondary list that matches. If
 		 * nothing fits, use the maximum non zero vote
 		 */
 
-- 
2.36.1

