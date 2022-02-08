Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0FFC433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Feb 2022 13:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345133AbiBHNTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Feb 2022 08:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349783AbiBHMNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 07:13:19 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E10C03FEC0;
        Tue,  8 Feb 2022 04:13:16 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7554C1F383;
        Tue,  8 Feb 2022 12:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644322395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QLOYwEHWVSzw5MCgmxkNKcSwN+xc3CSk3rKsHEFXQ0w=;
        b=umK5/28r4Ry0plkxqSGj9jm/h56veWrz8pKMp5ppf56ETUdrsuH1hb86FdlcFXeoSoulaz
        lFOqeYg0yKPsQLWHc2dl8AHyW3Z0SGNQaJUUnjkpcUPE824yWe2B0B5R3iQOcbdFzLrhCJ
        ik3wNbCbeuoS3QIUfYl3YJI1RMqv5xo=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D93CAA3B8C;
        Tue,  8 Feb 2022 12:13:14 +0000 (UTC)
Date:   Tue, 8 Feb 2022 13:13:14 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Ira Weiny <ira.weiny@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <guro@fb.com>,
        Rafael Aquini <aquini@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v5 3/4] mm/page_owner: Print memcg information
Message-ID: <YgJeWth50eP9L0PK@dhcp22.suse.cz>
References: <20220208000532.1054311-1-longman@redhat.com>
 <20220208000532.1054311-4-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208000532.1054311-4-longman@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 07-02-22 19:05:31, Waiman Long wrote:
> It was found that a number of dying memcgs were not freed because
> they were pinned by some charged pages that were present. Even "echo 1 >
> /proc/sys/vm/drop_caches" wasn't able to free those pages. These dying
> but not freed memcgs tend to increase in number over time with the side
> effect that percpu memory consumption as shown in /proc/meminfo also
> increases over time.

I still believe that this is very suboptimal way to debug offline memcgs
but memcg information can be useful in other contexts and it doesn't
cost us anything except for an additional output so I am fine with this.
 
> In order to find out more information about those pages that pin
> dying memcgs, the page_owner feature is extended to print memory
> cgroup information especially whether the cgroup is dying or not.
> RCU read lock is taken when memcg is being accessed to make sure
> that it won't be freed.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> Acked-by: David Rientjes <rientjes@google.com>
> Acked-by: Roman Gushchin <guro@fb.com>
> Acked-by: Mike Rapoport <rppt@linux.ibm.com>

With few comments/questions below.

> ---
>  mm/page_owner.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index 28dac73e0542..d4c311455753 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -10,6 +10,7 @@
>  #include <linux/migrate.h>
>  #include <linux/stackdepot.h>
>  #include <linux/seq_file.h>
> +#include <linux/memcontrol.h>
>  #include <linux/sched/clock.h>
>  
>  #include "internal.h"
> @@ -325,6 +326,47 @@ void pagetypeinfo_showmixedcount_print(struct seq_file *m,
>  	seq_putc(m, '\n');
>  }
>  
> +/*
> + * Looking for memcg information and print it out
> + */

I am not sure this is particularly useful comment.

> +static inline int print_page_owner_memcg(char *kbuf, size_t count, int ret,
> +					 struct page *page)
> +{
> +#ifdef CONFIG_MEMCG
> +	unsigned long memcg_data;
> +	struct mem_cgroup *memcg;
> +	bool dying;
> +
> +	rcu_read_lock();
> +	memcg_data = READ_ONCE(page->memcg_data);
> +	if (!memcg_data)
> +		goto out_unlock;
> +
> +	if (memcg_data & MEMCG_DATA_OBJCGS)
> +		ret += scnprintf(kbuf + ret, count - ret,
> +				"Slab cache page\n");
> +
> +	memcg = page_memcg_check(page);
> +	if (!memcg)
> +		goto out_unlock;
> +
> +	dying = (memcg->css.flags & CSS_DYING);

Is there any specific reason why you haven't used mem_cgroup_online?

> +	ret += scnprintf(kbuf + ret, count - ret,
> +			"Charged %sto %smemcg ",
> +			PageMemcgKmem(page) ? "(via objcg) " : "",
> +			dying ? "dying " : "");
> +
> +	/* Write cgroup name directly into kbuf */
> +	cgroup_name(memcg->css.cgroup, kbuf + ret, count - ret);
> +	ret += strlen(kbuf + ret);

cgroup_name should return the length of the path added to the buffer.

> +	ret += scnprintf(kbuf + ret, count - ret, "\n");

I do not see any overflow prevention here. I believe you really need to
check ret >= count after each scnprintf/cgroup_name.
-- 
Michal Hocko
SUSE Labs
