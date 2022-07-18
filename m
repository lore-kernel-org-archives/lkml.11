Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6C7C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jul 2022 10:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbiGRKKn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jul 2022 06:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiGRKKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 06:10:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B87DFFC
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 03:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HS2UsDmlONN/TsrEqFJ0NU5Aa0VHYd5/NZKmxyuPu4Q=; b=e0urG4LhcVnmsvCrFe1jGd73JY
        aEWzRcnvjrs3JJVjjoktTS07Ua/fBwzuongfh47cpS/ManFnXAXW92MUHB6wVNH8Am0ciJKHRpP+3
        VnB0bHaw3IHFKDW1z24YA6tlEgtK5zZAbmULAJTIFaIDMfwy1HCbLQnvg1A1WW1QfaPMMUrPZUB6G
        GLP41t3qp5h8xGNQ9kzvg7urnAW/m9yMrHisAtCx68HNwZ0rZgvAXLOWvJVwgxgnSMUdX0VEv7cdv
        gAkuSOJ/8g3Bmo3tm/k+37uCSdbVCGJnzx3GZitsHPS7mlXS06x3Prdlmbghu/qxi2pVtJ4jSU1H+
        pVtXGotQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oDNhu-00CauV-Oq; Mon, 18 Jul 2022 10:10:30 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 87BE5980226; Mon, 18 Jul 2022 12:10:29 +0200 (CEST)
Date:   Mon, 18 Jul 2022 12:10:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: optimize entity_tick()
Message-ID: <YtUxlVPGftwLWQNV@worktop.programming.kicks-ass.net>
References: <20220718094937.37360-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718094937.37360-1-zhangpeng.00@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 05:49:37PM +0800, Peng Zhang wrote:
> From: "zhangpeng.00" <zhangpeng.00@bytedance.com>
> 
> entity_tick() will be called to check preemption by calculating each
> sched_entity's time_slice in a task group tree from bottom to top.
> 
> If a need_resched_flag is set by a checking of a sched_entity,
> there is no necessary to check preemption of the sched_entity's
> parent and ancestor entity.
> 
> So we can test if the need_resched_flag has been set before calling
> check_preempt_tick() to avoid unnecessary calculations.
> 
> Signed-off-by: zhangpeng.00 <zhangpeng.00@bytedance.com>

Optimization patches should come with numbers showing they're worth it.

Also; did you consider side-effects from check_preempt_tick(), like
clearing buddy state etc.. ?
