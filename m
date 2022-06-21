Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157C3C43334
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jun 2022 13:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345907AbiFUNHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jun 2022 09:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbiFUNHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 09:07:20 -0400
Received: from smtpbg.qq.com (smtpbg139.qq.com [175.27.65.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA80F255A6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 06:07:14 -0700 (PDT)
X-QQ-mid: bizesmtp84t1655816757tz4bwr7w
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 21 Jun 2022 21:05:52 +0800 (CST)
X-QQ-SSF: 0100000000700050B000B00A0000000
X-QQ-FEAT: ZHWZeLXy+8cVkqGqk70IZEdYsDCNTtFptYtfnC7SwFGnX0MxFWBt02UT3ufnU
        S4xgDrTaijqexc3isqvp40esGxJpnEYT4rbvzUE9h21iUo1hR8zPDGPCrDlc1Y+zl7UoYtp
        P2iS9NfE+3E+r6w2EmfH4mvQfRWuVtx28Jxd+digEdJHBsOrPhqkBLmX4ggARqun+r9XRnK
        G4nQoOoS1s79t5ehFcVkRx1NJOU9EJLxludL0wARFfKNcD+W2Gtfzw8VG0Zoi1WtVe58Vga
        MIJv2MeN0JI2o+CUsA7wyCmAMhm1N5W1vwMHpYzsV+ivoHqeRdi/zVJUJ2AihIazIQlRZQL
        QYpBIY3ETg3CcGdarwUJtB/+Cxy2g==
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     airlied@linux.ie, daniel@ffwll.ch
Cc:     emma@anholt.net, mripard@kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] drm/vc4: drop unexpected word "the" in the comments
Date:   Tue, 21 Jun 2022 21:05:50 +0800
Message-Id: <20220621130550.126915-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is an unexpected word "the" in the comments that need to be dropped

file: drivers/gpu/drm/vc4/vc4_regs.h
line: 267
/* Set when the the downstream tries to read from the display FIFO
changed to
/* Set when the downstream tries to read from the display FIFO

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/gpu/drm/vc4/vc4_regs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_regs.h b/drivers/gpu/drm/vc4/vc4_regs.h
index a2b5cbbbc1b0..f0290fad991d 100644
--- a/drivers/gpu/drm/vc4/vc4_regs.h
+++ b/drivers/gpu/drm/vc4/vc4_regs.h
@@ -264,7 +264,7 @@
  * output line.
  */
 # define SCALER_DISPSTAT_ESLINE(x)		BIT(10 + ((x) * 8))
-/* Set when the the downstream tries to read from the display FIFO
+/* Set when the downstream tries to read from the display FIFO
  * while it's empty.
  */
 # define SCALER_DISPSTAT_EUFLOW(x)		BIT(9 + ((x) * 8))
-- 
2.17.1

