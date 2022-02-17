Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22E0C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Feb 2022 01:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbiBQB2l (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Feb 2022 20:28:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiBQB2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 20:28:37 -0500
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E655EC2E49
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 17:28:23 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V4fhVwC_1645061300;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V4fhVwC_1645061300)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 17 Feb 2022 09:28:20 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] sched/fair: clean up some inconsistent indenting
Date:   Thu, 17 Feb 2022 09:28:18 +0800
Message-Id: <20220217012818.1177-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the follow smatch warning:
kernel/sched/fair.c:5661 enqueue_task_fair() warn: inconsistent
indenting

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 kernel/sched/fair.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 28b91f11b618..1ff3f45e24f3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5654,12 +5654,12 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		if (cfs_rq_throttled(cfs_rq))
 			goto enqueue_throttle;
 
-               /*
-                * One parent has been throttled and cfs_rq removed from the
-                * list. Add it back to not break the leaf list.
-                */
-               if (throttled_hierarchy(cfs_rq))
-                       list_add_leaf_cfs_rq(cfs_rq);
+		/*
+		 * One parent has been throttled and cfs_rq removed from the
+		 * list. Add it back to not break the leaf list.
+		 */
+		if (throttled_hierarchy(cfs_rq))
+			list_add_leaf_cfs_rq(cfs_rq);
 	}
 
 	/* At this point se is NULL and we are at root level*/
-- 
2.20.1.7.g153144c

