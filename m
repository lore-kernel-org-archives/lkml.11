Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907E6C43334
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jul 2022 13:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiGPNgt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jul 2022 09:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbiGPNgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 09:36:47 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978621C930;
        Sat, 16 Jul 2022 06:36:40 -0700 (PDT)
X-QQ-mid: bizesmtp69t1657978594tmh7wpjd
Received: from localhost.localdomain ( [182.148.15.157])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 16 Jul 2022 21:36:31 +0800 (CST)
X-QQ-SSF: 01000000002000B0D000B00A0000000
X-QQ-FEAT: LXSsMpCYUN44Zwbh5S9T03HwiGj/SR1xldZRgq2j+ROdaARlN4cyVVCxOxX5D
        vVCwplOnhauXBiX2iqCca7NjrMybyxfiA28jGLOO41yxmw1u+tCyHh8lvVyTmSc0fAUFYYt
        f/vohTQn9iAOgmJcLKkXXmEnnDQhKSwldnzzy1aMEddTnm3OV5haHP76v8TXedJAB8QVU08
        0b9GH17HDhUNZqjIX13uD8MiSnfapNCO/scNwV86T+H0ajYTMW7JaYEemlO6bVNB1GM8/Kd
        UfxBVo0KUiwFs3No0uROhZZ+bRqeyNmCRveIFniIYuOlu1UGwmpgGp3f23eI8mTyUJ0WFM0
        UYpXsZgC3mymThKoC/nJwY+FM408qFmcAsjUsUgujVIVRlZ40fatTY5tDgdiaDn5YCXHgNW
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] usb/host: fix repeated words in comments
Date:   Sat, 16 Jul 2022 21:36:24 +0800
Message-Id: <20220716133624.41994-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'the'.
 Delete the redundant word 'to'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/usb/host/max3421-hcd.c | 2 +-
 drivers/usb/host/uhci-grlib.c  | 2 +-
 drivers/usb/host/uhci-hcd.h    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/max3421-hcd.c b/drivers/usb/host/max3421-hcd.c
index 502a3ac5e35b..352e3ac2b377 100644
--- a/drivers/usb/host/max3421-hcd.c
+++ b/drivers/usb/host/max3421-hcd.c
@@ -312,7 +312,7 @@ static const int hrsl_to_error[] = {
 
 /*
  * See https://www.beyondlogic.org/usbnutshell/usb4.shtml#Control for a
- * reasonable overview of how control transfers use the the IN/OUT
+ * reasonable overview of how control transfers use the IN/OUT
  * tokens.
  */
 #define MAX3421_HXFR_BULK_IN(ep)	(0x00 | (ep))	/* bulk or interrupt */
diff --git a/drivers/usb/host/uhci-grlib.c b/drivers/usb/host/uhci-grlib.c
index 0a201a73b196..3ef6d52839e5 100644
--- a/drivers/usb/host/uhci-grlib.c
+++ b/drivers/usb/host/uhci-grlib.c
@@ -43,7 +43,7 @@ static int uhci_grlib_init(struct usb_hcd *hcd)
 
 	uhci->rh_numports = uhci_count_ports(hcd);
 
-	/* Set up pointers to to generic functions */
+	/* Set up pointers to generic functions */
 	uhci->reset_hc = uhci_generic_reset_hc;
 	uhci->check_and_reset_hc = uhci_generic_check_and_reset_hc;
 	/* No special actions need to be taken for the functions below */
diff --git a/drivers/usb/host/uhci-hcd.h b/drivers/usb/host/uhci-hcd.h
index 8ae5ccd26753..0688c3e5bfe2 100644
--- a/drivers/usb/host/uhci-hcd.h
+++ b/drivers/usb/host/uhci-hcd.h
@@ -314,7 +314,7 @@ struct uhci_td {
  *
  * There's a special skeleton QH for Isochronous QHs which never appears
  * on the schedule.  Isochronous TDs go on the schedule before the
- * the skeleton QHs.  The hardware accesses them directly rather than
+ * skeleton QHs.  The hardware accesses them directly rather than
  * through their QH, which is used only for bookkeeping purposes.
  * While the UHCI spec doesn't forbid the use of QHs for Isochronous,
  * it doesn't use them either.  And the spec says that queues never
-- 
2.36.1

