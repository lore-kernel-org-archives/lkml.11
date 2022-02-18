Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8099C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Feb 2022 10:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbiBRKJP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Feb 2022 05:09:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233909AbiBRKJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 05:09:14 -0500
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCD938DBC
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 02:08:57 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V4p-Hvc_1645178930;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0V4p-Hvc_1645178930)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 18 Feb 2022 18:08:54 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH v2] tracing: Fix kernel-doc
Date:   Fri, 18 Feb 2022 18:08:49 +0800
Message-Id: <20220218100849.122038-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following W=1 kernel warnings:

kernel/trace/trace.c:1181: warning: expecting prototype for
tracing_snapshot_cond_data(). Prototype was for
tracing_cond_snapshot_data() instead.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 7c2578efde26..745c5b8a544a 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1164,7 +1164,7 @@ void tracing_snapshot_cond(struct trace_array *tr, void *cond_data)
 EXPORT_SYMBOL_GPL(tracing_snapshot_cond);
 
 /**
- * tracing_snapshot_cond_data - get the user data associated with a snapshot
+ * tracing_cond_snapshot_data - get the user data associated with a snapshot
  * @tr:		The tracing instance
  *
  * When the user enables a conditional snapshot using
-- 
2.20.1.7.g153144c

