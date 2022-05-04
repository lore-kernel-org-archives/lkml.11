Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B100C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 May 2022 22:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379881AbiEDXAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 May 2022 19:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379583AbiEDWzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 18:55:36 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8617954BE5
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 15:51:29 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VCDP-yy_1651704686;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VCDP-yy_1651704686)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 05 May 2022 06:51:27 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     nm@ti.com
Cc:     ssantosh@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] soc: ti: wkup_m3_ipc: remove unneeded semicolon
Date:   Thu,  5 May 2022 06:51:25 +0800
Message-Id: <20220504225125.45830-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the following coccicheck warning:
./drivers/soc/ti/wkup_m3_ipc.c:691:2-3: Unneeded semicolon

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/soc/ti/wkup_m3_ipc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/ti/wkup_m3_ipc.c b/drivers/soc/ti/wkup_m3_ipc.c
index 0076d467ff6b..343c58ed5896 100644
--- a/drivers/soc/ti/wkup_m3_ipc.c
+++ b/drivers/soc/ti/wkup_m3_ipc.c
@@ -688,7 +688,7 @@ static int wkup_m3_ipc_probe(struct platform_device *pdev)
 				      &m3_ipc->sd_fw_name);
 	if (ret) {
 		dev_dbg(dev, "Voltage scaling data blob not provided from DT.\n");
-	};
+	}
 
 	/*
 	 * Wait for firmware loading completion in a thread so we
-- 
2.20.1.7.g153144c

