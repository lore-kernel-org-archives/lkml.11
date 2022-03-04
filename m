Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1486C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Mar 2022 18:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241514AbiCDSFf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Mar 2022 13:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241495AbiCDSF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 13:05:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3B13B002;
        Fri,  4 Mar 2022 10:04:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACC1C60C77;
        Fri,  4 Mar 2022 18:04:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 033D5C340EF;
        Fri,  4 Mar 2022 18:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646417077;
        bh=425WNeNRrB56ZehLPxE5ZW7E9I6KVwqgV1Gf1LwYGgU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VfNnOKYkOxwckoxihS5Rta454esEJDsTkWgg9wJWLJVLhOVDynvrbtVzlU0YBZov/
         zGz8K9qJr4ix5z++KXTQPeRFY/+AK03Ks++ginvyjzH+j2IenDsU7WcTnMqE3s3MSw
         CMbhtzkgi+YrcJ2X28HyeMO0/HIQuTPSpRu8f/hjsFvHA5TkNtoNpR6lSSznJEShXo
         /WfW3wFIoBXrpAGRZFYuNm7T9lKowvITbuWjBH56Porp703MrASmRKLxx65wUOrdRl
         aDEV7eNzX3SZGv41egNvXofXb/gMQ9pQuLyPSp01QXmalMUlbiMO+Xc/7dzjfgrzhx
         jXsOtehfpCZjg==
Date:   Fri, 4 Mar 2022 10:04:35 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: do not try to evict inode when super is frozen
Message-ID: <YiJUsxjoHNiqEaFG@google.com>
References: <20220304022104.2525009-1-jaegeuk@kernel.org>
 <20220304024843.GK3927073@dread.disaster.area>
 <YiGgSmEOZUvgmSto@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiGgSmEOZUvgmSto@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03, Jaegeuk Kim wrote:
> On 03/04, Dave Chinner wrote:
> > On Thu, Mar 03, 2022 at 06:21:04PM -0800, Jaegeuk Kim wrote:
> > > Otherwise, we will get a deadlock.
> > 
> > NACK.
> > 
> > We have to be able to evict clean inodes from memory on frozen
> > inodes because we can still instantiate inodes while the filesytem
> > is frozen. e.g. there's a find running when the filesystem is
> > frozen. What happens if we can't evict clean cached inodes from
> > memory when we run out of memory trying to instantiate new inodes?
> 
> Ok, that makes sense.
> 
> > 
> > > 
> > > [freeze test]                         shrinkder
> > > freeze_super
> > >  - pwercpu_down_write(SB_FREEZE_FS)
> > >                                        - super_cache_scan
> > >                                          - down_read(&sb->s_umount)
> > >                                            - prune_icache_sb
> > >                                             - dispose_list
> > >                                              - evict
> > >                                               - f2fs_evict_inode
> > > thaw_super
> > >  - down_write(&sb->s_umount);
> > >                                               - __percpu_down_read(SB_FREEZE_FS)
> > 
> > That seems like a f2fs bug, not a generic problem.
> > 
> > Filesystems already have to handle stuff like this if an unlinked
> > file is closed while the fs is frozen - we have to handle inode
> > eviction needing to modify the file, and different filesystems
> > handle this differently. Most filesystems simply block in
> > ->evict_inode in this case, but this never occurs from the shrinker
> > context.
> > 
> > IOWs, the shrinker should never be evicting inodes that require the
> > filesystem to immediately block on frozen filesystems. If you have
> > such inodes in cache at the time the filesystem is frozen, then they
> > should be purged from the cache as part of the freeze process so the
> > shrinker won't ever find inodes that it could deadlock on.
> 
> If so, is this a bug in drop_caches_sysctl_handler? Or, I shouldn't have
> used "echo 3 > sysfs/drop_caches" with freezefs in xfstests?

My bad. I totally misunderstood. I'm testing a patch to call evict_inodes()
in f2fs_freeze(). Thank you for the comment. :)

> 
> > 
> > Cheers,
> > 
> > Dave.
> > -- 
> > Dave Chinner
> > david@fromorbit.com
