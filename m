Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E62BC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 25 May 2022 13:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239796AbiEYNtj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 May 2022 09:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiEYNtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:49:36 -0400
Received: from cmccmta1.chinamobile.com (cmccmta1.chinamobile.com [221.176.66.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A0092CE24
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 06:49:30 -0700 (PDT)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[172.16.121.17])
        by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee3628e33e6757-0b9b4;
        Wed, 25 May 2022 21:49:27 +0800 (CST)
X-RM-TRANSID: 2ee3628e33e6757-0b9b4
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.0.144.216])
        by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee9628e33e361e-d2f77;
        Wed, 25 May 2022 21:49:26 +0800 (CST)
X-RM-TRANSID: 2ee9628e33e361e-d2f77
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     olivier.moysan@foss.st.com, arnaud.pouliquen@foss.st.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] ASoC: stm32: sai: Remove useless define
Date:   Wed, 25 May 2022 21:50:23 +0800
Message-Id: <20220525135023.6792-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

STM_SAI_IS_SUB_B(x) and STM_SAI_BLOCK_NAME(x) are
not being used, so remove them.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 sound/soc/stm/stm32_sai_sub.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index d300605a2..4b33257c5 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -45,8 +45,6 @@
 #define STM_SAI_B_ID		0x1
 
 #define STM_SAI_IS_SUB_A(x)	((x)->id == STM_SAI_A_ID)
-#define STM_SAI_IS_SUB_B(x)	((x)->id == STM_SAI_B_ID)
-#define STM_SAI_BLOCK_NAME(x)	(((x)->id == STM_SAI_A_ID) ? "A" : "B")
 
 #define SAI_SYNC_NONE		0x0
 #define SAI_SYNC_INTERNAL	0x1
-- 
2.20.1.windows.1



