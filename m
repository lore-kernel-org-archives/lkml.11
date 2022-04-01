Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0357C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Apr 2022 07:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343727AbiDAHLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Apr 2022 03:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235431AbiDAHLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 03:11:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEFD1D66FF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 00:09:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12358B823E3
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 07:09:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C43FC2BBE4;
        Fri,  1 Apr 2022 07:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648796988;
        bh=0xkpWx1ivqtq3td6Im0P8AwAE+UYEwAQxJGy7qqhrR0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hnpBeMZZt2od0g6krfAlUgq7FtMwbpwQlqXsNxFBpsX7to/5312/OFyEehtBkWu8D
         fyTkvI2DqWNgDgMTHNYzI9fikEJHQ1HPY4qXuoPeT8C1LjMtWae4P0JlgeuU3jVQbc
         Xp8s+ByG/sjdKC2p3tdxq9oe1VTV2QTYmNVwnVcE+uX+8yfyHr1CohjjUMAInwprKk
         0tf0+WrUTJ4mLGMCYOG268RW2C+rnQIyzEf1A0pQIuYuJOphNC/aVEzzjtkl9z7LjQ
         e8u9ZIosn0m7ACXg9hx9C5ZYybSLfwBM+sgaLbD+2wJdJHEuaXQ0LclBxvUpAnLXlq
         0WptxGFfQ919A==
Date:   Fri, 1 Apr 2022 09:09:42 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Alois Wohlschlager <alois1@gmx-topmail.de>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexey Gladkov <legion@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        David Hildenbrand <david@redhat.com>,
        Rolf Eike Beer <eb@emlix.com>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pid: Allow creation of pidfds to threads
Message-ID: <20220401070942.odjbuc5wecfayyok@wittgenstein>
References: <3412128.IC5jYiYEAv@genesis>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3412128.IC5jYiYEAv@genesis>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 09:02:32PM +0200, Alois Wohlschlager wrote:
> The pidfd_open() syscall now allows retrieving pidfds to processes which
> are not thread group leaders. Like standard pidfds so far, these may be
> used to retrieve file descriptors from the target thread using
> pidfd_getfd(), as well as for killing the target thread group using
> pidfd_send_signal().
> However, unlike pidfds referencing thread group leaders, they do not
> support polling for process exit. Attempts to do so signal an error
> condition instead of blocking indefinitely.
> 
> Since the semantics of pidfd_getfd() and pidfd_send_signal() are not
> very useful within a thread group, these thread pidfds can only be
> created using pidfd_open(), not via clone().
> 
> Signed-off-by: Alois Wohlschlager <alois1@gmx-topmail.de>
> ---

Hey Alois,

We originally blocked this because it is not as easy as simply allowing
pidfds to be created for non-thread-group leaders.
For a start, pidfd_poll() currently doens't work if pidfd_task() isn't a
thread-group leader and you'll just hang for CLONE_PIDFD | CLONE_THREAD.
So at least that needs to be adapated as well and there's likely a bunch
of other corner-cases I'm forgetting about.
Do you have a concrete use-case you want this for?

Christian
