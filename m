Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783A8C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jun 2022 01:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbiFNBPB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jun 2022 21:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiFNBO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 21:14:59 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 690E820F73
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 18:14:58 -0700 (PDT)
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id B923520C29A6;
        Mon, 13 Jun 2022 18:14:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B923520C29A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1655169298;
        bh=jv9RhEpcUlvGbL9sQ7elV4SIcD7tvGoqa9vr/gW0wBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IuMF/Gj6OCjwCm1oyiAXJeUN4MMtG+TIxmT7cyh6m1sPL8INXRIPEPydjL6j+B1pw
         4QF2jdYTH2aulyWdGA+3BUKkgiHnZHmhs8/OvXzhWc51r/1iKxB3IowBg5zxs8uTy8
         zt6HbBnQwYRrJvOaUnkM70BzBWr5DjxViV8L9IOo=
Date:   Mon, 13 Jun 2022 20:14:55 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Christian Schoenebeck <linux_oss@crudebyte.com>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/06] fid refcounting improvements and fixes
Message-ID: <20220614011455.GJ7401@sequoia>
References: <20220612085330.1451496-1-asmadeus@codewreck.org>
 <20220613202053.GI7401@sequoia>
 <YqelZWe4BJfDkYEd@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqelZWe4BJfDkYEd@codewreck.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-14 06:00:21, Dominique Martinet wrote:
> Tyler Hicks wrote on Mon, Jun 13, 2022 at 03:20:53PM -0500:
> > On 2022-06-12 17:53:23, Dominique Martinet wrote:
> > > @@ -222,7 +221,8 @@ static struct p9_fid *v9fs_fid_lookup_with_uid(struct dentry *dentry,
> > >                  * We need to hold rename lock when doing a multipath
> > >                  * walk to ensure none of the patch component change
> > >                  */
> > > -               fid = p9_client_walk(old_fid, l, &wnames[i], clone);
> > > +               fid = p9_client_walk(old_fid, l, &wnames[i],
> > > +                                    old_fid == root_fid /* clone */);
> > 
> > This is no problem at all. The rebased patches look good to me. Squash
> > your fix to my fix and it should be ready to go.
> 
> Thanks for all your reviews :)
> I've rebased my branch if you want to check:
> https://github.com/martinetd/linux/commits/9p-next

I've diffed the individual patches from before and after the rebase. It
all looks great to me.

> We've just started a cycle so I'll submit the first three patches (fixes
> to stable) next week, and the rest for when 5.20 cycle starts.

That sounds like the right plan to me.

> Feel free to remind me if it looks like I forgot.

Will do!

Tyler

> -- 
> Dominique
> 
