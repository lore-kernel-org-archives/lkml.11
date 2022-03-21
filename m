Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5CBC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Mar 2022 03:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344289AbiCUDFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Mar 2022 23:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236347AbiCUDFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 23:05:43 -0400
Received: from mail.meizu.com (edge05.meizu.com [157.122.146.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D188BE11
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 20:04:18 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail12.meizu.com
 (172.16.1.108) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 21 Mar
 2022 11:04:17 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Mon, 21 Mar
 2022 11:04:15 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <dsterba@suse.com>, <elder@linaro.org>,
        <jcmvbkbc@gmail.com>
CC:     <johan@kernel.org>, <linux-kernel@vger.kernel.org>,
        Haowen Bai <baihaowen@meizu.com>
Subject: [PATCH] try: synclink_cs: Use bitwise instead of arithmetic operator for flags
Date:   Mon, 21 Mar 2022 11:04:12 +0800
Message-ID: <1647831852-28973-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This silences the following coccinelle warning:
drivers/s390/char/tape_34xx.c:360:38-39: WARNING: sum of probable bitmasks, consider |

we will try to make code cleaner

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 drivers/char/pcmcia/synclink_cs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
index 78baba5..e6f2186 100644
--- a/drivers/char/pcmcia/synclink_cs.c
+++ b/drivers/char/pcmcia/synclink_cs.c
@@ -922,7 +922,7 @@ static void rx_ready_async(MGSLPC_INFO *info, int tcd)
 		// BIT7:parity error
 		// BIT6:framing error
 
-		if (status & (BIT7 + BIT6)) {
+		if (status & (BIT7 | BIT6)) {
 			if (status & BIT7)
 				icount->parity++;
 			else
-- 
2.7.4

