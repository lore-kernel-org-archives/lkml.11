Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9F4C19F2A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Aug 2022 02:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242987AbiHHCm1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Aug 2022 22:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241978AbiHHClk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 22:41:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C4821B9
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 19:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=lfQTXZiY1X35koMGsi465Yl9F2fwXfjrVq4gI2j3bhc=; b=mBXOn5/7/Ubjyu4VKJpvGkaoV/
        uX179iuL1fclHsc+EFKeSlPqJ2ay/ncaHC08hxoBl/nEou6mAsT5+7pg5joTfv6kgNFQnHvZO5OV8
        VVUJUrndxAfgMASgNOBK98cwxalRqWZeUeaPbl6C8VpuSZMnJBtqZuixTgRGqiLbbCcF2HJVARzmk
        m871dvFmhZ0zByM/ZNaCDN9aPVtPqWq/qS1GIMfy0bBuZ7e9pMU4wGFbrW0cP8596hOqlSnfV9Thl
        7Q42W3dOY/46Hrrd8p8F3cJqcBmjuoCcRmAcSvmbpReOMKSCseS3klf6NZ8apH0BIxkyVpbVGPgfN
        d1ZDoavA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oKshy-00DVS6-9v; Mon, 08 Aug 2022 02:41:34 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org, pmladek@suse.com,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v5 21/32] Input/joystick/analog: Convert from seq_buf -> printbuf
Date:   Mon,  8 Aug 2022 03:41:17 +0100
Message-Id: <20220808024128.3219082-22-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808024128.3219082-1-willy@infradead.org>
References: <20220808024128.3219082-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kent Overstreet <kent.overstreet@gmail.com>

seq_buf is being deprecated, this converts to printbuf.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/analog.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/input/joystick/analog.c b/drivers/input/joystick/analog.c
index 3088c5b829f0..a8c5f90e8208 100644
--- a/drivers/input/joystick/analog.c
+++ b/drivers/input/joystick/analog.c
@@ -19,7 +19,7 @@
 #include <linux/input.h>
 #include <linux/gameport.h>
 #include <linux/jiffies.h>
-#include <linux/seq_buf.h>
+#include <linux/printbuf.h>
 #include <linux/timex.h>
 #include <linux/timekeeping.h>
 
@@ -339,24 +339,21 @@ static void analog_calibrate_timer(struct analog_port *port)
 
 static void analog_name(struct analog *analog)
 {
-	struct seq_buf s;
+	struct printbuf buf = PRINTBUF_EXTERN(analog->name, sizeof(analog->name));
 
-	seq_buf_init(&s, analog->name, sizeof(analog->name));
-	seq_buf_printf(&s, "Analog %d-axis %d-button",
-		 hweight8(analog->mask & ANALOG_AXES_STD),
-		 hweight8(analog->mask & ANALOG_BTNS_STD) + !!(analog->mask & ANALOG_BTNS_CHF) * 2 +
-		 hweight16(analog->mask & ANALOG_BTNS_GAMEPAD) + !!(analog->mask & ANALOG_HBTN_CHF) * 4);
+	prt_printf(&buf, "Analog %d-axis %d-button",
+	       hweight8(analog->mask & ANALOG_AXES_STD),
+	       hweight8(analog->mask & ANALOG_BTNS_STD) + !!(analog->mask & ANALOG_BTNS_CHF) * 2 +
+	       hweight16(analog->mask & ANALOG_BTNS_GAMEPAD) + !!(analog->mask & ANALOG_HBTN_CHF) * 4);
 
 	if (analog->mask & ANALOG_HATS_ALL)
-		seq_buf_printf(&s, " %d-hat",
-			       hweight16(analog->mask & ANALOG_HATS_ALL));
-
+		prt_printf(&buf, " %d-hat", hweight16(analog->mask & ANALOG_HATS_ALL));
 	if (analog->mask & ANALOG_HAT_FCS)
-		seq_buf_printf(&s, " FCS");
+		prt_printf(&buf, " FCS");
 	if (analog->mask & ANALOG_ANY_CHF)
-		seq_buf_printf(&s, (analog->mask & ANALOG_SAITEK) ? " Saitek" : " CHF");
+		prt_printf(&buf, (analog->mask & ANALOG_SAITEK) ? " Saitek" : " CHF");
 
-	seq_buf_printf(&s, (analog->mask & ANALOG_GAMEPAD) ? " gamepad" : " joystick");
+	prt_printf(&buf, (analog->mask & ANALOG_GAMEPAD) ? " gamepad" : " joystick");
 }
 
 /*
-- 
2.35.1

