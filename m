Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666B9C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 24 May 2022 08:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233902AbiEXIj5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 May 2022 04:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233279AbiEXIjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 04:39:46 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA15487A09
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 01:39:30 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VEHDH-Y_1653381556;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VEHDH-Y_1653381556)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 24 May 2022 16:39:28 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     Larry.Finger@lwfinger.net
Cc:     phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] staging: r8188eu: Fix kernel-doc
Date:   Tue, 24 May 2022 16:39:14 +0800
Message-Id: <20220524083914.68736-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following W=1 kernel warnings:

drivers/staging/r8188eu/hal/rtl8188e_phycfg.c:291: warning: expecting
prototype for Function(). Prototype was for rtl8188e_PHY_SetRFReg()
instead.

drivers/staging/r8188eu/hal/rtl8188e_phycfg.c:257: warning: expecting
prototype for Function(). Prototype was for rtl8188e_PHY_QueryRFReg()
instead.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
index 4864dafd887b..6342befec5e0 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
@@ -239,7 +239,7 @@ phy_RFSerialWrite(
 }
 
 /**
-* Function:	PHY_QueryRFReg
+* Function:	rtl8188e_PHY_QueryRFReg()
 *
 * OverView:	Query "Specific bits" to RF register (page 8~)
 *
@@ -265,7 +265,7 @@ u32 rtl8188e_PHY_QueryRFReg(struct adapter *Adapter, u32 RegAddr, u32 BitMask)
 }
 
 /**
-* Function:	PHY_SetRFReg
+* Function:	rtl8188e_PHY_SetRFReg()
 *
 * OverView:	Write "Specific bits" to RF register (page 8~)
 *
-- 
2.20.1.7.g153144c

