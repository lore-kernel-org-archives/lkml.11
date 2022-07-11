Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757AAC43334
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jul 2022 03:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiGKDXK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Jul 2022 23:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGKDXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 23:23:07 -0400
Received: from out199-4.us.a.mail.aliyun.com (out199-4.us.a.mail.aliyun.com [47.90.199.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B4F17ABD
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 20:23:05 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R651e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VIuVGFt_1657509771;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VIuVGFt_1657509771)
          by smtp.aliyun-inc.com;
          Mon, 11 Jul 2022 11:23:00 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     daniel@zonque.org
Cc:     haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] ARM: pxa/eseries: Remove duplicate include
Date:   Mon, 11 Jul 2022 11:22:49 +0800
Message-Id: <20220711032249.22382-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The include is in line 19. Remove the duplicate.

Fix following checkincludes warning:

./arch/arm/mach-pxa/eseries.c: linux/gpio/machine.h is included more than once.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 arch/arm/mach-pxa/eseries.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-pxa/eseries.c b/arch/arm/mach-pxa/eseries.c
index 2e4daeab6278..f306796050c2 100644
--- a/arch/arm/mach-pxa/eseries.c
+++ b/arch/arm/mach-pxa/eseries.c
@@ -19,7 +19,6 @@
 #include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/memblock.h>
-#include <linux/gpio/machine.h>
 
 #include <video/w100fb.h>
 
-- 
2.20.1.7.g153144c

