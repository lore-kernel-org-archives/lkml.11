Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BA0C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Apr 2022 05:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244998AbiDAFMV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Apr 2022 01:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiDAFMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 01:12:18 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44BE1E747A
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 22:10:29 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=liuhailong@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0V8ok3FV_1648789812;
Received: from VM20210331-77.tbsite.net(mailfrom:liuhailong@linux.alibaba.com fp:SMTPD_---0V8ok3FV_1648789812)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 01 Apr 2022 13:10:26 +0800
From:   Hailong Liu <liuhailong@linux.alibaba.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        aniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org,
        Hailong Liu <liuhailong@linux.alibaba.com>
Subject: [PATCH] psi: Fix trigger being fired unexpectedly at initial
Date:   Fri,  1 Apr 2022 13:10:11 +0800
Message-Id: <1648789811-3788971-1-git-send-email-liuhailong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a trigger being created, its win.start_value and win.start_time are
reset to zero. If group->total[PSI_POLL][t->state] has accumulated before,
this trigger will be fired unexpectedly in the next period, even if its
growth time does not reach its threshold.

So set the window of the new trigger to the current state value.

Signed-off-by: Hailong Liu <liuhailong@linux.alibaba.com>
---
 kernel/sched/psi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index a4fa3aadfcba..5a49a8c8783e 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1117,7 +1117,8 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
 	t->state = state;
 	t->threshold = threshold_us * NSEC_PER_USEC;
 	t->win.size = window_us * NSEC_PER_USEC;
-	window_reset(&t->win, 0, 0, 0);
+	window_reset(&t->win, sched_clock(),
+			group->total[PSI_POLL][t->state], 0);
 
 	t->event = 0;
 	t->last_event_time = 0;
-- 
2.19.1.6.gb485710b

