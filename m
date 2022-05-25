Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE4BC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 25 May 2022 01:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243200AbiEYBaz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 May 2022 21:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237663AbiEYBax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 21:30:53 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE1D712FB;
        Tue, 24 May 2022 18:30:51 -0700 (PDT)
Date:   Tue, 24 May 2022 18:30:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1653442249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BqHyQcO/EPCHDY1xe0+4wActLlHOlU2jbcY6btA4FPI=;
        b=IqC3gfAEusYUngfhPDQZyN41hUHpicr6FUJlsvV9XN4K1/O31k7g3yqgW6376yJbiURLyW
        20n5GAtkF2694sJcddZ7ypbG6LGvwlQK2WiFktmvfV+7xQdG77X9Z7kjg5F/Re/LmpS5+Q
        s23gJXYBOL5RQRc5tIVrC07aijyGkHk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH mm v2 5/9] memcg: enable accounting for percpu allocation
 of struct psi_group_cpu
Message-ID: <Yo2Gw8b09efUWimi@carbon>
References: <Yn6aL3cO7VdrmHHp@carbon>
 <16f17021-61a3-c6f4-f60c-1acd3a0b66b9@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16f17021-61a3-c6f4-f60c-1acd3a0b66b9@openvz.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2022 at 07:38:21PM +0300, Vasily Averin wrote:
> struct pci_group_cpu is percpu allocated for each new cgroup and can
> consume a significant portion of all allocated memory on nodes with
> a large number of CPUs.
> 
> Common part of the cgroup creation:
> Allocs  Alloc   $1*$2   Sum     Allocation
> number  size
> --------------------------------------------
> 16  ~   352     5632    5632    KERNFS
> 1   +   4096    4096    9728    (cgroup_mkdir+0xe4)
> 1       584     584     10312   (radix_tree_node_alloc.constprop.0+0x89)
> 1       192     192     10504   (__d_alloc+0x29)
> 2       72      144     10648   (avc_alloc_node+0x27)
> 2       64      128     10776   (percpu_ref_init+0x6a)
> 1       64      64      10840   (memcg_list_lru_alloc+0x21a)
> percpu:
> 1   +   192     192     192     call_site=psi_cgroup_alloc+0x1e
> 1   +   96      96      288     call_site=cgroup_rstat_init+0x5f
> 2       12      24      312     call_site=percpu_ref_init+0x23
> 1       6       6       318     call_site=__percpu_counter_init+0x22
> 
>  '+' -- to be accounted,
>  '~' -- partially accounted
> 
> Signed-off-by: Vasily Averin <vvs@openvz.org>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
