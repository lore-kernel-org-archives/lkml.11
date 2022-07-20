Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3C0C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jul 2022 21:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiGTVkw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jul 2022 17:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbiGTVku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 17:40:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697983FA34;
        Wed, 20 Jul 2022 14:40:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D6EBB8221B;
        Wed, 20 Jul 2022 21:40:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B47C3411E;
        Wed, 20 Jul 2022 21:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1658353245;
        bh=7XuH7C9AhIntdSNJNhHosxKJ9hRS8mRPfx3X8t/atZk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LdY28aGkgydx6KxOxb5dIocrXmbA2hZlVCgkplPZp3/Ps3rAaxhInuWlf/0eFKhEv
         rnMG66FrnUKFP84oAq+gjRbkNoo5Ch6IqBVwi9YPtRN0uYsPiBTRIvU0o/jRl32n/A
         Rxnlp7cfx2Zv5NDtSsikL7QQTtRW7xGDUIPTav4M=
Date:   Wed, 20 Jul 2022 14:40:44 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     alexs@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc/vm: move overcommit-accounting doc to admin-guide
Message-Id: <20220720144044.0cd2757be75fe00d198394f1@linux-foundation.org>
In-Reply-To: <874jzbo4x5.fsf@meer.lwn.net>
References: <20220714055142.214728-1-alexs@kernel.org>
        <874jzbo4x5.fsf@meer.lwn.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jul 2022 15:22:30 -0600 Jonathan Corbet <corbet@lwn.net> wrote:

> alexs@kernel.org writes:
> 
> > From: Alex Shi <alexs@kernel.org>
> >
> > Since the contents is mainly focus on a sysctl vm.overcommit_memory,
> > it's more suitable for admin-guide dir instead of vm/ dir.
> >
> > Signed-off-by: Alex Shi <alexs@kernel.org>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: linux-doc@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  Documentation/admin-guide/mm/index.rst                          | 1 +
> >  Documentation/{vm => admin-guide/mm}/overcommit-accounting.rst  | 0
> >  Documentation/admin-guide/sysctl/vm.rst                         | 2 +-
> >  Documentation/filesystems/proc.rst                              | 2 +-
> >  Documentation/translations/zh_CN/admin-guide/mm/index.rst       | 1 +
> >  .../zh_CN/{vm => admin-guide/mm}/overcommit-accounting.rst      | 2 +-
> >  Documentation/translations/zh_CN/vm/index.rst                   | 1 -
> >  Documentation/vm/index.rst                                      | 1 -
> >  8 files changed, 5 insertions(+), 5 deletions(-)
> >  rename Documentation/{vm => admin-guide/mm}/overcommit-accounting.rst (100%)
> >  rename Documentation/translations/zh_CN/{vm => admin-guide/mm}/overcommit-accounting.rst (97%)
> 
> Applied, thanks.
> 

Don't forget that Documentation/vm was moved to Documentation/mm in
mm-stable and linux-next.
