Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17E9C28D13
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 02:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239541AbiHWCWn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Aug 2022 22:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239350AbiHWCWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 22:22:35 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5655B044;
        Mon, 22 Aug 2022 19:22:34 -0700 (PDT)
Date:   Mon, 22 Aug 2022 19:22:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1661221352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TZOqb9ioXhJDay90SUSTe6Atr/mSmzrNsQskOLmcTw4=;
        b=jI0qftCBqUXZ/ZlfsIX0UQLffYq89HNRsd9OT0MrXYVBD4YWNdLsaPUXLt1Nt8conY9VNu
        Our9SMBCO6MRU92nM4eMoAvX1Z8XNGtZscdF3oPd/WL6APpO+wU/shrYeBfxkhKV2gs4cB
        8Ikj1k7/usuDTGr3ZyOp6n5d4u0jScI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Eric Dumazet <edumazet@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Feng Tang <feng.tang@intel.com>,
        Oliver Sang <oliver.sang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, lkp@lists.01.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] memcg: increase MEMCG_CHARGE_BATCH to 64
Message-ID: <YwQ54pvNwy0/5u3C@P9FQF9L96D>
References: <20220822001737.4120417-1-shakeelb@google.com>
 <20220822001737.4120417-4-shakeelb@google.com>
 <YwPM6o1+pZ2kRyy3@P9FQF9L96D>
 <YwPZ1lpJ98pZSLmw@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwPZ1lpJ98pZSLmw@dhcp22.suse.cz>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 09:34:59PM +0200, Michal Hocko wrote:
> On Mon 22-08-22 11:37:30, Roman Gushchin wrote:
> [...]
> > I wonder only if we want to make it configurable (Idk a sysctl or maybe
> > a config option) and close the topic.
> 
> I do not think this is a good idea. We have other examples where we have
> outsourced internal tunning to the userspace and it has mostly proven
> impractical and long term more problematic than useful (e.g.
> lowmem_reserve_ratio, percpu_pagelist_high_fraction, swappiness just to
> name some that come to my mind). I have seen more often these to be used
> incorrectly than useful.

A agree, not a strong opinion here. But I wonder if somebody will
complain on Shakeel's change because of the reduced accuracy.
I know some users are using memory cgroups to track the size of various
workloads (including relatively small) and 32->64 pages per cpu change
can be noticeable for them. But we can wait for an actual bug report :)

> 
> In this case, I guess we should consider either moving to per memcg
> charge batching and see whether the pcp overhead x memcg_count is worth
> that or some automagic tuning of the batch size depending on how
> effectively the batch is used. Certainly a lot of room for
> experimenting.

I'm not a big believer into the automagic tuning here because it's a fundamental
trade-off of accuracy vs performance and various users might make a different
choice depending on their needs, not on the cpu count or something else.

Per-memcg batching sounds interesting though. For example, we can likely
batch updates on leaf cgroups and have a single atomic update instead of
multiple most of the times. Or do you mean something different?

Thanks!
