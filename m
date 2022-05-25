Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7E9C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 May 2022 01:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243221AbiEYBb4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 May 2022 21:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241183AbiEYBby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 21:31:54 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD62442EC7;
        Tue, 24 May 2022 18:31:52 -0700 (PDT)
Date:   Tue, 24 May 2022 18:31:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1653442310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vkgpgq0MLg/tjJXAvXd1NI0cnHVkERy6akx7DcAkEY8=;
        b=IckRGymn51W5KSkNLGKDTL/8V3vl12R//mkoxvsoP3gyy98tW7DHo1FA4F0p1ga9sRz5TD
        6FYxnT9//JecprFOB8jLgzbj00ug3+uTTxnUvnTh6E7aRsBziP72fgAqvxAnQoepov4Cae
        Dv4kVvVHCn1BGd7fheY1UI98MFBbRYM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH mm v2 9/9] memcg: enable accounting for percpu allocation
 of struct rt_rq
Message-ID: <Yo2HAGmySUVABVkt@carbon>
References: <Yn6aL3cO7VdrmHHp@carbon>
 <d7094aa2-1cd0-835c-9fb7-d76003c47dad@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7094aa2-1cd0-835c-9fb7-d76003c47dad@openvz.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2022 at 07:39:03PM +0300, Vasily Averin wrote:
> If enabled in config, alloc_rt_sched_group() is called for each new
> cpu cgroup and allocates a huge (~1700 bytes) percpu struct rt_rq.
> This significantly exceeds the size of the percpu allocation in the
> common part of cgroup creation.
> 
> Memory allocated during new cpu cgroup creation
> (with enabled RT_GROUP_SCHED):
> common part:    ~11Kb   +   318 bytes percpu
> cpu cgroup:     ~2.5Kb  + ~2800 bytes percpu
> 
> Accounting for this memory helps to avoid misuse inside memcg-limited
> contianers.
> 
> Signed-off-by: Vasily Averin <vvs@openvz.org>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
