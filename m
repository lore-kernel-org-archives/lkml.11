Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF78CECAAD2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Aug 2022 14:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiH2OfO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Aug 2022 10:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiH2OfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 10:35:12 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152E5C46
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 07:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=C6mBiXZi1ynVUoBONfK85Dgqx8UibnwjC8ne4PTssys=; b=qJqUH9BWmC2sLjfD6Sqnxx+6Ev
        ed2iqQt2qiCA+Psi9O63a1TVNQbcOrzPuLiFaNHUWtktIsPs4AkvzdFxg0sJIMJuUrqF1aqwfzI6f
        5AdMNBGpZhDsY3UQdDkuPt9jCAksaBR7iFMr8VYXZ3qbrkRpNAKSp89hiCiYlUfH0iHH/Zv89BwL/
        K7tV8KUfRWG/x4QXen3PnYtS9qwm05xsGkVPdxdtAYN3pezj6Q4LPhfXN1d9qhrj4kk0t2wkxMmLb
        jo771iHIKKy50EBOUjNLfqu2b+wiGAKXNIoyI9r/skwXUj4sfvcjXzkk4nlOzIHBAeq7h3dDDAzGx
        /MLaniHQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oSfqg-007WKQ-Fb; Mon, 29 Aug 2022 14:34:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3BB0F300410;
        Mon, 29 Aug 2022 16:34:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 203462097DAD0; Mon, 29 Aug 2022 16:34:39 +0200 (CEST)
Date:   Mon, 29 Aug 2022 16:34:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <qperret@google.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Jian-Min <Jian-Min.Liu@mediatek.com>,
        Qais Yousef <qais.yousef@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] sched/pelt: Introduce PELT multiplier
Message-ID: <YwzOf5WV5G8dQBGb@hirez.programming.kicks-ass.net>
References: <20220829055450.1703092-1-dietmar.eggemann@arm.com>
 <20220829055450.1703092-2-dietmar.eggemann@arm.com>
 <Ywxz7cuR+/+1CFMR@hirez.programming.kicks-ass.net>
 <YwyOzgbbUbB+JmSH@hirez.programming.kicks-ass.net>
 <CAKfTPtAnC4escfufhjJkqsYyhDPzpmQH4xYT4nj=EjCP7gzifg@mail.gmail.com>
 <YwzL1eJUIReAEv0l@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwzL1eJUIReAEv0l@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 02:23:17PM +0000, Quentin Perret wrote:

> I'll let folks in CC comment about their use-case in more details, but
> there's definitely been an interest in tuning this thing at run-time

An interest and it making sense are two very distinct things that bear
no relation to one another in any way.

> FWIW. Typically a larger half-life will be fine with predictable
> workloads with little inputs from users (e.g. fullscreen video playback)
> while a lower one can be preferred in highly interactive cases (games,

As per always; consider the combined workload.

> ...). The transient state is fun to reason about, but it really
> shouldn't be too common AFAIK.

Once you give away control there is no taking it back, and userspace
*will* do stupid things and expect unicorns.

> With that said I'd quite like to see numbers to back that claim.
> Measuring power while running a video (for instance) with various HL
> values should help. And similarly it shouldn't be too hard to get
> performance numbers.

I'm thinking this all needs far more than mere numbers to justify.
