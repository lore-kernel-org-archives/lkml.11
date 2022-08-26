Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF6FECAAA2
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Aug 2022 02:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244713AbiHZCgp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Aug 2022 22:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbiHZCgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 22:36:42 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D09921E35
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 19:36:41 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MDP4N1zc6zYcpM;
        Fri, 26 Aug 2022 10:32:20 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 26 Aug 2022 10:36:39 +0800
Received: from huawei.com (10.175.100.227) by kwepemm600008.china.huawei.com
 (7.193.23.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 26 Aug
 2022 10:36:38 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>
CC:     <shangxiaojing@huawei.com>
Subject: [PATCH -next] sched/deadline: Add compare_task_rq helper
Date:   Fri, 26 Aug 2022 11:11:43 +0800
Message-ID: <20220826031143.9501-1-shangxiaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600008.china.huawei.com (7.193.23.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wrap repeated code in helper function compare_task_rq, which return true
if there is no deadline task on the rq at all, or task's deadline
earlier than the rq.

Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
---
 kernel/sched/deadline.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index d116d2b9d2f9..4a40a462717c 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1810,6 +1810,13 @@ static void yield_task_dl(struct rq *rq)
 
 #ifdef CONFIG_SMP
 
+static inline bool compare_task_rq(struct task_struct *p, struct rq *rq)
+{
+	return (!rq->dl.dl_nr_running ||
+		dl_time_before(p->dl.deadline,
+			       rq->dl.earliest_dl.curr));
+}
+
 static int find_later_rq(struct task_struct *task);
 
 static int
@@ -1852,9 +1859,7 @@ select_task_rq_dl(struct task_struct *p, int cpu, int flags)
 		int target = find_later_rq(p);
 
 		if (target != -1 &&
-				(dl_time_before(p->dl.deadline,
-					cpu_rq(target)->dl.earliest_dl.curr) ||
-				(cpu_rq(target)->dl.dl_nr_running == 0)))
+		    compare_task_rq(p, cpu_rq(target)))
 			cpu = target;
 	}
 	rcu_read_unlock();
@@ -2221,9 +2226,7 @@ static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
 
 		later_rq = cpu_rq(cpu);
 
-		if (later_rq->dl.dl_nr_running &&
-		    !dl_time_before(task->dl.deadline,
-					later_rq->dl.earliest_dl.curr)) {
+		if (!compare_task_rq(task, later_rq)) {
 			/*
 			 * Target rq has tasks of equal or earlier deadline,
 			 * retrying does not release any lock and is unlikely
@@ -2251,9 +2254,7 @@ static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
 		 * its earliest one has a later deadline than our
 		 * task, the rq is a good one.
 		 */
-		if (!later_rq->dl.dl_nr_running ||
-		    dl_time_before(task->dl.deadline,
-				   later_rq->dl.earliest_dl.curr))
+		if (compare_task_rq(task, later_rq))
 			break;
 
 		/* Otherwise we try again. */
@@ -2424,9 +2425,7 @@ static void pull_dl_task(struct rq *this_rq)
 		 *  - it will preempt the last one we pulled (if any).
 		 */
 		if (p && dl_time_before(p->dl.deadline, dmin) &&
-		    (!this_rq->dl.dl_nr_running ||
-		     dl_time_before(p->dl.deadline,
-				    this_rq->dl.earliest_dl.curr))) {
+		    compare_task_rq(p, this_rq)) {
 			WARN_ON(p == src_rq->curr);
 			WARN_ON(!task_on_rq_queued(p));
 
-- 
2.17.1

