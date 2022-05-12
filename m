Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADEB5C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 May 2022 07:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350837AbiELHSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 May 2022 03:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350835AbiELHSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:18:12 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9459EAAE0E
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 00:18:08 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VCzinF7_1652339876;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VCzinF7_1652339876)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 12 May 2022 15:18:05 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] sched/fair: clean up some inconsistent indenting
Date:   Thu, 12 May 2022 15:17:54 +0800
Message-Id: <20220512071754.117707-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the follow smatch warning:

kernel/sched/fair.c:5725 enqueue_task_fair() warn: inconsistent
indenting.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 kernel/sched/fair.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a2b3eb0ec6dc..27dbafc5246b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5718,12 +5718,12 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
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

