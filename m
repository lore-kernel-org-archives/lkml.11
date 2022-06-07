Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE89C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jun 2022 10:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240868AbiFGKSh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 06:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240860AbiFGKSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:18:31 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A94C0469
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 03:18:29 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1654597107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jFci08MJtHyZ2Sg0flpZ8o3EZOlPnMJ39ZuIKk5knAc=;
        b=B/jcmYCNkTz4nvRVIKjaDlbs77Pg6bBCmMLFXAmfIIdDFJUyTsQ9N059I6T98OFhFnynRR
        RnY9rYDprleTYUyJtHlFBYLNfpWjSDweZQvzNvPNHtgFdJVGtt00IQXEfBDuDHDT4BIyo+
        1BmWS0GwsB9xOVL1WiwHiv2F70YBj78=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH v2] sched/deadline: Use proc_douintvec_minmax() limit minimum value
Date:   Tue,  7 Jun 2022 18:18:07 +0800
Message-Id: <20220607101807.249965-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sysctl_sched_dl_period_max and sysctl_sched_dl_period_min are unsigned
integer, but proc_dointvec() wouldn't return error even if we set a
negative number.

Use proc_douintvec_minmax() instead of proc_dointvec(). Add extra1 for
sysctl_sched_dl_period_max and extra2 for sysctl_sched_dl_period_min.

It's just an optimization for match data and proc_handler in struct
ctl_table. The 'if (period < min || period > max)' in __checkparam_dl()
will work fine even if there hasn't this patch.

v2:
 - update the log message.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 kernel/sched/deadline.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index b5152961b743..5867e186c39a 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -30,14 +30,16 @@ static struct ctl_table sched_dl_sysctls[] = {
 		.data           = &sysctl_sched_dl_period_max,
 		.maxlen         = sizeof(unsigned int),
 		.mode           = 0644,
-		.proc_handler   = proc_dointvec,
+		.proc_handler   = proc_douintvec_minmax,
+		.extra1         = (void *)&sysctl_sched_dl_period_min,
 	},
 	{
 		.procname       = "sched_deadline_period_min_us",
 		.data           = &sysctl_sched_dl_period_min,
 		.maxlen         = sizeof(unsigned int),
 		.mode           = 0644,
-		.proc_handler   = proc_dointvec,
+		.proc_handler   = proc_douintvec_minmax,
+		.extra2         = (void *)&sysctl_sched_dl_period_max,
 	},
 	{}
 };
-- 
2.25.1

