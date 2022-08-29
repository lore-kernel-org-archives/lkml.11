Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29061ECAAD2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Aug 2022 12:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiH2MPr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Aug 2022 08:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbiH2MPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 08:15:19 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB9AA00F4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 04:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=B7n71/NkrtHYvF9gedtNk1oY9cS74shjCaQIwnnXV8Y=; b=fEUXVBk/2raflvOiZZ7QVgwExz
        c6ElBLPEwxKEIBI2MKcCrp/8vlJRLsO2azx5vf2xEBCBRSE0PMqp1IrbCuQ1DfhD8t17Y8Jnb16xy
        O0hccUeNwgUmT8u2EVeeR+guhFly0wsDlhJVVeyS5Hv85dBMoiFPJJ306VR4MzJ20HY9DyY+Csr5Q
        BgzbajkgVVzQ3iETJpzajYNx+GF73DangpXA8midaIGww8iaQCTBEU9nRbQIZm/Klh9aYtd0NyrV0
        CkyvxdkZOzkJjdQ1h/9maLPgq7vDMyOMl3x95PoNjkFBg2B3q6t0QZgGHZAQEtVDAFaKvpqj+QQd7
        J7AZEePg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oSdPT-007U95-6Z; Mon, 29 Aug 2022 11:58:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AB506300137;
        Mon, 29 Aug 2022 13:58:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9452D2083F6F4; Mon, 29 Aug 2022 13:58:29 +0200 (CEST)
Date:   Mon, 29 Aug 2022 13:58:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, songliubraving@fb.com,
        eranian@google.com, alexey.budankov@linux.intel.com,
        ak@linux.intel.com, mark.rutland@arm.com, megha.dey@intel.com,
        frederic@kernel.org, maddy@linux.ibm.com, irogers@google.com,
        kim.phillips@amd.com, linux-kernel@vger.kernel.org,
        santosh.shukla@amd.com
Subject: Re: [RFC v2] perf: Rewrite core context handling
Message-ID: <Ywyp5XmDTJxmmKlN@hirez.programming.kicks-ass.net>
References: <20220113134743.1292-1-ravi.bangoria@amd.com>
 <YqdLH+ZU/sf4n0pa@hirez.programming.kicks-ass.net>
 <YqdL8LsOvxNqhz/v@hirez.programming.kicks-ass.net>
 <f994d403-df7b-d88e-8324-c29d0ef2034e@amd.com>
 <YwOgxhfS99Rquwct@worktop.programming.kicks-ass.net>
 <YwOkFqqxONtoGImZ@worktop.programming.kicks-ass.net>
 <fb28c31f-c531-4be3-e9c9-d324451d79d5@amd.com>
 <8d91528b-e830-6ad0-8a92-621ce9f944ca@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d91528b-e830-6ad0-8a92-621ce9f944ca@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 09:30:50AM +0530, Ravi Bangoria wrote:
> > With this, I can run 'perf test' and perf_event_tests without any error in
> > dmesg. I'll run perf fuzzer over night and see if it reports any issue.
> 
> I also ran fuzzer on Intel machine over the weekend. I see only one WARN_ON()
> hit. Otherwise system is running normal. FWIW, I was running fuzzer as normal
> user with perf_event_paranoid=0.
> 
>   WARNING: CPU: 3 PID: 2840537 at arch/x86/events/core.c:1606 x86_pmu_stop+0xd0/0x100

That's the WARN about PERF_HES_STOPPED already being set.

>   Call Trace:
>    <TASK>
>    x86_pmu_del+0x8e/0x2d0
>    ? debug_smp_processor_id+0x17/0x20
>    event_sched_out+0x10b/0x2b0
>    ? x86_pmu_del+0x5c/0x2d0
>    merge_sched_in+0x39f/0x410

And this callchain suggests this is the group_error path.

I can't immediately spot a fail there, but I'll try and stare at it
some.
