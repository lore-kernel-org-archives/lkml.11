Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F242CC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Mar 2022 08:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349070AbiCXI6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Mar 2022 04:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349095AbiCXI5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 04:57:53 -0400
Received: from m12-12.163.com (m12-12.163.com [220.181.12.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6ABE9D072
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 01:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=3xtT2Ivblp3LZK9Hll
        IJx+ml2hb8oqzdRwacDZ+ib0o=; b=XP3P9pbd1UjG7TvVYAsllbWpF45yqHYmGp
        IlAmdNIO2XDVcTp/KBl3W+yQ8wcHN/Q6TzJ1+ffxfsuS2fJL2Q7xPKYDibcQMwRv
        J6IKuez/e704yfD0JKcMQKEPhJbeoXV62fXjYVmssFtWykh7/zk5ifbOYHQgHfbx
        g3IT/XAmA=
Received: from localhost (unknown [159.226.95.33])
        by smtp8 (Coremail) with SMTP id DMCowADnu4wXMjxi8Rv_Bg--.18696S2;
        Thu, 24 Mar 2022 16:55:51 +0800 (CST)
From:   QintaoShen <unSimple1993@163.com>
To:     sean@poorly.run
Cc:     quic_abhinavk@quicinc.com, robdclark@gmail.com,
        linux-kernel@vger.kernel.org, QintaoShen <unSimple1993@163.com>
Subject: [PATCH v1] drm/msm: Check for NULL return of kzalloc()
Date:   Thu, 24 Mar 2022 16:55:50 +0800
Message-Id: <1648112150-6515-1-git-send-email-unSimple1993@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DMCowADnu4wXMjxi8Rv_Bg--.18696S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFyUtw4xJFW8Cr1UAFy5Jwb_yoWfXFb_C3
        WxZFn3Jry2kFn8K3W7Cr4xZryIyw1F9Fy8Xwn3t3yay3s7Z3W7Xa42yrWrXr1j9Fy7WFyj
        kan7Za45CrsrWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUUdWrPUUUUU==
X-Originating-IP: [159.226.95.33]
X-CM-SenderInfo: 5xqvxz5sohimizt6il2tof0z/xtbBdRfNH1aEB0PumAAAsQ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The allocation of kzalloc() may return NULL, which would bring a NULL
pointer dereference bug.

To avoid this confusion, it is better to check the return value of kzalloc().

Signed-off-by: QintaoShen <unSimple1993@163.com>
---
 drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c b/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
index 5d2ff67..d017deb 100644
--- a/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
+++ b/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
@@ -176,6 +176,8 @@ void msm_disp_snapshot_add_block(struct msm_disp_state *disp_state, u32 len,
 	va_list va;
 
 	new_blk = kzalloc(sizeof(struct msm_disp_state_block), GFP_KERNEL);
+	if (!new_blk)
+		return ;
 
 	va_start(va, fmt);
 
-- 
2.7.4

