Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22996C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 May 2022 11:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355146AbiEELNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 May 2022 07:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344317AbiEELNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 07:13:34 -0400
Received: from outbound-smtp42.blacknight.com (outbound-smtp42.blacknight.com [46.22.139.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C596E13D28
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 04:09:52 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp42.blacknight.com (Postfix) with ESMTPS id 095B917A7
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 12:09:51 +0100 (IST)
Received: (qmail 10219 invoked from network); 5 May 2022 11:09:50 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 5 May 2022 11:09:50 -0000
Date:   Thu, 5 May 2022 12:09:47 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, fengwei.yin@intel.com
Subject: Re: [mm/page_alloc]  f26b3fa046:  netperf.Throughput_Mbps -18.0%
 regression
Message-ID: <20220505110947.GD3441@techsingularity.net>
References: <20220420013526.GB14333@xsang-OptiPlex-9020>
 <YmvMDyx05UoPFtQy@ziqianlu-desk1>
 <20220429133918.GC3441@techsingularity.net>
 <YnOKWNE3PZzzohNH@ziqianlu-desk1>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <YnOKWNE3PZzzohNH@ziqianlu-desk1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 04:27:04PM +0800, Aaron Lu wrote:
> On Fri, Apr 29, 2022 at 02:39:18PM +0100, Mel Gorman wrote:
> > On Fri, Apr 29, 2022 at 07:29:19PM +0800, Aaron Lu wrote:
> 
> ... ...
> 
> > > The said change looks like this:
> > > (relevant comment will have to be adjusted)
> > > 
> > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > index 505d59f7d4fa..130a02af8321 100644
> > > --- a/mm/page_alloc.c
> > > +++ b/mm/page_alloc.c
> > > @@ -3332,18 +3332,19 @@ static int nr_pcp_high(struct per_cpu_pages *pcp, struct zone *zone,
> > >  		       bool free_high)
> > >  {
> > >  	int high = READ_ONCE(pcp->high);
> > > +	int batch = READ_ONCE(pcp->batch);
> > >  
> > > -	if (unlikely(!high || free_high))
> > > +	if (unlikely(!high))
> > >  		return 0;
> > >  
> > > -	if (!test_bit(ZONE_RECLAIM_ACTIVE, &zone->flags))
> > > -		return high;
> > > -
> > >  	/*
> > >  	 * If reclaim is active, limit the number of pages that can be
> > >  	 * stored on pcp lists
> > >  	 */
> > > -	return min(READ_ONCE(pcp->batch) << 2, high);
> > > +	if (test_bit(ZONE_RECLAIM_ACTIVE, &zone->flags) || free_high)
> > > +		return min(batch << 2, high);
> > > +
> > > +	return high;
> > >  }
> > >  
> > >  static void free_unref_page_commit(struct page *page, int migratetype,
> > > 
> > > Does this look sane? If so, I can prepare a formal patch with proper
> > > comment and changelog, thanks.
> > 
> > I think it looks reasonable sane. The corner case is that if
> > ((high - (batch >> 2)) > cachesize) that the pages will not get recycled
> 
> When free_high is true, the above diff changed the return value of
> nr_pcp_high() from 0 to min(batch << 2, pcp->high) so the corner case is
> when (min(batch << 2, pcp->high) > cachesize)?
> 

Yes. It's not perfect due to cache aliasing so the actual point where it
matters will be variable. Whatever the value is, there a value where the
corner case applies that pages do not get recycled quickly enough and
are no longer cache-hot.

-- 
Mel Gorman
SUSE Labs
