Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD78C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Apr 2022 18:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353732AbiDSSxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Apr 2022 14:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbiDSSxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 14:53:36 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BB13D4B4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 11:50:52 -0700 (PDT)
Date:   Tue, 19 Apr 2022 11:50:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1650394251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z5GW4a8wABiS59/ZTgTPVQRXCf8XswJ73zIFmnBfAHI=;
        b=mwg+Z8nz95vbDEBX04x0Sh0igz6CXGr3uet+JlRjb3o5as9hAg+g/KqOEucZbMB+ttb8JC
        2jFNWMEFHQj6UpiSuxEv/j5dKVgkdMbVQUWWejzzIjutqzfNOQoCZK7oTR7xOCx4g2wnJu
        DyxVCTpkDBrZfj7Ct+fcDgx9g21E/i0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH rfc 0/5] mm: introduce shrinker sysfs interface
Message-ID: <Yl8EhZIbePmlmJ6D@carbon>
References: <20220416002756.4087977-1-roman.gushchin@linux.dev>
 <20220419183654.axbxcjehs6fpqg4z@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419183654.axbxcjehs6fpqg4z@moria.home.lan>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 02:36:54PM -0400, Kent Overstreet wrote:
> On Fri, Apr 15, 2022 at 05:27:51PM -0700, Roman Gushchin wrote:
> > 7) Don't display cgroups with less than 500 attached objects
> >   $ echo 500 > count_memcg
> >   $ cat count_memcg
> >     53 817
> >     1868 886
> >     2396 799
> >     2462 861
> > 
> > 8) Don't display cgroups with less than 500 attached objects (sum over all nodes)
> >   $ echo "500" > count_memcg_node
> >   $ cat count_memcg_node
> >     53 810 7
> >     1868 886 0
> >     2396 799 0
> >     2462 861 0
> > 
> > 9) Scan system/root shrinker
> >   $ cat count
> >     212
> >   $ echo 100 > scan
> >   $ cat scan
> >     97
> >   $ cat count
> >     115
> 
> This part seems entirely overengineered though and a really bad idea - can we
> please _not_ store query state in the kernel? It's not thread safe, and it seems
> like overengineering before we've done the basics (just getting this stuff in
> sysfs is a major improvement!).

Yes, it's not great, but I don't have a better idea yet. How to return the number
of freed objects? Do you suggest to drop this functionality at all or there are
other options I'm not seeing?

Counting again isn't a good option either: new object could have been added to
the list during the scan.

Thanks!
