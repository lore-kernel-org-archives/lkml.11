Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A503C43334
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jun 2022 18:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350022AbiFJSKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jun 2022 14:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244325AbiFJSK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 14:10:29 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAB03AA44
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 11:10:26 -0700 (PDT)
Date:   Fri, 10 Jun 2022 11:10:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1654884625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qAyA4nVQ3p7uKrJGV4R46+Hc3Djv7YaeqsyLHwIro7A=;
        b=KVgqw1Q+X/yrYv/cdlwmVUcIKnY1kS/vhacw80yfaU1AE9UERt6GHhn6f652u3AvkkY2TR
        8XPPmFXB6bYilGEhZtMRp5bFYd4rrxA+lbifusIkpkQ71WRdNgvRrAPwTOjOtop7oiNxO0
        xBhs5G5qlf9+f3pgpv2n8trr2XjF6ws=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Vasily Averin <vvs@openvz.org>,
        Qian Cai <quic_qiancai@quicinc.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Shakeel Butt <shakeelb@google.com>
Subject: Re: [PATCH] mm: kmem: make mem_cgroup_from_obj() vmalloc()-safe
Message-ID: <YqOJBy2kHRJj/uLB@carbon>
References: <20220610180310.1725111-1-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610180310.1725111-1-roman.gushchin@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 11:03:10AM -0700, Roman Gushchin wrote:
> Currently mem_cgroup_from_obj() is not working properly with objects
> allocated using vmalloc(). It creates problems in some cases, when
> it's called for static objects belonging to  modules or generally
> allocated using vmalloc().
> 
> This patch makes mem_cgroup_from_obj() safe to be called on objects
> allocated using vmalloc().
> 
> It also introduces mem_cgroup_from_slab_obj(), which is a faster
> version to use in places when we know the object is either a slab
> object or a generic slab page (e.g. when adding an object to a lru
> list).
> 
> Suggested-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Acked-by: Shakeel Butt <shakeelb@google.com>

Andrew,

this patch is supposed to fix boot issues on arm introduced by
the commit "net: set proper memcg for net_init hooks allocations".

But as no I don't see this commit in linux-next or any mm branches,
so I'm not sure if it's in stable or not. So I didn't add the Fixes
tag. If it isn't in stable yet, I'd just put the fix before the problematic
commit.

Thank you!
