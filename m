Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F03C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Apr 2022 20:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392382AbiDUUdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Apr 2022 16:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242527AbiDUUdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 16:33:39 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2904A3F2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 13:30:48 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R901e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VAhNpK0_1650573041;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VAhNpK0_1650573041)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 22 Apr 2022 04:30:46 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     kishon@ti.com
Cc:     vkoul@kernel.org, heiko@sntech.de, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] phy: rockchip-inno-usb2: Clean up some inconsistent indenting
Date:   Fri, 22 Apr 2022 04:30:38 +0800
Message-Id: <20220421203038.4550-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the follow smatch warning:

drivers/phy/rockchip/phy-rockchip-inno-usb2.c:1203
rockchip_usb2phy_probe() warn: inconsistent indenting.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index e377b958d9b6..6711659f727c 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -1200,8 +1200,8 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 
 	else {
 		rphy->grf = syscon_node_to_regmap(dev->parent->of_node);
-			if (IS_ERR(rphy->grf))
-				return PTR_ERR(rphy->grf);
+		if (IS_ERR(rphy->grf))
+			return PTR_ERR(rphy->grf);
 	}
 
 	if (of_device_is_compatible(np, "rockchip,rv1108-usb2phy")) {
-- 
2.20.1.7.g153144c

