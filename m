Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0B5C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Apr 2022 20:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239571AbiDXUUr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Apr 2022 16:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbiDXUUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 16:20:46 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC8DAE79
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 13:17:43 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=cruzzhao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VB3be3J_1650831454;
Received: from rt2b04371.sqa.tbc.tbsite.net(mailfrom:CruzZhao@linux.alibaba.com fp:SMTPD_---0VB3be3J_1650831454)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 25 Apr 2022 04:17:41 +0800
From:   Cruz Zhao <CruzZhao@linux.alibaba.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] sched/core: Skip sched_core_fork/free() when core sched is disabled
Date:   Mon, 25 Apr 2022 04:17:34 +0800
Message-Id: <1650831454-101777-1-git-send-email-CruzZhao@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As __put_task_struct() and copy_process() are hot path functions,
the call of sched_core_fork/free() will bring overhead when core
sched is disabled, and we skip them in these cases.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
---
 kernel/sched/core_sched.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
index 38a2cec..72a8ef8 100644
--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -108,13 +108,16 @@ static unsigned long sched_core_clone_cookie(struct task_struct *p)
 
 void sched_core_fork(struct task_struct *p)
 {
-	RB_CLEAR_NODE(&p->core_node);
-	p->core_cookie = sched_core_clone_cookie(current);
+	if (!sched_core_disabled()) {
+		RB_CLEAR_NODE(&p->core_node);
+		p->core_cookie = sched_core_clone_cookie(current);
+	}
 }
 
 void sched_core_free(struct task_struct *p)
 {
-	sched_core_put_cookie(p->core_cookie);
+	if (!sched_core_disabled())
+		sched_core_put_cookie(p->core_cookie);
 }
 
 static void __sched_core_set(struct task_struct *p, unsigned long cookie)
-- 
1.8.3.1

