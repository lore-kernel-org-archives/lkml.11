Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DC2C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jun 2022 12:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350396AbiFUM03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jun 2022 08:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350178AbiFUM01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 08:26:27 -0400
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED5126110
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 05:26:22 -0700 (PDT)
X-QQ-mid: bizesmtp68t1655814248tsg3wlrl
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 21 Jun 2022 20:24:03 +0800 (CST)
X-QQ-SSF: 0100000000700050B000B00A0000000
X-QQ-FEAT: dpyQmELDBxGZZGGMb7kRAH5LZZ0E9bcGybyJwXeI5Ux1xMw/S+RgxzsMBKN4j
        9TSlmwNroBUtec6Z+fHFCTOoB6F/3YZBTOVZtcp0SG30hTD4xn6Ed8kPJTCWQkHsjwx23Iq
        nGoLPi1Mcc19wofPJgcCQvug0c6H2qEMPc6y9Gm19fBVeKwCE7w+wQmWtsSd31dxUsC3nsA
        y5+eYioWyuTVfvkAWjZAf0Y9XBI+2JDgYgPOYoTs2e6pg6eKRrLgBCZXsps7zLoaHLZEw4Y
        wqn3A2MhoNItmeC+hVIJ0osb8gBFvQ8tnNHFKWneouSu43hdy3CHzIwDcCppU8Wun7tjmPS
        pGwy9tNogolY/c0OvPg3AQJ4zdKyw==
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     alcooperx@gmail.com
Cc:     bcm-kernel-feedback-list@broadcom.com, kishon@ti.com,
        vkoul@kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] phy: phy-brcm-usb: drop unexpected word "the" in the comments
Date:   Tue, 21 Jun 2022 20:24:01 +0800
Message-Id: <20220621122401.115500-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is an unexpected word "the" in the comments that need to be dropped

file: ./drivers/phy/broadcom/phy-brcm-usb-init.c
line: 864
 * Make sure the the second and third memory controller
changed to
 * Make sure the second and third memory controller

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/phy/broadcom/phy-brcm-usb-init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/broadcom/phy-brcm-usb-init.c b/drivers/phy/broadcom/phy-brcm-usb-init.c
index dd0f66288fbd..dddcbd3cd5f3 100644
--- a/drivers/phy/broadcom/phy-brcm-usb-init.c
+++ b/drivers/phy/broadcom/phy-brcm-usb-init.c
@@ -861,7 +861,7 @@ static void usb_init_common(struct brcm_usb_init_params *params)
 	brcmusb_usb2_eye_fix(ctrl);
 
 	/*
-	 * Make sure the the second and third memory controller
+	 * Make sure the second and third memory controller
 	 * interfaces are enabled if they exist.
 	 */
 	if (USB_CTRL_MASK_FAMILY(params, SETUP, SCB1_EN))
-- 
2.17.1

