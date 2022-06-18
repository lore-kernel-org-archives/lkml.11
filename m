Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF5DC433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jun 2022 17:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234336AbiFRRzc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jun 2022 13:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235666AbiFRRyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 13:54:32 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4750B654B
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 10:54:31 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id e11so6776823pfj.5
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 10:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Pe3uOcmvpu7l074Vg8TkfmLdkHCQjcjrh0SgaSrx6Js=;
        b=HrqU/ZKYoLsSBCKQ4SSI5Onj+HNFQJGCD02a3octwIIrvBjuB/rpQEoYAWImojxKEm
         jBPY9HEHS9xg60PmRir6qQc7KVtM/NchQCTr/xh1KUj+3y/cFY1Y4hi3GybUR4ZCRv8z
         9RlD/w1zugFR2KZZJVGhe+q0icWWTXOYeJirgQ3XfaDRkRg9ptg+A6s6sTMWBKV8jTqm
         QLdeHxnEab98GqbE3vGG/f6ompN8PKElsSAkAdwZqERnuqGNgGxuJlnExS6uIrnqEZqb
         LgN1LUknHMXDlgWhFv64a4q9Fq5X5pdbcPYr92PZ8k7d+EAhrMR8s1uYMV9hTulTAIw6
         fQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pe3uOcmvpu7l074Vg8TkfmLdkHCQjcjrh0SgaSrx6Js=;
        b=QZS+gqrt/SgelpgbcoKZGPMunioL/yiRdPUfa5SpJSEdNFM+Hqfm8/FuSFuSgQqi7U
         y0gKjNEtbp4mbfqWo4dSTomeBl2gN2apmxAODljixqiWcStWjBQKkXWDWXVUmHnR9+OL
         +dbQ8eKWiyD2Kz8hioyfRGd7GU0EuMzU9tDsMzhjXOdeif5Mt7J1E0d72Udm2Tf3P8mn
         MbPpNLYM6CI9zQDNCo/RLQj2TncZI/p35g2cNj2HMt5tRxIyB/7Tw89JyNPQDYI84BlR
         zI7QO699hVhnv82crt7pqq9fEjoqPlynQfeqrjkoptl2n7oNbNE/az/yo3+EseRzvPYy
         jR+g==
X-Gm-Message-State: AJIora+o3VFgqRMle6pHeFULJ46RzRc/rQlcEEO3fBwcx65Y+5/+Ny3t
        rPVsqKemXAUfYkQHlRJrQIY=
X-Google-Smtp-Source: AGRyM1sgV4hLat76J+1ukjvu/MkXdOKY2mfXaVU1UAqQUXgibn7Yp7u6EDVMC+fOoW8rbDYGUrbgjA==
X-Received: by 2002:a63:35c4:0:b0:40c:99f6:8889 with SMTP id c187-20020a6335c4000000b0040c99f68889mr1075338pga.387.1655574870802;
        Sat, 18 Jun 2022 10:54:30 -0700 (PDT)
Received: from thinkpad ([140.121.198.209])
        by smtp.gmail.com with ESMTPSA id z9-20020a1709027e8900b0015e8d4eb209sm5680879pla.83.2022.06.18.10.54.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Jun 2022 10:54:30 -0700 (PDT)
Date:   Sun, 19 Jun 2022 01:54:25 +0800
From:   Huichun Feng <foxhoundsk.tw@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "open list:SCHEDULER" <linux-kernel@vger.kernel.org>,
        jserv@ccns.ncku.edu.tw, Chin-En Lin <shiyn.lin@gmail.com>
Subject: Re: [PATCH v2] sched/fair: avoid redundant hrtimer check
Message-ID: <20220618175425.GE10867@thinkpad>
References: <20220606122612.2580930-1-foxhoundsk.tw@gmail.com>
 <YqHnr8SA2gbf45ok@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqHnr8SA2gbf45ok@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The check is required iff HRTICK is enabled and DOUBLE_TICK is disabled,
don't do that then.

Signed-off-by: Huichun Feng <foxhoundsk.tw@gmail.com>
---

Changes since v1:
- Refine commit message

 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 77b2048a9..80cc1a924 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4668,7 +4668,7 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
        /*
         * don't let the period tick interfere with the hrtick preemption
         */
-       if (!sched_feat(DOUBLE_TICK) &&
+       if (sched_feat(HRTICK) && !sched_feat(DOUBLE_TICK) &&
                        hrtimer_active(&rq_of(cfs_rq)->hrtick_timer))
                return;
 #endif
-- 
2.36.1

