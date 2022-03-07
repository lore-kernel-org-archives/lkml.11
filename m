Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FCDC433FE
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Mar 2022 17:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242339AbiCGRFp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Mar 2022 12:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238330AbiCGRFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 12:05:43 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3971664BC5
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 09:04:48 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E1365210EF;
        Mon,  7 Mar 2022 17:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646672686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wS6Ue02k7hebk/Mgz2MF8d/Kcu7OchpiW9RtZ99n1Tk=;
        b=h/KHreq1aZibiQdnyTkaKYnSAiIewWKzL98qQei2xPe5fc++FeoxnTlennRxorxjCBkG8E
        qU/VQcHwTsKYY92NJCHgJiZtajusWWDiEbF/ynBNVGjDB42z9zrpLCc4EedxDiitQ7xWuK
        ekphZJHyi1XjrHagrf0AtbVKScVsDj0=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B10DAA3B83;
        Mon,  7 Mar 2022 17:04:46 +0000 (UTC)
Date:   Mon, 7 Mar 2022 18:04:43 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, pmladek@suse.com,
        peterz@infradead.org, guro@fb.com, shakeelb@google.com,
        minchan@kernel.org, timmurray@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [RFC 1/1] mm: page_alloc: replace mm_percpu_wq with kthreads in
 drain_all_pages
Message-ID: <YiY7K4ftAI3t6km8@dhcp22.suse.cz>
References: <20220225012819.1807147-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225012819.1807147-1-surenb@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 24-02-22 17:28:19, Suren Baghdasaryan wrote:
> Sending as an RFC to confirm if this is the right direction and to
> clarify if other tasks currently executed on mm_percpu_wq should be
> also moved to kthreads. The patch seems stable in testing but I want
> to collect more performance data before submitting a non-RFC version.
> 
> 
> Currently drain_all_pages uses mm_percpu_wq to drain pages from pcp
> list during direct reclaim. The tasks on a workqueue can be delayed
> by other tasks in the workqueues using the same per-cpu worker pool.
> This results in sizable delays in drain_all_pages when cpus are highly
> contended.

This is not about cpus being highly contended. It is about too much work
on the WQ context.

> Memory management operations designed to relieve memory pressure should
> not be allowed to block by other tasks, especially if the task in direct
> reclaim has higher priority than the blocking tasks.

Agreed here.

> Replace the usage of mm_percpu_wq with per-cpu low priority FIFO
> kthreads to execute draining tasks.

This looks like a natural thing to do when WQ context is not suitable
but I am not sure the additional resources is really justified. Large
machines with a lot of cpus would create a lot of kernel threads. Can we
do better than that?

Would it be possible to have fewer workers (e.g. 1 or one per numa node)
and it would perform the work on a dedicated cpu by changing its
affinity? Or would that introduce an unacceptable overhead?

Or would it be possible to update the existing WQ code to use rescuer
well before the WQ is completely clogged?
-- 
Michal Hocko
SUSE Labs
