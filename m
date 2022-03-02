Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C52AC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Mar 2022 18:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244656AbiCBSf4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Mar 2022 13:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244643AbiCBSfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 13:35:48 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 27EC2D887C
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 10:35:04 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA2761515;
        Wed,  2 Mar 2022 10:35:03 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5DAAD3F73D;
        Wed,  2 Mar 2022 10:35:01 -0800 (PST)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@suse.de>, Ben Segall <bsegall@google.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] sched/deadline,rt: Remove unused functions for !CONFIG_SMP
Date:   Wed,  2 Mar 2022 19:34:32 +0100
Message-Id: <20220302183433.333029-6-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220302183433.333029-1-dietmar.eggemann@arm.com>
References: <20220302183433.333029-1-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The need_pull_[rt|dl]_task() and pull_[rt|dl]_task() functions are not
used on a !CONFIG_SMP system. Remove them.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/deadline.c |  9 ---------
 kernel/sched/rt.c       | 11 -----------
 2 files changed, 20 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 3242dd4972e1..93fcef57dd59 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -723,15 +723,6 @@ void dec_dl_migration(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
 {
 }
 
-static inline bool need_pull_dl_task(struct rq *rq, struct task_struct *prev)
-{
-	return false;
-}
-
-static inline void pull_dl_task(struct rq *rq)
-{
-}
-
 static inline void deadline_queue_push_tasks(struct rq *rq)
 {
 }
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 14f273c29518..b62e7652464b 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -271,8 +271,6 @@ int alloc_rt_sched_group(struct task_group *tg, struct task_group *parent)
 
 #ifdef CONFIG_SMP
 
-static void pull_rt_task(struct rq *this_rq);
-
 static inline bool need_pull_rt_task(struct rq *rq, struct task_struct *prev)
 {
 	/* Try to pull RT tasks here if we lower this rq's prio */
@@ -429,15 +427,6 @@ void dec_rt_migration(struct sched_rt_entity *rt_se, struct rt_rq *rt_rq)
 {
 }
 
-static inline bool need_pull_rt_task(struct rq *rq, struct task_struct *prev)
-{
-	return false;
-}
-
-static inline void pull_rt_task(struct rq *this_rq)
-{
-}
-
 static inline void rt_queue_push_tasks(struct rq *rq)
 {
 }
-- 
2.25.1

