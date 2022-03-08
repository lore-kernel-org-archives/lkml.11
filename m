Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797CBC433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Mar 2022 13:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244756AbiCHNuB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Mar 2022 08:50:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiCHNt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 08:49:59 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E347A1C129;
        Tue,  8 Mar 2022 05:49:02 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9A7F21F397;
        Tue,  8 Mar 2022 13:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646747341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SyTgM5F6+9CT4oBrYUK4bC/XMWpEt2BZNDE3I1Sk7Ys=;
        b=SOLJf8KzF3lpV2Z1nK2RtJ/mCHih8E/LOT3+NtV9WjuFZrbvkvNGfz9md9KsmuMAmYb4xl
        mrgfppZj4eTymdy2LnRjU7ToP7z5QKvHD+Fb5G9Y3hGjHgDOXnP7/F9d/3dhoWrdQoV6gE
        PQ9kK/Trd67H0yxar7509l2hpkGD6SA=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6A0E5A3B85;
        Tue,  8 Mar 2022 13:49:01 +0000 (UTC)
Date:   Tue, 8 Mar 2022 14:49:01 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH 2/3] mm: use vmalloc_array and vcalloc for array
 allocations
Message-ID: <YidezSPVZBCQcGJ4@dhcp22.suse.cz>
References: <20220308105918.615575-1-pbonzini@redhat.com>
 <20220308105918.615575-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308105918.615575-3-pbonzini@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 08-03-22 05:59:17, Paolo Bonzini wrote:
> Instead of using array_size or just a multiply, use a function that
> takes care of both the multiplication and the overflow checks.
> 
> Cc: linux-mm@kvack.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>

The resulting code is easier to read indeed.

> ---
>  mm/percpu-stats.c | 2 +-
>  mm/swap_cgroup.c  | 4 +---
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/percpu-stats.c b/mm/percpu-stats.c
> index c6bd092ff7a3..e71651cda2de 100644
> --- a/mm/percpu-stats.c
> +++ b/mm/percpu-stats.c
> @@ -144,7 +144,7 @@ static int percpu_stats_show(struct seq_file *m, void *v)
>  	spin_unlock_irq(&pcpu_lock);
>  
>  	/* there can be at most this many free and allocated fragments */
> -	buffer = vmalloc(array_size(sizeof(int), (2 * max_nr_alloc + 1)));
> +	buffer = vmalloc_array(2 * max_nr_alloc + 1, sizeof(int));
>  	if (!buffer)
>  		return -ENOMEM;
>  
> diff --git a/mm/swap_cgroup.c b/mm/swap_cgroup.c
> index 7f34343c075a..5a9442979a18 100644
> --- a/mm/swap_cgroup.c
> +++ b/mm/swap_cgroup.c
> @@ -167,14 +167,12 @@ unsigned short lookup_swap_cgroup_id(swp_entry_t ent)
>  int swap_cgroup_swapon(int type, unsigned long max_pages)
>  {
>  	void *array;
> -	unsigned long array_size;
>  	unsigned long length;
>  	struct swap_cgroup_ctrl *ctrl;
>  
>  	length = DIV_ROUND_UP(max_pages, SC_PER_PAGE);
> -	array_size = length * sizeof(void *);
>  
> -	array = vzalloc(array_size);
> +	array = vcalloc(length, sizeof(void *));
>  	if (!array)
>  		goto nomem;
>  
> -- 
> 2.31.1
> 
> 

-- 
Michal Hocko
SUSE Labs
