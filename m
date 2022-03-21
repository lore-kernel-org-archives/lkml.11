Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAA8C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Mar 2022 20:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353454AbiCUUkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Mar 2022 16:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353445AbiCUUj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 16:39:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2743A114D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 13:38:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AEA1FB819DF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 20:38:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31668C340E8;
        Mon, 21 Mar 2022 20:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1647895106;
        bh=OG92xJeUwmKMGHqIl3VXi668zYVeg8l5O+7ghW3iQkY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0cxr2THZKnIss7cBYqAUzeIZ7n24+n520EMDWb0IJfAESx3xD+YqkutRB9mtW7myn
         DN/wvEBRvR43A38ZEaJsNmxSxHxONialgBFaKpU2wxswPlRZ/OGJveVpSOXYSYYaeq
         a2FBcCKgkPPcHWVmLt1kVzAKMGgGELnqEW3Bl0MU=
Date:   Mon, 21 Mar 2022 13:38:25 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sean Anderson <seanga2@gmail.com>
Cc:     Yinan Zhang <zhangyinan2019@email.szu.edu.cn>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/vm/page_owner_sort.c: add switch between culling
 by stacktrace and txt
Message-Id: <20220321133825.6f003c62381edbab361a8d96@linux-foundation.org>
In-Reply-To: <f0a8099b-3c60-3e34-078a-be3c1280ca61@gmail.com>
References: <20211129145658.2491-1-zhangyinan2019@email.szu.edu.cn>
        <f0a8099b-3c60-3e34-078a-be3c1280ca61@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


These comments were not responded to:

On Mon, 29 Nov 2021 21:23:41 -0500 Sean Anderson <seanga2@gmail.com> wrote:
> 
> This is working as designed. IMO there's no point in separating
> allocations like this which differ only in PID and timestamp, since you
> will get no grouping at all.
> 
> > The info of second block missed. So, add -c to turn on culling
> > by stacktrace. By default, it will cull by txt.
> 
> Please keep the default to actually do something in the cull step.
> 
> ...
>
> > @@ -162,6 +171,9 @@ int main(int argc, char **argv)
> >   		case 't':
> >   			cmp = compare_num;
> >   			break;
> > +		case 'c':
> > +			cull_st = 1;
> > +			break;
> 
> Can we set a "cull_cmp" variable like cmp?
> 
> Looking forward, I think something like
> 
> 	page_owner_sort --cull=stacktrace --sort=times foo bar
> 
> would be nice.
> 

Which is unfortunate.   

I'll send the patch in to Linus anyway, as many other patches
syntactically depend on it.  Please work with Sean to address these
issues and lets get this resolved over the next few weeks.

Also, please cc linux-mm@kvack.org on changes to page_owner.
