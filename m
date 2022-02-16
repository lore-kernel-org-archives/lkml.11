Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F8DC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Feb 2022 03:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344209AbiBPDUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Feb 2022 22:20:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233625AbiBPDUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 22:20:18 -0500
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F323EF65CD;
        Tue, 15 Feb 2022 19:20:06 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0V4bIn47_1644981598;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0V4bIn47_1644981598)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Feb 2022 11:20:02 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     pmladek@suse.com
Cc:     senozhatsky@chromium.org, rostedt@goodmis.org,
        john.ogness@linutronix.de, keescook@chromium.org, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com, ojeda@kernel.org,
        alex.gaynor@gmail.com, wedsonaf@google.com,
        linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] printk: make suppress_panic_printk static
Date:   Wed, 16 Feb 2022 11:19:57 +0800
Message-Id: <20220216031957.9761-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This symbol is not used outside of printk.c, so marks it static.

Fix the following sparse warning:

kernel/printk/printk.c:100:19: warning: symbol 'suppress_panic_printk'
was not declared. Should it be static?

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 kernel/printk/printk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 7a9eace19191..703397cadd01 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -97,7 +97,7 @@ int __read_mostly suppress_printk;
  * During panic, heavy printk by other CPUs can delay the
  * panic and risk deadlock on console resources.
  */
-int __read_mostly suppress_panic_printk;
+static int __read_mostly suppress_panic_printk;
 
 #ifdef CONFIG_LOCKDEP
 static struct lockdep_map console_lock_dep_map = {
-- 
2.20.1.7.g153144c

