Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85B1C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Feb 2022 13:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbiBINLf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Feb 2022 08:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233907AbiBINL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 08:11:28 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D77C05CB9A;
        Wed,  9 Feb 2022 05:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jIlX3T9nO/FWolbjm9VXWyEXcy4qK8AsuSNSYKhdAMw=; b=iDVo81U0o+3xBqd8XS9RZ1Q/SG
        F4kjSTIjJ61cqg8ny/tTASsXWF3QxDuq3vO9SQxY0YifOtc/w1Wf5ZxyOzEHvTVkUq/bK9aovxsvg
        AxqEHdBmRqePcylRLQJa9uFlS4KvgsdoN0E8qRhFFJiwRH5oEOdn0OYJZNFmzpr5u+ZklJArgp6xN
        nNpVyyzeVxv18V+rOZ2UCH3oB5YvFIKeepzQhlF+I+gfmmbOzTjhUgIcjLQfnLzB8j7CDHiZywbTh
        2kWU/gL9TOxCSflXKrLrLFZo0c/jkmfaJ5yGUNBjaFRV8NEwnTGm8V6CKqOHUx5Fc7/rO4utBj/sy
        RNWBQsgA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHmkd-008QeS-LA; Wed, 09 Feb 2022 13:11:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DED03300478;
        Wed,  9 Feb 2022 14:11:13 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C068F265018D6; Wed,  9 Feb 2022 14:11:13 +0100 (CET)
Date:   Wed, 9 Feb 2022 14:11:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        kvm@vger.kernel.org, H Peter Anvin <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH 02/11] perf/x86: Add support for TSC as a perf event clock
Message-ID: <YgO9cdEvs7mhjTNp@hirez.programming.kicks-ass.net>
References: <20220209084929.54331-1-adrian.hunter@intel.com>
 <20220209084929.54331-3-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209084929.54331-3-adrian.hunter@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 10:49:20AM +0200, Adrian Hunter wrote:
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index 82858b697c05..150d2b70a41f 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -290,6 +290,14 @@ enum {
>  	PERF_TXN_ABORT_SHIFT = 32,
>  };
>  
> +/*
> + * If supported, clockid value to select an architecture dependent hardware
> + * clock. Note this means the unit of time is ticks not nanoseconds.
> + * On x86, this is provided by the rdtsc instruction, and is not
> + * paravirtualized.
> + */
> +#define CLOCK_PERF_HW_CLOCK		0x10000000

This steps on the clockid_t space; are we good with that?

At some point there was talk of dynamic clock ids, that would complicate
things more than they are today.
