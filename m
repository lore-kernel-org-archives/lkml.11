Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0B6C0502A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Aug 2022 15:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbiHaPsG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Aug 2022 11:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbiHaPrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 11:47:42 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F6AE035
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 08:46:41 -0700 (PDT)
X-QQ-mid: bizesmtp70t1661960795tqykkmgs
Received: from localhost.localdomain ( [182.148.13.26])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 31 Aug 2022 23:45:55 +0800 (CST)
X-QQ-SSF: 01000000002000B0C000B00A0000000
X-QQ-FEAT: znfcQSa1hKbooLOG/L+TcYbrjBPJUu0PsDgP1TVbCX3enTtdikOD/xpyoIgrR
        5bgnSW0albR3i/IaRZ9Hf0T4IjR+TONZaB3kKCllIUNtKjvW1BNO+a18/pgiFEATxxd+qGt
        UDi8spSQHgAl6/qMAtEPc1hqMEjx1xoOEl1NvnMGhqw2k80dLrQIevfrQ2NSK+v/CU2LsJQ
        e3JhsAPXR5/dE71xPEAK6Mb9UeshzRwgwTRPDes43F5AfGgwVa8f251qo9u+n7H7+G7wto5
        QUGPdTYl5gLmhBP/Y4tC9p6LPRJjgCgjob1cmb1bqRCejrA6yVV1mIGDlNL0xnY97GstDoo
        tYS7zDs8aryRFa1BhZtyKeusdI5PvGNpVSJSW/8Szue0QfdXaE=
X-QQ-GoodBg: 0
From:   Shaomin Deng <dengshaomin@cdjrlc.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] base: Fix double word in comments
Date:   Wed, 31 Aug 2022 11:45:54 -0400
Message-Id: <20220831154554.32761-1-dengshaomin@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the repeated word "core" in comments.

Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
---
 drivers/base/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/init.c b/drivers/base/init.c
index 397eb9880cec..ae75ed7bbc41 100644
--- a/drivers/base/init.c
+++ b/drivers/base/init.c
@@ -30,7 +30,7 @@ void __init driver_init(void)
 	hypervisor_init();
 
 	/* These are also core pieces, but must come after the
-	 * core core pieces.
+	 * core pieces.
 	 */
 	of_core_init();
 	platform_bus_init();
-- 
2.35.1

