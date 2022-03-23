Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E368C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Mar 2022 02:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbiCWCsV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Mar 2022 22:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbiCWCsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 22:48:19 -0400
Received: from mail.meizu.com (edge07.meizu.com [112.91.151.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FF46FA27
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 19:46:47 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail11.meizu.com
 (172.16.1.15) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 23 Mar
 2022 10:46:40 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Wed, 23 Mar
 2022 10:46:39 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     <p.zabel@pengutronix.de>
CC:     <linux-kernel@vger.kernel.org>, Haowen Bai <baihaowen@meizu.com>
Subject: [PATCH] bus: bt1-apb: Fix duplicate included linux/clk.h
Date:   Wed, 23 Mar 2022 10:46:38 +0800
Message-ID: <1648003598-27513-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-124.meizu.com (172.16.1.124) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up the following includecheck warning:

drivers/bus/bt1-apb.c: linux/clk.h is included more than once.

No functional change.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 drivers/bus/bt1-apb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bus/bt1-apb.c b/drivers/bus/bt1-apb.c
index b25ff94..74b1b71 100644
--- a/drivers/bus/bt1-apb.c
+++ b/drivers/bus/bt1-apb.c
@@ -22,7 +22,6 @@
 #include <linux/clk.h>
 #include <linux/reset.h>
 #include <linux/time64.h>
-#include <linux/clk.h>
 #include <linux/sysfs.h>
 
 #define APB_EHB_ISR			0x00
-- 
2.7.4

