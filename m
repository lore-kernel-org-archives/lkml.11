Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3AEC43334
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jun 2022 05:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344715AbiFUFGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jun 2022 01:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiFUFGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 01:06:52 -0400
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF3B20BFA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 22:06:46 -0700 (PDT)
X-QQ-mid: bizesmtp88t1655787993tbc01hsc
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 21 Jun 2022 13:06:29 +0800 (CST)
X-QQ-SSF: 01000000000000009000000A0000000
X-QQ-FEAT: NTS5Yb/oJHs9wDaGi1JTw5ttwWoqdengp0IZDzk4/c4eUGu+UxEFS1gP7nLSd
        bydopXRwS7ueVoa8VFhL2dLZYp9fSE+tzIY+E6UZTUFr5Ah8qQdgup0cal1UI7z1Ikzl8yb
        kpRo6omsNFp0cG7ewmBUnUtoeIbfmCJ9rQhyqOw7m9fV/xoHslMmi8Y175kbfP1lwXNbg8j
        gcqCrz0orTW4h8F5SDIwxAVdId1mn+S5yNMA+HHvxfR7exBqsCOGlVyz5ZmNd5nKh41unU/
        E3wsEgrjjPecJRzWXx1kNjjvBA7loarkFamw==
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     geert@linux-m68k.org
Cc:     jiangjian@cdjrlc.com, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] m68k: aligned '*' in comments
Date:   Tue, 21 Jun 2022 13:06:27 +0800
Message-Id: <20220621050627.13666-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The '*' in the comment is not aligned

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 arch/m68k/q40/q40ints.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/q40/q40ints.c b/arch/m68k/q40/q40ints.c
index 6886a5d0007b..d15057d34e56 100644
--- a/arch/m68k/q40/q40ints.c
+++ b/arch/m68k/q40/q40ints.c
@@ -32,7 +32,7 @@
  *            33   : frame int (50/200 Hz periodic timer)
  *            34   : sample int (10/20 KHz periodic timer)
  *
-*/
+ */
 
 static void q40_irq_handler(unsigned int, struct pt_regs *fp);
 static void q40_irq_enable(struct irq_data *data);
-- 
2.17.1

