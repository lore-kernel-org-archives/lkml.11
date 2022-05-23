Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EAEC433FE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 May 2022 18:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241109AbiEWSfh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 May 2022 14:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241274AbiEWSfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 14:35:04 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD41035ABD
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 11:12:51 -0700 (PDT)
Date:   Mon, 23 May 2022 11:12:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1653329538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q1YI4UvJq+RWDZGSirVLxbIlT+BTHHqOR7zZ/+4VaG0=;
        b=UbheU5PmTAzA+/TY4MyvYTNIp3BVm0Hga9iFXmev+TjZfDbs6yzGwrYgzvQJTBTJ9RbmnL
        NSvFACzXU2soEuy2q7l6WoleteCCASk/eCQ2IgwVnwfkGo303DSDuboNuZ1EDqBRtJKX2J
        8e88A2HsElu6//96aMDMtFko+gwIiLE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v3 1/6] mm: memcontrol: introduce mem_cgroup_ino() and
 mem_cgroup_get_from_ino()
Message-ID: <YovOfEdoGHClHUK+@carbon>
References: <20220509183820.573666-1-roman.gushchin@linux.dev>
 <20220509183820.573666-2-roman.gushchin@linux.dev>
 <YongvYP26K2hZ3Sf@FVFYT0MHHV2J.usts.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YongvYP26K2hZ3Sf@FVFYT0MHHV2J.usts.net>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 22, 2022 at 03:05:33PM +0800, Muchun Song wrote:
> On Mon, May 09, 2022 at 11:38:15AM -0700, Roman Gushchin wrote:
> > Shrinker debugfs requires a way to represent memory cgroups without
> > using full paths, both for displaying information and getting input
> > from a user.
> > 
> > Cgroup inode number is a perfect way, already used by bpf.
> > 
> > This commit adds a couple of helper functions which will be used
> > to handle memcg-aware shrinkers.
> > 
> > Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> > ---
> >  include/linux/memcontrol.h | 21 +++++++++++++++++++++
> >  mm/memcontrol.c            | 23 +++++++++++++++++++++++
> >  2 files changed, 44 insertions(+)
> > 
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index fe580cb96683..a6de9e5c1549 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -831,6 +831,15 @@ static inline unsigned short mem_cgroup_id(struct mem_cgroup *memcg)
> >  }
> >  struct mem_cgroup *mem_cgroup_from_id(unsigned short id);
> >  
> > +#ifdef CONFIG_SHRINKER_DEBUG
> > +static inline unsigned long mem_cgroup_ino(struct mem_cgroup *memcg)
> > +{
> > +	return memcg ? cgroup_ino(memcg->css.cgroup) : 0;
> > +}
> > +
> > +struct mem_cgroup *mem_cgroup_get_from_ino(unsigned long ino);
> > +#endif
> > +
> >  static inline struct mem_cgroup *mem_cgroup_from_seq(struct seq_file *m)
> >  {
> >  	return mem_cgroup_from_css(seq_css(m));
> > @@ -1324,6 +1333,18 @@ static inline struct mem_cgroup *mem_cgroup_from_id(unsigned short id)
> >  	return NULL;
> >  }
> >  
> > +#ifdef CONFIG_SHRINKER_DEBUG
> > +static inline unsigned long mem_cgroup_ino(struct mem_cgroup *memcg)
> > +{
> > +	return 0;
> > +}
> > +
> > +static inline struct mem_cgroup *mem_cgroup_get_from_ino(unsigned long ino)
> > +{
> > +	return NULL;
> > +}
> > +#endif
> > +
> >  static inline struct mem_cgroup *mem_cgroup_from_seq(struct seq_file *m)
> >  {
> >  	return NULL;
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 04cea4fa362a..e6472728fa66 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -5018,6 +5018,29 @@ struct mem_cgroup *mem_cgroup_from_id(unsigned short id)
> >  	return idr_find(&mem_cgroup_idr, id);
> >  }
> >  
> > +#ifdef CONFIG_SHRINKER_DEBUG
> > +struct mem_cgroup *mem_cgroup_get_from_ino(unsigned long ino)
> > +{
> > +	struct cgroup *cgrp;
> > +	struct cgroup_subsys_state *css;
> > +	struct mem_cgroup *memcg;
> > +
> > +	cgrp = cgroup_get_from_id(ino);
> > +	if (!cgrp)
> > +		return ERR_PTR(-ENOENT);
> > +
> > +	css = cgroup_get_e_css(cgrp, &memory_cgrp_subsys);
> > +	if (css)
> > +		memcg = container_of(css, struct mem_cgroup, css);
> > +	else
> > +		memcg = ERR_PTR(-ENOENT);
> > +
> > +	cgroup_put(cgrp);
> 
> I think it's better to use css_put() here since the refcount is get
> via cgroup_get_e_css() which returns a css struct.

cgroup_put() is matching cgroup_get_from_id().

The reference grabbed by cgroup_get_e_css() shouldn't be dropped
because mem_cgroup_get_from_ino() has a "get" semantics.

Thanks!
