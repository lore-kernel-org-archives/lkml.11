Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D59FC433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Apr 2022 17:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359730AbiDCSB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Apr 2022 14:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239569AbiDCSB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 14:01:27 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D1C12751
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 10:59:31 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1649008769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ALNqJsH4yAiUEiLVkeA1F4OJa4cTSsJo9XYSut55pQA=;
        b=duWJ8QWhoNvoCTWhJ+bCDxbe4yEKfPnWYXBOuAZMQ0hBB0l6xciMihzjZ3EPfpeSAUM3Tq
        7OffKyANWnkBMKSuq+8d72/brbjHnmWkvz8CcAS/T7t9hfkSudioLFxJt+uXz3dN72X8Y3
        rKLtXMm7en2iHj9hFdC7vqj4/gOZi6s=
From:   Tao Zhou <tao.zhou@linux.dev>
To:     linux-kernel@vger.kernel.org, tao.zhou@linux.dev
Subject: [PATCH] sched/fair: Revise comment about lb decision matrix
Date:   Mon,  4 Apr 2022 01:59:46 +0800
Message-Id: <20220403175946.7323-1-tao.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If busiest group type is group_misfit_task, the local
group type must be group_has_spare according to below
code in update_sd_pick_busiest():

if (sgs->group_type == group_misfit_task &&
    (!capacity_greater(capacity_of(env->dst_cpu), sg->sgc->max_capacity) ||
     sds->local_stat.group_type != group_has_spare))
         return false;

group type imbalanced and overloaded and fully_busy are filtered in here.
misfit and asym are filtered before in update_sg_lb_stats().
So, change the decision matrix to:

busiest \ local has_spare fully_busy misfit asym imbalanced overloaded
has_spare        nr_idle   balanced   N/A    N/A  balanced   balanced
fully_busy       nr_idle   nr_idle    N/A    N/A  balanced   balanced
misfit_task      force     N/A        N/A    N/A  *N/A*      *N/A*
asym_packing     force     force      N/A    N/A  force      force
imbalanced       force     force      N/A    N/A  force      force
overloaded       force     force      N/A    N/A  force      avg_load
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5146163bfabb..5765d96202c7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9441,7 +9441,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
  * busiest \ local has_spare fully_busy misfit asym imbalanced overloaded
  * has_spare        nr_idle   balanced   N/A    N/A  balanced   balanced
  * fully_busy       nr_idle   nr_idle    N/A    N/A  balanced   balanced
- * misfit_task      force     N/A        N/A    N/A  force      force
+ * misfit_task      force     N/A        N/A    N/A  N/A        N/A
  * asym_packing     force     force      N/A    N/A  force      force
  * imbalanced       force     force      N/A    N/A  force      force
  * overloaded       force     force      N/A    N/A  force      avg_load
-- 
2.35.1

