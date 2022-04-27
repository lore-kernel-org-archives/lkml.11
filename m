Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC84DC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Apr 2022 00:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356372AbiD0AZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Apr 2022 20:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343562AbiD0AZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 20:25:39 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFB5473BA
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 17:22:29 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R811e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VBPO99._1651018946;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VBPO99._1651018946)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 27 Apr 2022 08:22:27 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     tiwai@suse.com
Cc:     perex@perex.cz, broonie@kernel.org, yang.jie@linux.intel.com,
        liam.r.girdwood@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, cezary.rojewski@intel.com,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] ASoC: Intel: avs: Remove duplicated include in path.c
Date:   Wed, 27 Apr 2022 08:22:23 +0800
Message-Id: <20220427002223.96786-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following includecheck warning:
./sound/soc/intel/avs/path.c: sound/intel-nhlt.h is included more than
once.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 sound/soc/intel/avs/path.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/intel/avs/path.c b/sound/soc/intel/avs/path.c
index 6f47ac44de87..3d46dd5e5bc4 100644
--- a/sound/soc/intel/avs/path.c
+++ b/sound/soc/intel/avs/path.c
@@ -9,7 +9,6 @@
 #include <sound/intel-nhlt.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/intel-nhlt.h>
 #include "avs.h"
 #include "path.h"
 #include "topology.h"
-- 
2.20.1.7.g153144c

