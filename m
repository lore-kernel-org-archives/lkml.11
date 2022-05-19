Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297F3C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 May 2022 15:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240451AbiESPDK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 May 2022 11:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240369AbiESPCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 11:02:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D700BEBE8D
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 08:01:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6419CB82564
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 15:01:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB92C34100;
        Thu, 19 May 2022 15:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652972498;
        bh=vxzuV8FswPsZxFpufH17N2JgSjIsyRUE1PuUjqu6Z88=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P6ussOQcoUaP7lZdXMnd6cuA4Ft9G2P0zq+bTtA2hkgqk5au67LheGZznguQyEhXf
         J1fILX4hM/myjH37Iu+zLroNcvf9FnTJ6dXYGgHoe2RF6lBnZz3xJG/OoidgaJn6Uv
         nk/Py3GK9MPJMpCAqggrydTCj2CcsPuOSCPWbvPQF6hiNQJF8ADefCDLIT9fOrnHqZ
         y8mKYYC2nkVE7W/MIUp/4KQySfDPnbk1/t3Oh2x8WC21ByKxLNd1TaZdMAK17HGdOn
         SfJx5OA9jzrUwVVS9rrSrCvySX480G4xmpGdbCTRU6P5ILfoXm6HltyF3N/WwdmBZI
         uAr9foz9tx/Ow==
Date:   Thu, 19 May 2022 17:01:35 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20220519150135.GA618878@lothringen>
References: <20220503100051.2799723-1-frederic@kernel.org>
 <20220503100051.2799723-4-frederic@kernel.org>
 <20220519144821.GI2578@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519144821.GI2578@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 04:48:21PM +0200, Peter Zijlstra wrote:
> On Tue, May 03, 2022 at 12:00:33PM +0200, Frederic Weisbecker wrote:
> > Some RCU functions enter or exit into/from RCU idle mode while using
> > trace-able and lockdep-aware IRQs (un-)masking. This could be easily
> > solved with using raw versions of local_irq_*() but we would then
> > lose some precious debugging informations.
> > 
> > Another possible way to solve this may consist in using rude RCU-tasks
> > in lockdep and irqsoff tracing.
> > 
> > In any case and until this get solved, those RCU functions can't get
> > tagged as noinstr even though they should.
> 
> No need to speculate on how to solve it; the generic entry code has
> alternatives that are good. It's just that reworking your architecture
> isn't trivial.

Speaking of, please have a look at this:

https://lore.kernel.org/all/20220518162118.GA2661055@paulmck-ThinkPad-P17-Gen-1/
