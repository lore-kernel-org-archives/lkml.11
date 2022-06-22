Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE240C43334
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jun 2022 14:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356276AbiFVOrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jun 2022 10:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234468AbiFVOrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:47:03 -0400
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F407E3D482;
        Wed, 22 Jun 2022 07:46:58 -0700 (PDT)
X-QQ-mid: bizesmtp82t1655909132tayjd3s4
Received: from ubuntu.localdomain ( [106.117.78.84])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 22 Jun 2022 22:45:27 +0800 (CST)
X-QQ-SSF: 01000000008000B0B000E00A0000000
X-QQ-FEAT: ZHWZeLXy+8ccYDnDNqsyMZI0CU3GWcmP17rM7zdSPdGRVVfYdwz8jIwc2eo2I
        kfbolRK+ICh7uYcO4+gSiajaAdeDAso1iTjpXJuoPayKQT/9OQGjDYfNUYApeKfRUGNUVFv
        1biMHBy6j+nBgUG3OnmNw6V6dYNLchttO/+xLBhV3YvWhXvaIHC+KG7n1O2ofBhf1/ZKTTU
        MNxNP0lu0cB20qkr1yXRH4QFRVQQy4qkU6YafFNAfRPuY/UxYozI1AA/6EVsE+41ozYyEwS
        wOb1EkF5xUu2ly2XeD4C8gI3mZigLpZDyi/TQSSWT2Uz7HV7JV0iJZLpuOi0GReSvN9h+qn
        ZOvILq/yw9WZ0WJa/thXqE+erLUBd2TMbUl3AXE
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     michael.chan@broadcom.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] bnxt: Fix typo in comments
Date:   Wed, 22 Jun 2022 22:45:26 +0800
Message-Id: <20220622144526.20659-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the repeated word 'and' from comments

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 56b46b8206a7..b474a4fe4039 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -10658,7 +10658,7 @@ static void __bnxt_close_nic(struct bnxt *bp, bool irq_re_init,
 	while (bnxt_drv_busy(bp))
 		msleep(20);
 
-	/* Flush rings and and disable interrupts */
+	/* Flush rings and disable interrupts */
 	bnxt_shutdown_nic(bp, irq_re_init);
 
 	/* TODO CHIMP_FW: Link/PHY related cleanup if (link_re_init) */
-- 
2.17.1

