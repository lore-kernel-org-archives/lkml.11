Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9237DC0502A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Aug 2022 06:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiHaGdE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Aug 2022 02:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiHaGdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 02:33:01 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BB1ABF37;
        Tue, 30 Aug 2022 23:32:58 -0700 (PDT)
X-QQ-mid: bizesmtp91t1661927569tfodjnuc
Received: from localhost.localdomain ( [182.148.13.26])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 31 Aug 2022 14:32:48 +0800 (CST)
X-QQ-SSF: 01000000000000D0E000000A0000000
X-QQ-FEAT: cknW069rtVde5uU2OtD7FUIPxaDf2iueTD2InOxmpEWzMq000o8PggmNrIjQS
        2GyR126X9+HrOdyjLVizWnzbam9S8Uj1NVwk0rZ1JEhdL5ErCwCB0JbGTOIAcIE0QAhg1ZZ
        6FeAitY8kwBsKgl2GAPzENu/oqQNdK6zb+9i+8OH1Y8VFSYo/hA/w7WsvkO8PY+ra1f3dru
        35uk/CzlbIP2w5VOMMqCwTR2npvBv6OTokpBbUsN/nJ40MGgT+UMKpQNDKJHzilSCNlB/8X
        2AMc77QtYgSTTGkmj7BPdKHUaiGESMzvXa+zylgyOBCEC29yuSYmqpqg67e+i6JfewUODE9
        wbLo5TZFxfutIa0awpMNgIFgb0o42u9BivHIAWjRqnuwM2OzLayiXkjtH77bA==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     richard.henderson@linaro.org, ink@jurassic.park.msu.ru,
        mattst88@gmail.com
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] alpha: fix repeated words in comments
Date:   Wed, 31 Aug 2022 14:32:41 +0800
Message-Id: <20220831063241.14626-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'and'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 arch/alpha/kernel/irq_i8259.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/irq_i8259.c b/arch/alpha/kernel/irq_i8259.c
index 1dcf0d9038fd..db574dcd6675 100644
--- a/arch/alpha/kernel/irq_i8259.c
+++ b/arch/alpha/kernel/irq_i8259.c
@@ -147,7 +147,7 @@ isa_no_iack_sc_device_interrupt(unsigned long vector)
 	 */
 	/* 
 	 *  The first read of gives you *all* interrupting lines.
-	 *  Therefore, read the mask register and and out those lines
+	 *  Therefore, read the mask register and out those lines
 	 *  not enabled.  Note that some documentation has 21 and a1 
 	 *  write only.  This is not true.
 	 */
-- 
2.36.1

