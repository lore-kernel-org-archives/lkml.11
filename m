Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75068C00140
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Aug 2022 10:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiHJK0K (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Aug 2022 06:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiHJK0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 06:26:05 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294D86050C;
        Wed, 10 Aug 2022 03:26:01 -0700 (PDT)
X-QQ-mid: bizesmtp68t1660127147tk3bw6im
Received: from localhost.localdomain ( [182.148.14.53])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 10 Aug 2022 18:25:15 +0800 (CST)
X-QQ-SSF: 0100000000200050B000B00A0000000
X-QQ-FEAT: mRz6/7wsmIjzTloIOHYx8wzCQj1h3Tt9noArdYnPKBrB1qVd4d4Bp0WrQig4j
        +Ysli/iTaLyviSVhxRQRtIoEqutBNRlq0kcwwkDyQJc4cFzL/oDzMqfxnRcmgN/JDRPR0i3
        riEMsdqliLzs4s0R2K0laf5yaylsxWzT1ESn3jylwxsbqirw+JrfWuxM+fwcQJc0TrN2ja6
        u4UTTzT/wrQ7J6JKFI0/FQcaqBxvPJLQmN8Z3OrKBsFBcaUs/y33RA0LD4++5tuZ2szU1VY
        iy1DHp2Bh1zFCLXadzXe8VMhTvfaVFvrWFadJ/mQYhZu7o53XcvuqDksFUzK22LISUWA1XY
        itTnlMXCuNie7DGSBp+jPTkkTJWi+rD76ZOFbYWNQKonj5i1JU=
X-QQ-GoodBg: 0
From:   shaomin Deng <dengshaomin@cdjrlc.com>
To:     b-liu@ti.com
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] usb: musb: tusb6010: Remove repeated word in comments
Date:   Wed, 10 Aug 2022 06:25:14 -0400
Message-Id: <20220810102514.7292-1-dengshaomin@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the repeated word "mode" in tusb6010.c.

Signed-off-by: shaomin Deng <dengshaomin@cdjrlc.com>
---
 drivers/usb/musb/tusb6010.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
index 7ed4cc348d99..5609b4e84d40 100644
--- a/drivers/usb/musb/tusb6010.c
+++ b/drivers/usb/musb/tusb6010.c
@@ -495,7 +495,7 @@ static void musb_do_idle(struct timer_list *t)
 }
 
 /*
- * Maybe put TUSB6010 into idle mode mode depending on USB link status,
+ * Maybe put TUSB6010 into idle mode depending on USB link status,
  * like "disconnected" or "suspended".  We'll be woken out of it by
  * connect, resume, or disconnect.
  *
-- 
2.35.1

