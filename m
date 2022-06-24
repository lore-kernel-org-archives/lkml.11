Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4682CCA473
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jun 2022 07:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiFXHZo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jun 2022 03:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiFXHZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 03:25:43 -0400
Received: from out199-14.us.a.mail.aliyun.com (out199-14.us.a.mail.aliyun.com [47.90.199.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BEF4CD41;
        Fri, 24 Jun 2022 00:25:41 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VHG5rQQ_1656055517;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VHG5rQQ_1656055517)
          by smtp.aliyun-inc.com;
          Fri, 24 Jun 2022 15:25:37 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     lewis.hanly@microchip.com
Cc:     conor.dooley@microchip.com, b-liu@ti.com,
        gregkh@linuxfoundation.org, linux-riscv@lists.infradead.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] usb: musb: Fix missing error code in mpfs_probe()
Date:   Fri, 24 Jun 2022 15:25:15 +0800
Message-Id: <20220624072515.123646-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The error code is missing in this code scenario, add the error code
'-ENOMEM' to the return value 'ret'.

This was found by coccicheck:

drivers/usb/musb/mpfs.c:185 mpfs_probe() warn: missing error code 'ret'.

Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/usb/musb/mpfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/musb/mpfs.c b/drivers/usb/musb/mpfs.c
index 99666ef8af06..c8bf6570bcc4 100644
--- a/drivers/usb/musb/mpfs.c
+++ b/drivers/usb/musb/mpfs.c
@@ -181,8 +181,10 @@ static int mpfs_probe(struct platform_device *pdev)
 	glue->clk = clk;
 
 	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
-	if (!pdata)
+	if (!pdata) {
+		ret = -ENOMEM;
 		goto err_clk_disable;
+	}
 
 	pdata->config = &mpfs_musb_hdrc_config;
 	pdata->platform_ops = &mpfs_ops;
-- 
2.20.1.7.g153144c

