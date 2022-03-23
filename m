Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6ECC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Mar 2022 03:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241678AbiCWDog (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Mar 2022 23:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241665AbiCWDoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 23:44:32 -0400
Received: from mail.meizu.com (edge05.meizu.com [157.122.146.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA486D394
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 20:43:03 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail12.meizu.com
 (172.16.1.108) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 23 Mar
 2022 11:43:02 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Wed, 23 Mar
 2022 11:43:01 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <Vijendar.Mukunda@amd.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Haowen Bai <baihaowen@meizu.com>
Subject: [PATCH] ASoC: amd: Fix duplicate included module.h/io.h
Date:   Wed, 23 Mar 2022 11:42:59 +0800
Message-ID: <1648006979-31031-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up the following includecheck warning:

sound/soc/amd/vangogh/acp5x-mach.c: linux/module.h is included more than once.
sound/soc/amd/vangogh/acp5x-mach.c: linux/io.h is included more than once.

No functional change.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 sound/soc/amd/vangogh/acp5x-mach.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/amd/vangogh/acp5x-mach.c b/sound/soc/amd/vangogh/acp5x-mach.c
index 14cf325..cc8316b 100644
--- a/sound/soc/amd/vangogh/acp5x-mach.c
+++ b/sound/soc/amd/vangogh/acp5x-mach.c
@@ -17,10 +17,8 @@
 #include <linux/clk.h>
 #include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
-#include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/input.h>
-#include <linux/io.h>
 #include <linux/acpi.h>
 #include <linux/dmi.h>
 
-- 
2.7.4

