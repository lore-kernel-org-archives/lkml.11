Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DBFC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Jul 2022 23:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236728AbiGGXZt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Jul 2022 19:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236491AbiGGXZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 19:25:47 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9FD24BE7
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 16:25:46 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VIfzb5u_1657236342;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VIfzb5u_1657236342)
          by smtp.aliyun-inc.com;
          Fri, 08 Jul 2022 07:25:42 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     tiwai@suse.com
Cc:     perex@perex.cz, broonie@kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] ASoC: amd: Remove duplicated include in acp-es8336.c
Date:   Fri,  8 Jul 2022 07:25:40 +0800
Message-Id: <20220707232540.22589-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following includecheck warning:
./sound/soc/amd/acp-es8336.c: linux/module.h is included more than once.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 sound/soc/amd/acp-es8336.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/amd/acp-es8336.c b/sound/soc/amd/acp-es8336.c
index eec3d57092fa..ae9e23749cb3 100644
--- a/sound/soc/amd/acp-es8336.c
+++ b/sound/soc/amd/acp-es8336.c
@@ -20,7 +20,6 @@
 #include <linux/input.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
-#include <linux/module.h>
 #include <linux/acpi.h>
 
 #include "../codecs/es8316.h"
-- 
2.20.1.7.g153144c

