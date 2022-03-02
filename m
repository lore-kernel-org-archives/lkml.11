Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D14C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Mar 2022 20:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243290AbiCBUXm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Mar 2022 15:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234311AbiCBUXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 15:23:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C160047046
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 12:22:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5DDF8B821E6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 20:22:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9833C004E1;
        Wed,  2 Mar 2022 20:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646252573;
        bh=7bgPLeBtkLeGd8gJ+7qdnLVYUIka++VhaBDdQviQPBs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dsoclcJZIIrMPfpUOZn+wjyXElL+QXbU8vCvegWeNIFu9zbpgQJ9b2FD7nWbxyKAD
         0v+FwRCcFrKehULZ6PQ7UUhpTy5vmEtmiY3dkbyAJXrKlzp/S0+B58EdMVzsrUi9cQ
         zrV5hxJhcavOlkPYJDGDNhzfvsClwgdacvTuZSts=
Date:   Wed, 2 Mar 2022 21:22:49 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Phi Nguyen <phind.uet@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] samples/kobject: Use sysfs_emit instead of
 snprintf
Message-ID: <Yh/SGeW1KPcbH4ob@kroah.com>
References: <20220302120759.380932-1-phind.uet@gmail.com>
 <Yh+EdGcsoF+lBjfX@kroah.com>
 <32164620-9ba6-db62-bc61-95c7f255d087@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32164620-9ba6-db62-bc61-95c7f255d087@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 02:11:36AM +0800, Phi Nguyen wrote:
> On 3/2/2022 10:51 PM, Greg KH wrote:
> > On Wed, Mar 02, 2022 at 08:07:59PM +0800, Nguyen Dinh Phi wrote:
> > > Convert sprintf() to sysfs_emit() in order to check buffer overrun on sysfs
> > > outputs.
> > 
> > There are no such buffer overruns on these sysfs files.
> > 
> I don't want to duplicate the title so I use the description of sysfs_emit()
> as the patch message. I have just realized that the title is also incorrect,
> sorry for my mistake.
> 
> > > 
> > > Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
> > > ---
> > >   samples/kobject/kobject-example.c | 4 ++--
> > >   samples/kobject/kset-example.c    | 4 ++--
> > >   2 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > Why is this a resend?  What happened to the first version?
> > 
> > thanks,
> > 
> > greg k-h
> 
> There is no response for the first version. Actually, there is no Maintainer
> is associated with these two files (in MAINTAINERS files), hence, my first
> patch was only sent to the linux-kernel mailing list.

You need to give reviewers a hint as to what is going on when you do
this, we can't read minds :)

thanks,

greg k-h
