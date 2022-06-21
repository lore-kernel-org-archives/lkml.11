Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A198C43334
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jun 2022 10:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbiFUKfy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jun 2022 06:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245168AbiFUKfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 06:35:52 -0400
Received: from smtpbg.qq.com (smtpbg139.qq.com [175.27.65.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFC128992
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 03:35:47 -0700 (PDT)
X-QQ-mid: bizesmtp78t1655807680tu7c5k5i
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 21 Jun 2022 18:34:36 +0800 (CST)
X-QQ-SSF: 0100000000700030B000B00A0000000
X-QQ-FEAT: BVRItfLxsF60sewxQlmNIbCQKJzt9PHky+nXrmRX40dRKOpU98J+BuCrtPdSx
        vrQdQ+sjk9rdtUtmVzVrCmYGxzsNXyRDNJxJbJDbGX2aX4bj5Hf+uH8jJ5NB2H+iFr1XoBm
        QEgdTcmrbBq0s/IXsXGCTfY6fyz/IoeVd+cdUODSoI7OLOf9Qfe50LW2owC+yuUDY2WlocW
        OHmTTLrQK0dQV8CVqiRs+Zk2CpCwIWj8FWIOp/5VeMiI/0p343DydbBlwlN4wDWbIk317a2
        U5FxIgClHAol2V3kPMgjCdAv+0HIaayiqouCasLLWPjyJXCFmL83OOTXcy3KuSvwASo5Y8b
        LfJ1yS+TYPCboTuF+k=
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org, jiangjian@cdjrlc.com
Subject: [PATCH] mailbox: Kconfig - drop unexpected word "the" in the comments
Date:   Tue, 21 Jun 2022 18:34:34 +0800
Message-Id: <20220621103434.93916-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is an unexpected word "the" in the comments that need to be dropped

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/mailbox/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 05d6fae800e3..089ef39a71fa 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -66,7 +66,7 @@ config ARMADA_37XX_RWTM_MBOX
 	depends on ARCH_MVEBU || COMPILE_TEST
 	depends on OF
 	help
-	  Mailbox implementation for communication with the the firmware
+	  Mailbox implementation for communication with the firmware
 	  running on the Cortex-M3 rWTM secure processor of the Armada 37xx
 	  SOC. Say Y here if you are building for such a device (for example
 	  the Turris Mox router).
-- 
2.17.1

