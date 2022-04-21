Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B200C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Apr 2022 21:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442035AbiDUVZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Apr 2022 17:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441963AbiDUVZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 17:25:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1FE4EA30
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 14:22:56 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650576175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WojArbM9OzLNiontaIQZoMbzC5aP6fR9aoNVu9FnfGE=;
        b=RUlaokhX/Uqkot+UW5Ff8BcRcxwsCuF3pqhtQpiK6zjrXx0i3PjihPELhielxmNhIvQkoS
        rMAmSw7dnytf1O1Zf76xN3IkC2rAXmLxKao5zyoAzGTWXF8eTvj5GzLba9lr17hO+3LQnY
        J1VrXmmU6HWdVe32+dEmqQfl0jy/O2DQ8kH4o99COt92rQDye924ps/oujnYrulE1IZNyS
        /8gnVahdxRJjsy7ne0eZPG0ywS/dkLb4zOOka52uOCgQQlvgSgDnFf+vouQIy0YOTCZMiY
        6FR1WrRyCcCltydE3qTGLn4FaYzRtmADAP9msMDTFQka4TfKnWxHdp71KI9ERQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650576175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WojArbM9OzLNiontaIQZoMbzC5aP6fR9aoNVu9FnfGE=;
        b=LBEcDFUIhKaigyJhTn1HXk1BOseecwFfows4+h/iXuHrfRuniH2fC2TDDETPgVRb3B64Sl
        yaBPd+BBKsK68DCQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v4 07/15] printk: call boot_delay_msec() in printk_delay()
Date:   Thu, 21 Apr 2022 23:28:42 +0206
Message-Id: <20220421212250.565456-8-john.ogness@linutronix.de>
In-Reply-To: <20220421212250.565456-1-john.ogness@linutronix.de>
References: <20220421212250.565456-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

boot_delay_msec() is always called immediately before printk_delay()
so just call it from within printk_delay().

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 82ad3d3d0d4a..2f99e0b383b9 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2048,8 +2048,10 @@ static u8 *__printk_recursion_counter(void)
 
 int printk_delay_msec __read_mostly;
 
-static inline void printk_delay(void)
+static inline void printk_delay(int level)
 {
+	boot_delay_msec(level);
+
 	if (unlikely(printk_delay_msec)) {
 		int m = printk_delay_msec;
 
@@ -2274,8 +2276,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 		in_sched = true;
 	}
 
-	boot_delay_msec(level);
-	printk_delay();
+	printk_delay(level);
 
 	printed_len = vprintk_store(facility, level, dev_info, fmt, args);
 
-- 
2.30.2

