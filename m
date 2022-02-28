Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6688BC433FE
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Feb 2022 22:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbiB1WHF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Feb 2022 17:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbiB1WGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 17:06:54 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE1514D250
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 14:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=IgfKU7Y6HE0LYQc5kZ/CUBUALv9KufTVhYOQSQQR0WQ=; b=qUpk7SO9uYS0ZcwEIpvIgut4Tp
        opG2ifO8FG1d7ervCeSnRJelu1Fxh3Lk5a3Lpo6UJ/kkaB7vpSvq+rzyMIsS/r7OD13xCA/5TGWPO
        H2KCqx952FMs4JwqheYv2uKlF3HmxSfZ12R4SqaOuAWmSRmHxLB+Lg4RYWn8/dq+mRBnHRLZaJp7Z
        xGQMjobKHjXWAxIxqtfylpQ2sapOOuZ/eWCAp+OhT1RtUeKExlgrFl+1X8G3MYi40pEWelnXunbsU
        9kb+aN3YNV27WUn1VYkxhE2xrA9rTRAhfbh2PatxLTJR9MK9WuXgBps9d+sJxEEex+I1Earw+4/AV
        Qhg7vAQw==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nOo9V-00EGCs-33; Mon, 28 Feb 2022 22:05:57 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Igor Zhbanov <i.zhbanov@omprussia.ru>,
        Borislav Petkov <bp@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: [PATCH] printk: fix return value of printk.devkmsg __setup handler
Date:   Mon, 28 Feb 2022 14:05:56 -0800
Message-Id: <20220228220556.23484-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an invalid option value is used with "printk.devkmsg=<value>",
it is silently ignored.
If a valid option value is used, it is honored but the wrong return
value (0) is used, indicating that the command line option had an
error and was not handled. This string is not added to init's
environment strings due to init/main.c::unknown_bootoption()
checking for a '.' in the boot option string and then considering
that string to be an "Unused module parameter".

Print a warning message if a bad option string is used.
Always return 1 from the __setup handler to indicate that the command
line option has been handled.

Fixes: 750afe7babd1 ("printk: add kernel parameter to control writes to /dev/kmsg")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: Igor Zhbanov <i.zhbanov@omprussia.ru>
Link: lore.kernel.org/r/64644a2f-4a20-bab3-1e15-3b2cdd0defe3@omprussia.ru
Cc: Borislav Petkov <bp@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- linux-next-20220228.orig/kernel/printk/printk.c
+++ linux-next-20220228/kernel/printk/printk.c
@@ -152,8 +152,10 @@ static int __control_devkmsg(char *str)
 
 static int __init control_devkmsg(char *str)
 {
-	if (__control_devkmsg(str) < 0)
+	if (__control_devkmsg(str) < 0) {
+		pr_warn("printk.devkmsg: bad option string '%s'\n", str);
 		return 1;
+	}
 
 	/*
 	 * Set sysctl string accordingly:
@@ -172,7 +174,7 @@ static int __init control_devkmsg(char *
 	 */
 	devkmsg_log |= DEVKMSG_LOG_MASK_LOCK;
 
-	return 0;
+	return 1;
 }
 __setup("printk.devkmsg=", control_devkmsg);
 
