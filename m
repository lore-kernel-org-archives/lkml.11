Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D998BC00140
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Aug 2022 14:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiHUObU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Aug 2022 10:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiHUObS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 10:31:18 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94921CB06
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 07:31:14 -0700 (PDT)
X-QQ-mid: bizesmtp82t1661092257tqxhds2p
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 21 Aug 2022 22:30:55 +0800 (CST)
X-QQ-SSF: 0100000000200000B000B00A0000000
X-QQ-FEAT: Wyle2N1OIGk9/qf4RjOezsRwFlh5szDP0qWpg9ROsqG5sbiWbn0ZK8iUFuwsj
        r3CM24sDaCZXdJtyTH7UR/iKB5AGvqSXE0M2tE7adbPMbbOW+Eb5WCQZp7wOTqx1o8pRAsk
        CXe2/Vqov+MGzRUTOHniT+Dk/IsNPg5rWpg/ABfRk3rweBuwLR1l5ZvGGk1vhHqaf7fgbzn
        rMUljpC39odco41y9zm4P8FOqu1SK1SWgxRPJ2X3YqWxhYyZZqcr9X7TFSxgc/k4i8nnSlk
        vhsnjdGrKcNZ6kbDdTnQ1r25m708Qr5zkou5kvQxUoIQM5/2/L7OgA3/Tqk/w1Ay7uSWacG
        r0vR6qZ
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     bskeggs@redhat.com, kherbst@redhat.com, lyude@redhat.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] subdev/clk: fix repeated words in comments
Date:   Sun, 21 Aug 2022 22:30:38 +0800
Message-Id: <20220821143038.46589-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'at'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/clk/gm20b.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/gm20b.c b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/gm20b.c
index a139dafffe06..7c33542f651b 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/gm20b.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/gm20b.c
@@ -581,7 +581,7 @@ gm20b_clk_prog(struct nvkm_clk *base)
 
 	/*
 	 * Interim step for changing DVFS detection settings: low enough
-	 * frequency to be safe at at DVFS coeff = 0.
+	 * frequency to be safe at DVFS coeff = 0.
 	 *
 	 * 1. If voltage is increasing:
 	 * - safe frequency target matches the lowest - old - frequency
-- 
2.36.1

