Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D12C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Apr 2022 16:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346560AbiDARBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Apr 2022 13:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236099AbiDARBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 13:01:00 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E5010DA40;
        Fri,  1 Apr 2022 09:59:10 -0700 (PDT)
Date:   Fri, 1 Apr 2022 09:58:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1648832348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=opfMZhT1sWWFuxdmOUhDIsbcAFNmM7W5eVe4Jw4U7ZY=;
        b=GGASatQNi5+qmdKAN6sT/OaTjH+8x2+DckJQyi+9uL68dpIUK0DZxNUnLw/yu8t3k5scnA
        REFoIo1PPbilRLGJ/+iT7OlAQX+BGS5NsW0eaE67YBrb0zG3/dZOa3OiZ/up5QEd9hTrEn
        xQ54UriLGceRv5Ztvya2fXB8qCs3fxg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Jonathan Corbet <corbet@lwn.net>, Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>
Subject: Re: [PATCH resend] memcg: introduce per-memcg reclaim interface
Message-ID: <YkcvU2hosJV3cL8F@carbon.dhcp.thefacebook.com>
References: <20220331084151.2600229-1-yosryahmed@google.com>
 <YkXkA+Oh1Bx33PrU@carbon.dhcp.thefacebook.com>
 <YkcC3z5ReeQ5vdg9@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkcC3z5ReeQ5vdg9@dhcp22.suse.cz>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2022 at 03:49:19PM +0200, Michal Hocko wrote:
> On Thu 31-03-22 10:25:23, Roman Gushchin wrote:
> > On Thu, Mar 31, 2022 at 08:41:51AM +0000, Yosry Ahmed wrote:
> [...]
> > > - A similar per-node interface can also be added to support proactive
> > >   reclaim and reclaim-based demotion in systems without memcg.
> > 
> > Maybe an option to specify a timeout? That might simplify the userspace part.
> 
> What do you mean by timeout here? Isn't
> timeout $N echo $RECLAIM > ....
> 
> enough?

It's nice and simple when it's a bash script, but when it's a complex
application trying to do the same, it quickly becomes less simple and
likely will require a dedicated thread to avoid blocking the main app
for too long and a mechanism to unblock it by timer/when the need arises.

In my experience using correctly such semi-blocking interfaces (semi- because
it's not clearly defined how much time the syscall can take and whether it
makes sense to wait longer) is tricky.
