Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2CEC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Mar 2022 13:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237131AbiC2NIY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Mar 2022 09:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237122AbiC2NIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 09:08:18 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE2A9EE4EE
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 06:06:34 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.2.5.185])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9BxsM42BENiSf0RAA--.45474S2;
        Tue, 29 Mar 2022 21:06:08 +0800 (CST)
From:   Jianxing Wang <wangjianxing@loongson.cn>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Jianxing Wang <wangjianxing@loongson.cn>,
        Mike Galbraith <bitbucket@online.de>
Subject: [PATCH 1/1] sched/headers: remove double_lock function
Date:   Tue, 29 Mar 2022 21:05:38 +0800
Message-Id: <20220329130539.568762-1-wangjianxing@loongson.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9BxsM42BENiSf0RAA--.45474S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZF4rKrWfuw4kuF18WryfWFg_yoWkXrg_W3
        W5GF1vkF4UJw4F9342gw45WF4rta10qa48Cr97Ka1DJa45JFZYyanxGF43ArnxZFsrCasr
        C3sFqFyvkF1kCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUUUUUUU
X-CM-SenderInfo: pzdqwyxldq5xtqj6z05rqj20fqof0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 8c8a743c5087b ("sched/numa: Use {cpu, pid} to create task groups
for shared faults") import double_lock but
commit 60e69eed85bb ("sched/numa: Fix task_numa_free() lockdep splat")
replace it with double_lock_irq, now nobody care it, just remove it.

Cc: Mike Galbraith <bitbucket@online.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Jianxing Wang <wangjianxing@loongson.cn>
---
 kernel/sched/sched.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 58263f90c559..f8ca414177bd 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2586,15 +2586,6 @@ static inline void double_unlock_balance(struct rq *this_rq, struct rq *busiest)
 	lock_set_subclass(&__rq_lockp(this_rq)->dep_map, 0, _RET_IP_);
 }
 
-static inline void double_lock(spinlock_t *l1, spinlock_t *l2)
-{
-	if (l1 > l2)
-		swap(l1, l2);
-
-	spin_lock(l1);
-	spin_lock_nested(l2, SINGLE_DEPTH_NESTING);
-}
-
 static inline void double_lock_irq(spinlock_t *l1, spinlock_t *l2)
 {
 	if (l1 > l2)
-- 
2.31.1

