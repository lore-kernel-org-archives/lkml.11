Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88F3CCA473
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jun 2022 18:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343767AbiFCSgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jun 2022 14:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345434AbiFCSfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 14:35:42 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37523190D;
        Fri,  3 Jun 2022 11:26:31 -0700 (PDT)
Date:   Fri, 3 Jun 2022 11:26:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1654280789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6P5lQp7f1U6MO1nhpEo5fz8dqgLk7uC+qLCjNkbqKlk=;
        b=kJT9JFrPbx/E8af9vqV3vzJQ6fXdHUE3mDvehEEMY+MuQPB36/c3xrUq+gxk/NxA8PtD6A
        PGVevMn3UXxXer7tyzQ2QtToYQuWZGrHJkE214vC/LRtDwzi7B2yUZhJOiO/lxTyamY3Um
        +So9hpmTUwJ7udfeQkRmftxFvmbKyhI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     mhocko@kernel.org, hannes@cmpxchg.org, shakeelb@google.com,
        songmuchun@bytedance.com, akpm@linux-foundation.org,
        corbet@lwn.net, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol: separate
 {pgscan,pgsteal}_{kswapd,direct} items in memory.stat of cgroup v2
Message-ID: <YppSUNH31v6IdPUM@carbon>
References: <20220603070423.10025-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603070423.10025-1-zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 03:04:23PM +0800, Qi Zheng wrote:
> There are already statistics of {pgscan,pgsteal}_kswapd and
> {pgscan,pgsteal}_direct of memcg event here, but now the sum
> of the two is displayed in memory.stat of cgroup v2.
> 
> In order to obtain more accurate information during monitoring
> and debugging, and to align with the display in /proc/vmstat,
> it better to display {pgscan,pgsteal}_kswapd and
> {pgscan,pgsteal}_direct separately.
> 
> Moreover, after this modification, all memcg events can be
> printed with a combination of vm_event_name() and memcg_events().
> This allows us to create an array to traverse and print, which
> reduces redundant seq_buf_printf() codes.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!
