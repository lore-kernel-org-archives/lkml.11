Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA8AC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Mar 2022 04:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiCIErm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Mar 2022 23:47:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiCIErk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 23:47:40 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F14ECC60
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 20:46:41 -0800 (PST)
Date:   Tue, 8 Mar 2022 20:46:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1646801200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pwPV72PK1nbe959AqXG9dY/mbkFvNIqcqS9VHLE0tU8=;
        b=QtHSuJVvrFTsqhCvASuavohNw4WO/ZWGycg0/KZlAj3qVCXoZ8XMbkRahm41T0E4b7/lbs
        utpz03UkJt10RFWA//YLsfZxseA31jqI3uM/T8MWVY+efOFjniVPBkVtZREm/S6SVrCCFk
        TcTozsytGmI9G8rVj3Z7B14RjvBIb54=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH-mm v2] mm/list_lru: Optimize
 memcg_reparent_list_lru_node()
Message-ID: <YigxKUONWa4iBYvk@carbon.dhcp.thefacebook.com>
References: <20220309011824.1454619-1-longman@redhat.com>
 <YigNVbz/h8wzNjs/@carbon.dhcp.thefacebook.com>
 <54ea34a9-e261-3521-ce11-efc59c9a803c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54ea34a9-e261-3521-ce11-efc59c9a803c@redhat.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 10:12:48PM -0500, Waiman Long wrote:
> On 3/8/22 21:13, Roman Gushchin wrote:
> > On Tue, Mar 08, 2022 at 08:18:24PM -0500, Waiman Long wrote:
> > > Since commit 2c80cd57c743 ("mm/list_lru.c: fix list_lru_count_node()
> > > to be race free"), we are tracking the total number of lru
> > > entries in a list_lru_node in its nr_items field.  In the case of
> > > memcg_reparent_list_lru_node(), there is nothing to be done if nr_items
> > > is 0.  We don't even need to take the nlru->lock as no new lru entry
> > > could be added by a racing list_lru_add() to the draining src_idx memcg
> > > at this point.
> > > 
> > > Signed-off-by: Waiman Long <longman@redhat.com>
> > > ---
> > >   mm/list_lru.c | 6 ++++++
> > >   1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/mm/list_lru.c b/mm/list_lru.c
> > > index ba76428ceece..c669d87001a6 100644
> > > --- a/mm/list_lru.c
> > > +++ b/mm/list_lru.c
> > > @@ -394,6 +394,12 @@ static void memcg_reparent_list_lru_node(struct list_lru *lru, int nid,
> > >   	int dst_idx = dst_memcg->kmemcg_id;
> > >   	struct list_lru_one *src, *dst;
> > > +	/*
> > > +	 * If there is no lru entry in this nlru, we can skip it immediately.
> > > +	 */
> > > +	if (!READ_ONCE(nlru->nr_items))
> > > +		return;
> > This is a per-node counter, not a per-memcg, right?
> Right. list_lru_node is a per-node structure inside list_lru.
> > If so, do we optimize for the case when all lru items belong to one node and
> > others are empty?
> 
> That is actually the case that I am trying to optimize for.
> 
> If a system has many containers. It is also likely each container may mount
> one or more container specific filesystems. Since a container likely use
> just a few cpus, it is highly that only the list_lru_node that contains
> those cpus will be utilized while the rests may be empty.
> 
> I got the idea of doing this patch when I was looking at a crash dump
> related to the list_lru code. That particular crash dump has more than 13k
> list_lru's and thousands of mount points. I had notice even if nr_items of a
> list_lru_node is 0, it still tries to transfer lru entries from source idx
> to dest idx. Without doing an lock/unlock and loading a cacheline from the
> memcg_lrus, it can save some time. That can be substantial saving if we are
> talking about thousands of list_lru's.

Cool! Makes total sense to me. Thanks for the explanation!
Would you mind to add this text to the commit log?

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!
