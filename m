Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5B2C433FE
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Mar 2022 13:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243522AbiC1N5L (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Mar 2022 09:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234398AbiC1N5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 09:57:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322A64EA38
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 06:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gaThz6ESM1nDJuMoy7Het8pna8psJjs6H6kDuboA//s=; b=McueSvhmwWHn7UYU9iLjWmtLZZ
        3AOotlv0qDVEP9R8l4oM0drN0Mx5SdDaYRwMV5vPamLIcGB1kI4pp+7aBYc+8DtyPAFZXU8h1AtuM
        eltsWd+XfN2WlLKIFtgW45vScrzOuEYXL9xoMSAIthleSt8+cAK60WW+3HaQs7yDNusub8n3iZDZZ
        QBHpaSheVqL63+bUdOi07QJ1HzVhShM8f9pVyatILw/MOHSGBGM5ZUUgPRBHkGqYdzLLYPX6DzSTs
        NWxhskiCCLvtKxqd9PwOdHGdV6NTvp9VrZc5xcwZi9QbnGxGJqteRuV+zPlB/VekgY2jl4wmSyqiZ
        S7Xvsimg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nYpq0-00GyPo-B3; Mon, 28 Mar 2022 13:55:16 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id C05CA9861EA; Mon, 28 Mar 2022 15:55:14 +0200 (CEST)
Date:   Mon, 28 Mar 2022 15:55:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH 0/3] Remove volatile from arch_raw_cpu_ptr() and revert
 the hacks.
Message-ID: <20220328135514.GE8939@worktop.programming.kicks-ass.net>
References: <CAHk-=wh81PAKxapicYOby3WWOFJV2htR5KWCRdKNgw68mOc0Zg@mail.gmail.com>
 <20220324173927.2230447-1-bigeasy@linutronix.de>
 <CAHk-=wgcM9vUjGTdoCbX4DuBM+53FFmHFqYZdF8mNzATwj8z0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgcM9vUjGTdoCbX4DuBM+53FFmHFqYZdF8mNzATwj8z0A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 11:28:16AM -0700, Linus Torvalds wrote:

> So Ack on your series, but that additional comment might be worth it,
> since I didn't even think of it until you mentioned it. Clearly much
> too subtle.

Sebastian, were you going to resend these patches with that comment on,
or should I go collect them as is for post -rc1?
