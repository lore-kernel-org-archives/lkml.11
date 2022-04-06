Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95150C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 14:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235226AbiDFOoq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Apr 2022 10:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbiDFOof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:44:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FD5283F75
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 04:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aC0Fn0chNqANpAwyndbCkdbFC3Xwua10F6q/RvI8gTY=; b=TV1XHrL1pD/jqAKoMzhrASOwtw
        zj2iPZKUXSG3bbWDCZxKsjY8N+GN+MOuJw7tIH50Da1qJpykVOKO9xdxWn2DraP6hy7UoXMQJ0k6H
        /bHk6g6gRYWJ7GNlZtWE7pVrXgRDIkhQ990G8su6rwVU4wrJ0PNyWmf/gRRcV4PMhPWlFZzU7dB5x
        zm7P/gOI++9qdsrhEfgPK91UYXe3y00R0WJsaFll6kLSzvOS9InZQrJ4zgAQiX27zxbKL0vYx7Qf0
        xp/L3dJ5wy0uJIkYACv+9jO6Nci2WX4MaW9PiaEUWoJvRbV8iNVF5R9tU2x7NMWeqNGMNljtWQrQe
        4thTscxQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nc3Zq-007jf2-5h; Wed, 06 Apr 2022 11:11:54 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id B1199986199; Wed,  6 Apr 2022 13:11:53 +0200 (CEST)
Date:   Wed, 6 Apr 2022 13:11:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Hailong Liu <liuhailong@linux.alibaba.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        aniel Bristot de Oliveira <bristot@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] psi: Fix trigger being fired unexpectedly at initial
Message-ID: <20220406111153.GC2731@worktop.programming.kicks-ass.net>
References: <1648789811-3788971-1-git-send-email-liuhailong@linux.alibaba.com>
 <CAJuCfpH3mzLi4bhaLUYLDDXA6uVM5Pn67aXyPefseEsAYDatSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpH3mzLi4bhaLUYLDDXA6uVM5Pn67aXyPefseEsAYDatSA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2022 at 09:19:17AM -0700, Suren Baghdasaryan wrote:
> On Thu, Mar 31, 2022 at 10:10 PM Hailong Liu
> <liuhailong@linux.alibaba.com> wrote:
> >
> > When a trigger being created, its win.start_value and win.start_time are
> > reset to zero. If group->total[PSI_POLL][t->state] has accumulated before,
> > this trigger will be fired unexpectedly in the next period, even if its
> > growth time does not reach its threshold.
> >
> > So set the window of the new trigger to the current state value.
> 
> Makes sense to me. Thanks!
> 
> >
> > Signed-off-by: Hailong Liu <liuhailong@linux.alibaba.com>
> 
> Acked-by: Suren Baghdasaryan <surenb@google.com>

Thanks!
