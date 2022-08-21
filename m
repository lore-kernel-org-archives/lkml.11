Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2AAC00140
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Aug 2022 15:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiHUPLo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Aug 2022 11:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHUPLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 11:11:42 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D635FB5
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 08:11:40 -0700 (PDT)
X-QQ-mid: bizesmtp69t1661094695tad242yf
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 21 Aug 2022 23:11:33 +0800 (CST)
X-QQ-SSF: 01000000000000C0D000B00A0000000
X-QQ-FEAT: LE7C6P2vL8TJ2NV0d6Geu3qzKjOQ8egadwHhH5wys8q4sHfRqkS8ItdYYlKmf
        /dEgdwtBIRd6zTV0MzVzAVvvzfIzQK7MW/4/IB/vO0P7bpJ6trKn7YMcX69VbWrM7Gpar7B
        23tRKu6oqfb6elIzsVgwwUrIloJGMmw9tm8zM96GM/s8TGcx6zefKSTOuLO2qFlEJ81wspP
        gm12i/HoktrIbtw5RP8vu7Yn7KGEOpKirOSZE88SnDzz5eBiDa+2hXxn64dw5qsGUPxZJZI
        z8v4YEKvHSxrqsmLxgUTMhqOdbgeT8I/M1vQB60GHsfGhTHq5/nzp1r5aLIrn8rRGYCCfTm
        QmQz3ZLd/ut3Vd659WDw90d2/20M3M6Vk47dU2B
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     linus.walleij@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] drivers/mfd: fix repeated words in comments
Date:   Sun, 21 Aug 2022 23:11:27 +0800
Message-Id: <20220821151127.54801-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'the'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/mfd/db8500-prcmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index 56c61c99eb23..27a881da4d6e 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -798,7 +798,7 @@ void db8500_prcmu_get_abb_event_buffer(void __iomem **buf)
  * @opp: The new ARM operating point to which transition is to be made
  * Returns: 0 on success, non-zero on failure
  *
- * This function sets the the operating point of the ARM.
+ * This function sets the operating point of the ARM.
  */
 int db8500_prcmu_set_arm_opp(u8 opp)
 {
-- 
2.36.1

