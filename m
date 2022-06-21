Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2931CC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jun 2022 10:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346612AbiFUKjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jun 2022 06:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbiFUKja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 06:39:30 -0400
Received: from smtpbg.qq.com (smtpbg139.qq.com [175.27.65.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1926B289B7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 03:39:25 -0700 (PDT)
X-QQ-mid: bizesmtp91t1655807926tju1pf8n
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 21 Jun 2022 18:38:41 +0800 (CST)
X-QQ-SSF: 0100000000700030B000B00A0000000
X-QQ-FEAT: k0yT7W7BRd1mxiwRAHB7UOK1ZuvCpbv6dU1ECuA4BgCGWxZ1yHVvkgVRfnSVt
        hr5+D85E+3+uS/CuAK2BP8emFGKX3xU78YHtB7xvhtXhmwBvuKkFro1Woc92CotGyQaPuSb
        /nLER+MSzNRVpF+xBFOjgOVdXHHuLWhehWy3pfr8eIev7qPP+C+J68xVSDgW8GzBUo1wAGB
        CzxH2j3YMMqHxwrl1Zm9YyffRNj3BSi1SO/TEgbkIo1rMjys+FMPBuNK4TJBVaQUdoEywb6
        HmA5ICi2Tts1kFdH1ARpVfpcTumnUMfjjS7iz+kJRf7XSnUzd3hbI4qXNz3HQHOK7oM7yAb
        eix8YFrFUvPA75hH/Y=
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     linus.walleij@linaro.org
Cc:     lee.jones@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, jiangjian@cdjrlc.com
Subject: [PATCH] mfd: db8500-prcmu: drop unexpected word "the" in the comments
Date:   Tue, 21 Jun 2022 18:38:39 +0800
Message-Id: <20220621103839.96847-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is an unexpected word "the" in the comments that need to be dropped

Line 801: * This function sets the the operating point of the ARM.

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
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
2.17.1


