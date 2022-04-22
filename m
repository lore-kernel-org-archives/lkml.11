Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A6EC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Apr 2022 18:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbiDVSBW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Apr 2022 14:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234193AbiDVR6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 13:58:06 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5046F494;
        Fri, 22 Apr 2022 10:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Toyju6a+evnhzH+Nqks+WR6DENzUjw2yWJmWU3651y0=; b=b0QAaktQMlIxRfq/uHTuerhC7B
        Z53GTvIOeOO2kg5KrMW1hGLzc9YhdqWmc4rqrLeV63geBifrYl7QT8IfiaAx72PSDbHixmrAuTM5A
        5N+FanBJW3e/1JOMd/6zxYCkQhoErfZ7wPYKKmQRYYgyBiYn9e8ztX+3O3JZOBaeDADGnZVO9fPxy
        MBreCn8jNX04jupKTnL29af4St2DmZDV7klFTdgRamsFyECj1miJZaxhwuIsylseJ9IbUzKoqw9bY
        JKbau1LLKiNZtUjjs59qyKi7sy1sbku1D89tsYC7ZK09divKAXHrXAqMfXATyTvHEgJAyF9lIMrns
        z4tW2xOg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhxQc-007lL9-E4; Fri, 22 Apr 2022 17:50:46 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id DA4C59861AE; Fri, 22 Apr 2022 19:50:44 +0200 (CEST)
Date:   Fri, 22 Apr 2022 19:50:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     David Vernet <void@manifault.com>, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, cgroups@vger.kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/4] cgroup: Introduce cpu controller test suite
Message-ID: <20220422175044.GX2731@worktop.programming.kicks-ass.net>
References: <20220422173349.3394844-1-void@manifault.com>
 <YmLqdIiXdpQqcPTd@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmLqdIiXdpQqcPTd@slm.duckdns.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 07:48:36AM -1000, Tejun Heo wrote:
> Hello, David.
> 
> On Fri, Apr 22, 2022 at 10:33:47AM -0700, David Vernet wrote:
> > This patchset introduces a new test_cpu.c test suite as part of
> > tools/testing/selftests/cgroup. test_cpu.c will contain testcases that
> > validate the cgroup v2 cpu controller.
> > 
> > This patchset only contains testcases that validate cpu.stat and
> > cpu.weight, but I'm expecting to send further patchsets after this that
> > also include testcases that validate other knobs such as cpu.max.
> > 
> > Note that checkpatch complains about a missing MAINTAINERS file entry for
> > [PATCH 1/4], but Roman Gushchin added that entry in a separate patchset:
> > https://lore.kernel.org/all/20220415000133.3955987-4-roman.gushchin@linux.dev/.
> 
> Looks great to me. Thanks for adding the much needed selftests. Peter, if
> you're okay with it, imma route it through the cgroup tree.

Sure, have at. Thanks!
