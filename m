Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4C6C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 27 May 2022 00:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244409AbiE0ADV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 May 2022 20:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbiE0ADS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 20:03:18 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C60EDA7E06
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 17:03:17 -0700 (PDT)
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 058F620B71D5;
        Thu, 26 May 2022 17:03:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 058F620B71D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1653609797;
        bh=mb7ZmAlHuvpGG1PgGVfmZd0atD/az5Ujm7IAFCqlmoA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jY8QzXrXgGOW0gAgEvQQvb1opiIRTxJeqZtvZeFEy9cpJKs0JXN7Gv9/dbw12aSg7
         zba1klecrk8VGRGEvghsuOwuw6e1rZ4SiG481RRrnYs69kpq2KtoL81x47gVH7UDe/
         p8xUfk3Tp6J1/gT3Lq9g0xR+bW/Wecu/qWOWjbaQ=
Date:   Thu, 26 May 2022 19:03:12 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     Christian Schoenebeck <linux_oss@crudebyte.com>,
        Jianyong Wu <jianyong.wu@arm.com>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 9p: Fix refcounting during full path walks for fid
 lookups
Message-ID: <20220527000312.GB15462@sequoia>
References: <20220525182530.266068-1-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525182530.266068-1-tyhicks@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-25 13:25:30, Tyler Hicks wrote:
> Decrement the refcount of the parent dentry's fid after walking
> each path component during a full path walk for a lookup. Failure to do
> so can lead to fids that are not clunked until the filesystem is
> unmounted, as indicated by this warning:
> 
>  9pnet: found fid 3 not clunked
> 
> The improper refcounting after walking resulted in open(2) returning
> -EIO on any directories underneath the mount point when using the virtio
> transport. When using the fd transport, there's no apparent issue until
> the filesytem is unmounted and the warning above is emitted to the logs.
> 
> In some cases, the user may not yet be attached to the filesystem and a
> new root fid, associated with the user, is created and attached to the
> root dentry before the full path walk is performed. Increment the new
> root fid's refcount to two in that situation so that it can be safely
> decremented to one after it is used for the walk operation. The new fid
> will still be attached to the root dentry when
> v9fs_fid_lookup_with_uid() returns so a final refcount of one is
> correct/expected.
> 
> Include a small readability improvement by using a new variable when
> dealing with the root fid as it requires special handling not necessary
> with non-root fids.
> 
> Fixes: 6636b6dcc3db ("9p: add refcount to p9_fid struct")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>

This patch was doing a little too much code cleanup when it should have
just been fixing the bug. v2 has a patch just focused on fixing the bug
followed by additional patches for code cleanup:

 https://lore.kernel.org/lkml/20220527000003.355812-1-tyhicks@linux.microsoft.com/

Sorry for the churn but v1 wasn't sitting well with me.

Tyler
