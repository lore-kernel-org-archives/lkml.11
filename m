Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B275FC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Apr 2022 02:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiDUC6X (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Apr 2022 22:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiDUC6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 22:58:22 -0400
Received: from mail.meizu.com (edge01.meizu.com [14.29.68.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE66FE0A1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 19:55:33 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail04.meizu.com
 (172.16.1.16) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 21 Apr
 2022 10:55:34 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Thu, 21 Apr
 2022 10:55:30 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>
CC:     Haowen Bai <baihaowen@meizu.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] ARM: mvebu: Remove useless null check before call of_node_put()
Date:   Thu, 21 Apr 2022 10:55:28 +0800
Message-ID: <1650509728-28138-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to add null check before call of_node_put(), since the
implementation of of_node_put() has done it.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 arch/arm/mach-mvebu/pm-board.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-mvebu/pm-board.c b/arch/arm/mach-mvebu/pm-board.c
index 070552511699..8d7385473626 100644
--- a/arch/arm/mach-mvebu/pm-board.c
+++ b/arch/arm/mach-mvebu/pm-board.c
@@ -126,8 +126,7 @@ static int __init mvebu_armada_pm_init(void)
 			goto out;
 		}
 
-		if (gpio_ctrl_np)
-			of_node_put(gpio_ctrl_np);
+		of_node_put(gpio_ctrl_np);
 		gpio_ctrl_np = args.np;
 		pic_raw_gpios[i] = args.args[0];
 	}
-- 
2.7.4

