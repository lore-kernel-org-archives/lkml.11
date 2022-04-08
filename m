Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EF5C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Apr 2022 12:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235736AbiDHMaW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Apr 2022 08:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234809AbiDHMaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 08:30:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B9A33E584
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 05:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OxTl/Bo6O7TBtxt/bi9rJuC9dJm2oXselnLd5pOzHHI=; b=TJrQfNWERGBDiYrnJ9nYbulzkb
        5LBSx+OvEuQlwdN3M5taRMU6nkMCV7kKZ6HWe0di/Uvq0PsA4kbKQw8s881DrYufRVY//mz4JCGtp
        Unr0U7iULcDanW8ORUDT+5Fai28j+b99mPyQnCXUkTxVnlgR1hTPkFSCUF4aSFv9V8rCywipL61wR
        Ksq9pXcESwIKG0PdQfko2tML8/2F0V6HIgKK2e6wkqgsHI8QIvAcAlFXvF9sV9jEl74ejYvVOySYG
        +2V+ZqFOxfwcJbZezI4CxmjPa0HDBdiUz7URIrfHabH+Fnm4xPxlmDn8f/49ErGAEbf/AcxfwMnqQ
        6BUxW9Rg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ncnic-009oMg-64; Fri, 08 Apr 2022 12:28:02 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 530839861A4; Fri,  8 Apr 2022 14:28:00 +0200 (CEST)
Date:   Fri, 8 Apr 2022 14:28:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com
Subject: Re: [PATCH v2 1/2] sched/fair: Fix cfs_rq_clock_pelt() for throttled
 cfs_rq
Message-ID: <20220408122800.GQ2731@worktop.programming.kicks-ass.net>
References: <20220408115309.81603-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408115309.81603-1-zhouchengming@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 07:53:08PM +0800, Chengming Zhou wrote:
> Since commit 23127296889f ("sched/fair: Update scale invariance of PELT")
> change to use rq_clock_pelt() instead of rq_clock_task(), we should also
> use rq_clock_pelt() for throttled_clock_task_time and throttled_clock_task
> accounting to get correct cfs_rq_clock_pelt() of throttled cfs_rq. And
> rename throttled_clock_task(_time) to be clock_pelt rather than clock_task.
> 
> Fixes: 23127296889f ("sched/fair: Update scale invariance of PELT")
> Reviewed-by: Ben Segall <bsegall@google.com>
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Thanks! (for all 3 patches)
