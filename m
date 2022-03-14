Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2C2C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Mar 2022 10:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238286AbiCNKCL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Mar 2022 06:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbiCNKCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 06:02:02 -0400
Received: from outbound-smtp39.blacknight.com (outbound-smtp39.blacknight.com [46.22.139.222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC9019C28
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 03:00:50 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp39.blacknight.com (Postfix) with ESMTPS id A91DC16E4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 10:00:48 +0000 (GMT)
Received: (qmail 27288 invoked from network); 14 Mar 2022 10:00:48 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.223])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 14 Mar 2022 10:00:48 -0000
Date:   Mon, 14 Mar 2022 10:00:46 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Eric Dumazet <edumazet@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>, Wei Xu <weixugc@google.com>,
        Greg Thelen <gthelen@google.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] mm/page_alloc: call check_pcp_refill() while zone
 spinlock is not held
Message-ID: <20220314100046.GM15701@techsingularity.net>
References: <20220313232547.3843690-1-eric.dumazet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20220313232547.3843690-1-eric.dumazet@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 13, 2022 at 04:25:47PM -0700, Eric Dumazet wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> check_pcp_refill() is used from rmqueue_bulk() while zone spinlock
> is held.
> 
> This used to be fine because check_pcp_refill() was testing only the
> head page, while its 'struct page' was very hot in the cpu caches.
> 
> With ("mm/page_alloc: check high-order pages for corruption during PCP
> operations") check_pcp_refill() will add latencies for high order pages.
> 
> We can defer the calls to check_pcp_refill() after the zone
> spinlock has been released.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

I'm not a major fan. While this reduces the lock hold times, it adds
another list walk which may make the overall operation more expensive
which is probably a net loss given that the cold struct pages are still
accessed.

The lower lock hold times applies to high-order allocations which are
either THPs or SLAB refills. THP can be expensive anyway depending on
whether compaction had to be used and SLAB refills do not necessarily occur
for every SLAB allocation (although it is likely much more common for
network intensive workloads). This means that the patch may be helping
the uncommon case (high order alloc) at the cost of the common case
(order-0 alloc).

Because this incurs a second list walk cost to the common case, I think
the changelog would need justification that it does not hurt common paths
and that the lock hold reduction times make a meaningful difference.

-- 
Mel Gorman
SUSE Labs
