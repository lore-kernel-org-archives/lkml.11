Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2010CC433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Mar 2022 23:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343931AbiCGXbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Mar 2022 18:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343920AbiCGXbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 18:31:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CEAD88
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 15:30:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD017B8174B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 23:30:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46705C340F3;
        Mon,  7 Mar 2022 23:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646695846;
        bh=nN8KeMyaNCF4PtBAXxi6MOQhA1/rey5kYpWAZLjTD/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ed+Wqy1ezWhsg2PZiASlygw4Xz6ohnIPmw+BU/3Ot711LZ2nIVHzURSZfO4zJUFHq
         wQnFe4rr7AsPBIiwOjIff0zFzrhDb0Z+q/O5S+KmtSYn4onO3lJ9ks3c9Kaimt6eSq
         TMzHLDedrNkaMhvFO9RzR4SdjEdTIdbbzqwNU1SAXKHFXtjuGOUbbM+h2Ee322ekoC
         z/VmudX8fptNVbiloqYCjslxFjVWZ6gBoWiwCC8pXY+WCCa0l6tMGbGvWDt1P3b9MM
         DI/x4iZmvqNACRIbisIPLTNUPce72LSwWNBnD2rpTLzLkiy2O16gaw4nAzDvskcKXb
         WndwLx6Is9uBg==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH 2/4] tick/rcu: Remove obsolete rcu_needs_cpu() parameters
Date:   Tue,  8 Mar 2022 00:30:32 +0100
Message-Id: <20220307233034.34550-3-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307233034.34550-1-frederic@kernel.org>
References: <20220307233034.34550-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the removal of CONFIG_RCU_FAST_NO_HZ, the parameters in
rcu_needs_cpu() are not necessary anymore. Simply remove them.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>
---
 include/linux/rcutiny.h  |  3 +--
 include/linux/rcutree.h  |  2 +-
 kernel/rcu/tree.c        |  3 +--
 kernel/time/tick-sched.c | 10 ++++------
 4 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 858f4d429946..5fed476f977f 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -64,9 +64,8 @@ static inline void rcu_softirq_qs(void)
 		rcu_tasks_qs(current, (preempt)); \
 	} while (0)
 
-static inline int rcu_needs_cpu(u64 basemono, u64 *nextevt)
+static inline int rcu_needs_cpu(void)
 {
-	*nextevt = KTIME_MAX;
 	return 0;
 }
 
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 53209d669400..6cc91291d078 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -19,7 +19,7 @@
 
 void rcu_softirq_qs(void);
 void rcu_note_context_switch(bool preempt);
-int rcu_needs_cpu(u64 basem, u64 *nextevt);
+int rcu_needs_cpu(void);
 void rcu_cpu_stall_reset(void);
 
 /*
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a4c25a6283b0..80faf2273ce9 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1086,9 +1086,8 @@ void rcu_irq_enter_irqson(void)
  * Just check whether or not this CPU has non-offloaded RCU callbacks
  * queued.
  */
-int rcu_needs_cpu(u64 basemono, u64 *nextevt)
+int rcu_needs_cpu(void)
 {
-	*nextevt = KTIME_MAX;
 	return !rcu_segcblist_empty(&this_cpu_ptr(&rcu_data)->cblist) &&
 		!rcu_rdp_is_offloaded(this_cpu_ptr(&rcu_data));
 }
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index c89f50a7e690..566ad5bd83e9 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -785,7 +785,7 @@ static inline bool local_timer_softirq_pending(void)
 
 static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
 {
-	u64 basemono, next_tick, next_tmr, next_rcu, delta, expires;
+	u64 basemono, next_tick, delta, expires;
 	unsigned long basejiff;
 	unsigned int seq;
 
@@ -808,7 +808,7 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
 	 * minimal delta which brings us back to this place
 	 * immediately. Lather, rinse and repeat...
 	 */
-	if (rcu_needs_cpu(basemono, &next_rcu) || arch_needs_cpu() ||
+	if (rcu_needs_cpu() || arch_needs_cpu() ||
 	    irq_work_needs_cpu() || local_timer_softirq_pending()) {
 		next_tick = basemono + TICK_NSEC;
 	} else {
@@ -819,10 +819,8 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
 		 * disabled this also looks at the next expiring
 		 * hrtimer.
 		 */
-		next_tmr = get_next_timer_interrupt(basejiff, basemono);
-		ts->next_timer = next_tmr;
-		/* Take the next rcu event into account */
-		next_tick = next_rcu < next_tmr ? next_rcu : next_tmr;
+		next_tick = get_next_timer_interrupt(basejiff, basemono);
+		ts->next_timer = next_tick;
 	}
 
 	/*
-- 
2.25.1

