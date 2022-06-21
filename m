Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780A3C43334
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jun 2022 16:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353036AbiFUQeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jun 2022 12:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352255AbiFUQef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 12:34:35 -0400
Received: from smtpbg.qq.com (smtpbg138.qq.com [106.55.201.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0BB2A255;
        Tue, 21 Jun 2022 09:34:29 -0700 (PDT)
X-QQ-mid: bizesmtp63t1655829264t0lhf7ki
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 22 Jun 2022 00:34:20 +0800 (CST)
X-QQ-SSF: 0100000000700090B000B00A0000000
X-QQ-FEAT: 02HFykG0jkup+85GMAaiRJnteUauInFYoONzz0C96M2bxHG4Kzt1gHgwesaPh
        4gqLyT12vJ9YtuELRSLJcnTPkFSw5tWWC8LLMKV1xQrA/T4E3fpIpKXfLk6awVa8ijl2P7I
        SUqCjWaC1mupL8pGP1V/7vQhnPItcbGYheLDyq6nnmdKG7q606oGdB7hstXAi13mQ6cA7PE
        ay5IzVHwDf5pfoxgkCSuwCtTJBXKZQlFhg7HrsYbFTg+ePgOo+r/UWF8+euegTGjMZSw9Yw
        8ZMOdx8CPSiYIbZ6eRQAVh9ljHW5wZHeIXB6E7CtiiAWD/dIJ8+rjvK7vdelSkCNE5gRiek
        JLbsZktBS0aius6TTU=
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     tsbogend@alpha.franken.de
Cc:     jiangjian@cdjrlc.com, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH]  MIPS: Alchemy: devboards: Remove duplicate 'the' in two places.
Date:   Wed, 22 Jun 2022 00:34:18 +0800
Message-Id: <20220621163418.28663-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam10
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

file: ./arch/mips/alchemy/devboards/pm.c
line: 20
 * sources and configure the timeout after which the the TOYMATCH2 irq
changed to
 * sources and configure the timeout after which the TOYMATCH2 irq

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 arch/mips/alchemy/devboards/pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/alchemy/devboards/pm.c b/arch/mips/alchemy/devboards/pm.c
index 73c77814687a..b17a0d199851 100644
--- a/arch/mips/alchemy/devboards/pm.c
+++ b/arch/mips/alchemy/devboards/pm.c
@@ -17,7 +17,7 @@
  * Generic suspend userspace interface for Alchemy development boards.
  * This code exports a few sysfs nodes under /sys/power/db1x/ which
  * can be used by userspace to en/disable all au1x-provided wakeup
- * sources and configure the timeout after which the the TOYMATCH2 irq
+ * sources and configure the timeout after which the TOYMATCH2 irq
  * is to trigger a wakeup.
  */
 
-- 
2.17.1

