Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE54C04A68
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jul 2022 15:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbiG0PgO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jul 2022 11:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiG0PgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 11:36:12 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 75635237D9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 08:36:11 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 8C6CD1E80D54;
        Wed, 27 Jul 2022 23:36:18 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3y15_qWQBiFQ; Wed, 27 Jul 2022 23:36:16 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: liqiong@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 698451E80D05;
        Wed, 27 Jul 2022 23:36:15 +0800 (CST)
From:   Li Qiong <liqiong@nfschina.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, yuzhe@nfschina.com,
        renyu@nfschina.com, jiaming@nfschina.com,
        Li Qiong <liqiong@nfschina.com>
Subject: [PATCH] tracing: Do PTR_ERR() after IS_ERR()
Date:   Wed, 27 Jul 2022 23:35:19 +0800
Message-Id: <20220727153519.6697-1-liqiong@nfschina.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check IS_ERR() firstly, then do PTR_ERR().

Signed-off-by: Li Qiong <liqiong@nfschina.com>
---
 kernel/trace/ring_buffer_benchmark.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ring_buffer_benchmark.c b/kernel/trace/ring_buffer_benchmark.c
index 78e576575b79..a8f6b0725c45 100644
--- a/kernel/trace/ring_buffer_benchmark.c
+++ b/kernel/trace/ring_buffer_benchmark.c
@@ -439,17 +439,19 @@ static int __init ring_buffer_benchmark_init(void)
 	if (!disable_reader) {
 		consumer = kthread_create(ring_buffer_consumer_thread,
 					  NULL, "rb_consumer");
-		ret = PTR_ERR(consumer);
-		if (IS_ERR(consumer))
+		if (IS_ERR(consumer)) {
+			ret = PTR_ERR(consumer);
 			goto out_fail;
+		}
 	}
 
 	producer = kthread_run(ring_buffer_producer_thread,
 			       NULL, "rb_producer");
-	ret = PTR_ERR(producer);
 
-	if (IS_ERR(producer))
+	if (IS_ERR(producer)) {
+		ret = PTR_ERR(producer);
 		goto out_kill;
+	}
 
 	/*
 	 * Run them as low-prio background tasks by default:
-- 
2.11.0

