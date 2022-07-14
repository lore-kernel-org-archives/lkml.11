Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27A1C43334
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jul 2022 14:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238671AbiGNOkG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jul 2022 10:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbiGNOkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 10:40:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504C827CC3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 07:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wrcLHCXkGbK7r6biJENdbeKdi71fzKteX/R2jsnl7ww=; b=YGX/bfqIsAQgg4G/mabage3DgV
        nLKSfaYMdsm91/BlFdSc5LxNk38KojSX8XzP+LSd0J3f9jW6OmJusDcqquwFQjk/G2E4lMs2G1r3R
        tNbU6mODO2odgtnq+5EPd6pDoQg1BP+G+Rs7LYNRAm+C5+asPC0lax4nxjZmUl/rsQ70UjTXH4UGp
        OncefpBEF634lTtKIqSGOACwADH6p6sk7UN04x0OzFK0+tsCSLnj6pC9TewOEc32/5S4sAKhH78Z7
        eABkoOYw8LKuIh/QRrC33yKwriKn4ytZRsDiHTWv6wDiSKn5+UadcrW4CQt5Zh4ip+eMro8cufWIa
        d8tyVsMg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oC00K-009RYL-Lj; Thu, 14 Jul 2022 14:39:48 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 36DE398017C; Thu, 14 Jul 2022 16:39:47 +0200 (CEST)
Date:   Thu, 14 Jul 2022 16:39:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     Schspa Shi <schspa@gmail.com>, tj@kernel.org,
        linux-kernel@vger.kernel.org, zhaohui.shi@horizon.ai
Subject: Re: [PATCH] workqueue: Use active mask for new worker when pool is
 DISASSOCIATED
Message-ID: <YtAqsyjlvmfDokH/@worktop.programming.kicks-ass.net>
References: <20220707090501.55483-1-schspa@gmail.com>
 <0320c5f9-cbda-1652-1f97-24d1a22fb298@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0320c5f9-cbda-1652-1f97-24d1a22fb298@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 05:52:58PM +0800, Lai Jiangshan wrote:
> 
> 
> CC Peter.
> Peter has changed the CPU binding code in workqueue.c.

[ 1622.829091] WARNING: CPU: 3 PID: 31 at kernel/sched/core.c:7756 sched_cpu_dying+0x74/0x204
[ 1622.829374] CPU: 3 PID: 31 Comm: migration/3 Tainted: P           O      5.10.59-rt52 #2
									^^^^^^^^^^^^^^^^^^^^^

I think we can ignore this as being some ancient kernel. Please try
something recent.
