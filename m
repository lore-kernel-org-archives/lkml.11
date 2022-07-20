Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0647C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jul 2022 15:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235498AbiGTPh6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jul 2022 11:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbiGTPh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:37:57 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEB22D1FF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=V/xzlzJ2En0RfavcxGxC6aJIZSgKDkwEkGCffOphqEY=; b=mEFyQtTwYgvoGI/1+lAaTC39uq
        NHfPQsXqILjEe95WJFPHMOfRGZDfEvLToJYmrpBe5KcBi9/R9rbJeh3ZsEOGy120tCD2i/0n6pwJr
        hkKlvXOYoaA6i2rFT8yAgKxlt+F4crQxc8sTNQ/sTxw6hXUKDD+NBaSaYwY9W+9PQjqBJZ3VPzvw7
        9fvukjyHpmsNFVklV1gu/uhW+ZbEigaPXK6lE4cPfal4aiSCplvWJPWUemGYe+pJJTeYiOHceYjTv
        WAaBocQ9JAlhajbEz6Ss5XwtJEzEH19T8YzvDEjCzrzSlC2snx4qUhy+Vdo9erFlmvVJFtS5GFcxN
        LezZSxAw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEBli-005LkK-HN; Wed, 20 Jul 2022 15:37:47 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id D2E06980BBE; Wed, 20 Jul 2022 17:37:44 +0200 (CEST)
Date:   Wed, 20 Jul 2022 17:37:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/lockdep: use pr_warn_once for reporting that
 lockdep is turned off
Message-ID: <YtghSIB5wNVfnxoX@worktop.programming.kicks-ass.net>
References: <6acb20ea-7f9c-120a-c8c5-9ee5d511d766@I-love.SAKURA.ne.jp>
 <YtgYNzrLuHIcz6R5@worktop.programming.kicks-ass.net>
 <ba7d4412-2dfb-2e4c-52fc-ba8c305abaa8@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba7d4412-2dfb-2e4c-52fc-ba8c305abaa8@I-love.SAKURA.ne.jp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 12:13:31AM +0900, Tetsuo Handa wrote:
> On 2022/07/20 23:59, Peter Zijlstra wrote:
> > On Wed, Jul 20, 2022 at 10:01:36PM +0900, Tetsuo Handa wrote:
> >> debug_show_all_locks() can be called for multiple times if
> >> hung_task_call_panic = 0. No need to repeat this message.
> > 
> > That one extra line is really a problem?
> 
> When lockdep is turned off during boot or some testing, khungtaskd repeats
> this message, and I feel this repeated message useless.

I feel you should then fix the issue that lockdep is complaining about
instead of making the message go away.
