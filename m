Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF4FC32772
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Aug 2022 15:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbiHUPfP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Aug 2022 11:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiHUPfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 11:35:12 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7035A188;
        Sun, 21 Aug 2022 08:35:10 -0700 (PDT)
X-QQ-mid: bizesmtp90t1661096098t4jd9sr8
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 21 Aug 2022 23:34:57 +0800 (CST)
X-QQ-SSF: 01000000002000C0D000B00A0000000
X-QQ-FEAT: cIAm9Ti9Z0yZJe7QcNpkLcgBz24pDhmuXbRFaFH5TArxrHTiFUs38fw+uZCQE
        RcDScZ6Y2aRRJ1BLslL2IV7nYBZby9mDrTEaSPHrUBMWqD1RaLhDmivR+bNSCnnwITTlYVi
        if+wAVHHpKkzSexMGmwWQQHpQyphJpc+ddBxUQjwXmBra4q4yXpT9QQbE7Oa/M0o0KIFYND
        hk2F4GXYWeHUrIDxy3k/yD8qHdZvIytLERTUI1+TKA1c9JUpGkOOvGk71OjWkgG1srUsvPd
        I8VXWCuKebwgmHMKvvKptFIwK3fhRls1Dv/lDjL4FdLj3hXin+2rkz9l7ZuYddtcQ9GbSt2
        wP8oQphiwMBoCbwdWQQF3jARgl5q/6KnKU/tXqNE594LM8kTfCyJHdEyzV+RWNmZN0CkJXC
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] usb/serial: fix repeated words in comments
Date:   Sun, 21 Aug 2022 23:34:41 +0800
Message-Id: <20220821153441.6165-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'more'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/usb/serial/mct_u232.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/serial/mct_u232.h b/drivers/usb/serial/mct_u232.h
index e3d09a83cab1..f79a1f1b6a98 100644
--- a/drivers/usb/serial/mct_u232.h
+++ b/drivers/usb/serial/mct_u232.h
@@ -273,13 +273,13 @@ static int mct_u232_calculate_baud_rate(struct usb_serial *serial,
  *  Bit 5: Data Set Ready (DSR). Reflects the state of the DSR line on the UART.
  *  Bit 4: Clear To Send (CTS). Reflects the state of the CTS line on the UART.
  *  Bit 3: Delta Data Carrier Detect (DDCD). Set to "1" if the -DCD line has
- *	   changed state one more more times since the last time the MSR was
+ *	   changed state one more times since the last time the MSR was
  *	   read by the host.
  *  Bit 2: Trailing Edge Ring Indicator (TERI). Set to "1" if the -RI line has
  *	   had a low to high transition since the last time the MSR was read by
  *	   the host.
  *  Bit 1: Delta Data Set Ready (DDSR). Set to "1" if the -DSR line has changed
- *	   state one more more times since the last time the MSR was read by the
+ *	   state one more times since the last time the MSR was read by the
  *	   host.
  *  Bit 0: Delta Clear To Send (DCTS). Set to "1" if the -CTS line has changed
  *	   state one more times since the last time the MSR was read by the
-- 
2.36.1

