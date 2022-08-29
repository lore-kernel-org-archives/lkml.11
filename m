Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E188ECAAD4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Aug 2022 10:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiH2KPY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Aug 2022 06:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiH2KO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 06:14:59 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464037653
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 03:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=RrsRwnufM8aJb8X9Do0ueNVFWhI9Rg8k/jxvL6pTy3A=; b=E8SAi3JaFuSLK93DPkIu0UKrrI
        OFKSUTh1qSx0V9zZokCjaJTstYrM1wcSGcFFsd46hYScOpU0vb7OLEDpEFMCLmBdWnte+NhLwtR6P
        OXgglvsJ3ikzLmAUNJpVWbkt0qC0wr2pXsAvBSArlJoAgP4+gYGG46FMNgv804GUjK6QbIkxqtS9b
        gsDx28h+UUePMh8pXHnJhhVvN5cORytqGnV3Kv4tf14SItzM9iODQuXb0DIVNxC87jSzEGJhytjnt
        R7xwKwq+9vWz3tH14c41AFskXrt3jdFxcqYT3rXylH+oXIIPDHb/o0XegZCLGep9iAvuBRm9P8dYB
        ZT+d+SFQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oSbn1-007SzJ-Ig; Mon, 29 Aug 2022 10:14:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 957103004C7;
        Mon, 29 Aug 2022 12:14:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7B9F7200A7EB8; Mon, 29 Aug 2022 12:14:41 +0200 (CEST)
Message-ID: <20220829101321.640658334@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 29 Aug 2022 12:10:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, kan.liang@linux.intel.com, eranian@google.com,
        ravi.bangoria@amd.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org
Subject: [PATCH v2 4/9] perf/x86: Add a x86_pmu::limit_period static_call
References: <20220829100959.917169441@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid a branch and indirect call.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/events/core.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -72,8 +72,9 @@ DEFINE_STATIC_CALL_NULL(x86_pmu_add,  *x
 DEFINE_STATIC_CALL_NULL(x86_pmu_del,  *x86_pmu.del);
 DEFINE_STATIC_CALL_NULL(x86_pmu_read, *x86_pmu.read);
 
-DEFINE_STATIC_CALL_NULL(x86_pmu_set_period, *x86_pmu.set_period);
-DEFINE_STATIC_CALL_NULL(x86_pmu_update,     *x86_pmu.update);
+DEFINE_STATIC_CALL_NULL(x86_pmu_set_period,   *x86_pmu.set_period);
+DEFINE_STATIC_CALL_NULL(x86_pmu_update,       *x86_pmu.update);
+DEFINE_STATIC_CALL_NULL(x86_pmu_limit_period, *x86_pmu.limit_period);
 
 DEFINE_STATIC_CALL_NULL(x86_pmu_schedule_events,       *x86_pmu.schedule_events);
 DEFINE_STATIC_CALL_NULL(x86_pmu_get_event_constraints, *x86_pmu.get_event_constraints);
@@ -1391,8 +1392,7 @@ int x86_perf_event_set_period(struct per
 	if (left > x86_pmu.max_period)
 		left = x86_pmu.max_period;
 
-	if (x86_pmu.limit_period)
-		x86_pmu.limit_period(event, &left);
+	static_call_cond(x86_pmu_limit_period)(event, &left);
 
 	this_cpu_write(pmc_prev_left[idx], left);
 
@@ -2017,6 +2017,7 @@ static void x86_pmu_static_call_update(v
 
 	static_call_update(x86_pmu_set_period, x86_pmu.set_period);
 	static_call_update(x86_pmu_update, x86_pmu.update);
+	static_call_update(x86_pmu_limit_period, x86_pmu.limit_period);
 
 	static_call_update(x86_pmu_schedule_events, x86_pmu.schedule_events);
 	static_call_update(x86_pmu_get_event_constraints, x86_pmu.get_event_constraints);


