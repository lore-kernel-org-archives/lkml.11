Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AA4C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 19 May 2022 14:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239962AbiESOtC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 May 2022 10:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239945AbiESOs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 10:48:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522B9A2049
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 07:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/UnY8wF6M3CMF1JsRlHNZDZ078eBfzfvzVijhgo1o3I=; b=U64FCHhG54XDTwOs7d9z8oVZ+Q
        K03767vckgx8TOTtR3YFZsb2H896pMQ+6Jfy4wX1so4ach2iWBpZ18mSNHV8W4Bb/TonRzlbEbCS3
        Cqhujl0qkXTuudwvSN964TIzcciVBLu5ADk1nL6whiTmz7UBsVZFXaMuNeU4T1/uoTtPKwDYNt1p9
        nvA1LJfO2YPjOHAhasKayobET8vHqp5AhBNpizNoeysyI3fUuV46B+plyDBN2VOzMwZGkgWheZc5p
        5jJUiJb3MkFXszVn/HYs3xFjtJ+8jlvt+0JL1KrF7hdCGLkyIdoHI+HR6wHawuXL0IUM8kmeMc+D1
        GulcAS7g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrhRv-00Cnu1-IL; Thu, 19 May 2022 14:48:23 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 478F2980BD3; Thu, 19 May 2022 16:48:21 +0200 (CEST)
Date:   Thu, 19 May 2022 16:48:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Phil Auld <pauld@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yu Liao <liaoyu15@huawei.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 03/21] rcu: Add a note about noinstr VS unsafe eqs
 functions
Message-ID: <20220519144821.GI2578@worktop.programming.kicks-ass.net>
References: <20220503100051.2799723-1-frederic@kernel.org>
 <20220503100051.2799723-4-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503100051.2799723-4-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2022 at 12:00:33PM +0200, Frederic Weisbecker wrote:
> Some RCU functions enter or exit into/from RCU idle mode while using
> trace-able and lockdep-aware IRQs (un-)masking. This could be easily
> solved with using raw versions of local_irq_*() but we would then
> lose some precious debugging informations.
> 
> Another possible way to solve this may consist in using rude RCU-tasks
> in lockdep and irqsoff tracing.
> 
> In any case and until this get solved, those RCU functions can't get
> tagged as noinstr even though they should.

No need to speculate on how to solve it; the generic entry code has
alternatives that are good. It's just that reworking your architecture
isn't trivial.
