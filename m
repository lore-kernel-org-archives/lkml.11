Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9C7C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 May 2022 14:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355028AbiEMOXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 May 2022 10:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245426AbiEMOXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 10:23:37 -0400
Received: from outbound-smtp37.blacknight.com (outbound-smtp37.blacknight.com [46.22.139.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE75B9
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 07:23:34 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp37.blacknight.com (Postfix) with ESMTPS id 920C63691
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 15:23:32 +0100 (IST)
Received: (qmail 16087 invoked from network); 13 May 2022 14:23:32 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 13 May 2022 14:23:32 -0000
Date:   Fri, 13 May 2022 15:23:30 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 0/6] Drain remote per-cpu directly v3
Message-ID: <20220513142330.GI3441@techsingularity.net>
References: <20220512085043.5234-1-mgorman@techsingularity.net>
 <20220512124325.751781bb88ceef5c37ca653e@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20220512124325.751781bb88ceef5c37ca653e@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 12:43:25PM -0700, Andrew Morton wrote:
> On Thu, 12 May 2022 09:50:37 +0100 Mel Gorman <mgorman@techsingularity.net> wrote:
> 
> > Changelog since v2
> > o More conversions from page->lru to page->[pcp_list|buddy_list]
> > o Additional test results in changelogs
> > 
> > Changelog since v1
> > o Fix unsafe RT locking scheme
> > o Use spin_trylock on UP PREEMPT_RT
> > 
> > This series has the same intent as Nicolas' series "mm/page_alloc: Remote
> > per-cpu lists drain support" -- avoid interference of a high priority
> > task due to a workqueue item draining per-cpu page lists. While many
> > workloads can tolerate a brief interruption, it may be cause a real-time
> 
> s/may be/may/
> 
> > task runnning on a NOHZ_FULL CPU to miss a deadline and at minimum,
> 
> s/nnn/nn/
> 

Correct.

> > the draining in non-deterministic.
> 
> s/n/s/;)
> 

Think that one is ok. At least spell check did not complain.

> > Currently an IRQ-safe local_lock protects the page allocator per-cpu lists.
> > The local_lock on its own prevents migration and the IRQ disabling protects
> > from corruption due to an interrupt arriving while a page allocation is
> > in progress. The locking is inherently unsafe for remote access unless
> > the CPU is hot-removed.
> 
> I don't understand the final sentence here.  Which CPU and why does
> hot-removing it make the locking safe?
> 

The sentence can be dropped because it adds little and is potentially
confusing. The PCP being safe to access remotely is specific to the
context of the CPU being hot-removed and there are other special corner
cases like zone_pcp_disable that modifies a per-cpu structure remotely
but not in a way that causes corruption.

-- 
Mel Gorman
SUSE Labs
