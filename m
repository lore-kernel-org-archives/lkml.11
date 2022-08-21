Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE35C32772
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Aug 2022 15:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbiHUP2C (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Aug 2022 11:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHUP1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 11:27:54 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC9D237F0;
        Sun, 21 Aug 2022 08:27:52 -0700 (PDT)
X-QQ-mid: bizesmtp77t1661095668tbosf2un
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 21 Aug 2022 23:27:47 +0800 (CST)
X-QQ-SSF: 01000000002000C0D000B00A0000000
X-QQ-FEAT: izenvNSMpb2fBsYHDX/nyLZY5/oGgQE97zvEleRWpVgXIcxHUDUy/hmhtKpoO
        mgOW26MQmsJWX2Y7uxy0uE022/xQraigHScrR3GS5VxPZOsRxwKZ1U77SNntoWkOVWV+ugJ
        CRk+LIvxJY2lXc3sHHpDlr+1nJBoALndDRMnI1eRzyOFnlwCCp4cF5G4Xz7o66Znt6zVkZe
        0Hq9PL9nGiHwGjdAypKRlc6qqSqi7cUhW8A7txd5YQpHB08h9fSglyUdZPwuJFfBbyzvQtj
        sAzQ4XepZmf6jT/FGFQNmr5c/JUYTgH2PTvOP/Ow7SYzCjNk69qd09sI6fGMIwWccbUcbyl
        iMrY79z57wKGT90mZjqf4L/Sajy8phnWIjAvJR5XoHfrnP5esh1LwEO+FMmsg==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     stern@rowland.harvard.edu
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] usb/host: fix repeated words in comments
Date:   Sun, 21 Aug 2022 23:27:41 +0800
Message-Id: <20220821152741.65462-1-yuanjilin@cdjrlc.com>
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
 drivers/usb/host/ohci-sm501.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/ohci-sm501.c b/drivers/usb/host/ohci-sm501.c
index b91d50da6127..83b1b47ceaf5 100644
--- a/drivers/usb/host/ohci-sm501.c
+++ b/drivers/usb/host/ohci-sm501.c
@@ -154,7 +154,7 @@ static int ohci_hcd_sm501_drv_probe(struct platform_device *pdev)
 	 * using kmalloc() - so the usb core needs to be told that it must copy
 	 * data into our local memory if the buffers happen to be placed in
 	 * regular memory. A non-null hcd->localmem_pool initialized by the
-	 * the call to usb_hcd_setup_local_mem() below does just that.
+	 * call to usb_hcd_setup_local_mem() below does just that.
 	 */
 
 	retval = usb_hcd_setup_local_mem(hcd, mem->start,
-- 
2.36.1

