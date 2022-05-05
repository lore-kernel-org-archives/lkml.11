Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D0CC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 May 2022 02:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240188AbiEEDAI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 May 2022 23:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiEEDAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 23:00:03 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D818B13DC8
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 19:56:24 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Ktyxs1qsSzhYwq;
        Thu,  5 May 2022 10:56:01 +0800 (CST)
Received: from localhost.localdomain (10.157.217.52) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 5 May 2022 10:56:22 +0800
From:   Tao Lan <taolan@huawei.com>
To:     <pmladek@suse.com>, <senozhatsky@chromium.org>,
        <rostedt@goodmis.org>, <john.ogness@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <taolan@huawei.com>
Subject: [PATCH v2] =?UTF-8?q?printk:=20fix=20kernel=20msg=20leakage=20in=20s?= =?UTF-8?q?yslog=5Fprint=5Fall=20function=EF=BC=9B?=
Date:   Thu, 5 May 2022 02:52:10 +0000
Message-ID: <20220505025210.32249-1-taolan@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.157.217.52]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function applies for memory but does not initialize the memory,and
then invokes copy_to_user to copy the memory to the user space, which
causes kernel information leaks.

[ 148.439660] kernel memory leak value 0xffffff80aed972bc at
0xffffffd37f00a000 to 0x704b883e74

Signed-off-by: Tao Lan <taolan@huawei.com>
---
v2: to change to my correct name.
 kernel/printk/printk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index da03c15ecc89..22d7d821909d 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1591,7 +1591,7 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 	u64 seq;
 	bool time;
 
-	text = kmalloc(CONSOLE_LOG_MAX, GFP_KERNEL);
+	text = kzalloc(CONSOLE_LOG_MAX, GFP_KERNEL);
 	if (!text)
 		return -ENOMEM;
 
-- 
2.18.0.huawei.25

