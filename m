Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7FCC433FE
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Mar 2022 00:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiCZAFe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Mar 2022 20:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiCZAFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 20:05:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A953DA6C;
        Fri, 25 Mar 2022 17:03:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 28FD3B82AA3;
        Sat, 26 Mar 2022 00:03:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7DABC004DD;
        Sat, 26 Mar 2022 00:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648253017;
        bh=QzEELzBdYZvRzzh2ul/SP1jXaYapXP93Iu4rZJaO5yc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jCzb/7iuIURbovmKKtG1fRNUGlVaUSAvN65iA3eoLKxwEQ7dno4gBuVQjtIQtqTX8
         HsXr7nnBkgkngbjaFB6byFhSmhfCtlFQ/3dEhtpizdIzFg2TI2G4cKgWOyQObxlzEi
         /QMJEMCgEOjHXHMwa2iB/YZYvNv6eS1Qopzgh2pE9+7nSDo1jlbI6GyNKI11R66+AU
         oLLV+BF5R0nQBsCuk/+g2Pnmn3M04/orTQeJPf8K3saDguONmR6uYgepA+QsRXxPfB
         5AjFvnotweldqwJOKo5Ty4wf3XkwWlsB6fIgNU3frw6ntLmnMBb8lf+NR/ci8qfQXd
         AuzqBODgvmwDA==
Date:   Fri, 25 Mar 2022 17:03:37 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [GIT PULL] fs/iomap: Fix buffered write page prefaulting
Message-ID: <20220326000337.GD8182@magnolia>
References: <20220325143701.144731-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325143701.144731-1-agruenba@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 03:37:01PM +0100, Andreas Gruenbacher wrote:
> Hello Linus,
> 
> please consider pulling the following fix, which I've forgotten to send
> in the previous merge window.  I've only improved the patch description
> since.
> 
> Thank you very much,
> Andreas
> 
> The following changes since commit 42eb8fdac2fc5d62392dcfcf0253753e821a97b0:
> 
>   Merge tag 'gfs2-v5.16-rc2-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2 (2021-11-17 15:55:07 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/write-page-prefaulting
> 
> for you to fetch changes up to 631f871f071746789e9242e514ab0f49067fa97a:
> 
>   fs/iomap: Fix buffered write page prefaulting (2022-03-25 15:14:03 +0100)

When was this sent to fsdevel for public consideration?  The last time I
saw any patches related to prefaulting in iomap was November.

--D

> 
> ----------------------------------------------------------------
> Fix buffered write page prefaulting
> 
> ----------------------------------------------------------------
> Andreas Gruenbacher (1):
>       fs/iomap: Fix buffered write page prefaulting
> 
>  fs/iomap/buffered-io.c | 2 +-
>  mm/filemap.c           | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
