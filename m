Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CA8C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jun 2022 14:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbiFUOvy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jun 2022 10:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiFUOvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 10:51:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A61A26125;
        Tue, 21 Jun 2022 07:51:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56EEEB818CA;
        Tue, 21 Jun 2022 14:51:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55652C341C0;
        Tue, 21 Jun 2022 14:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655823106;
        bh=kBLj3MDDgY6O3PKHQFkCdzFYBuBCFgGW2BNT21nX0Sw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pkRx4THhja+K9j4DiZpnt62jl/0TY6jeNJuxvUfjmiZGXdruxk8Iirs2OMTHKPvo1
         XoGGHpkLi5A4mxQVy90LlBK/SsENiSJMh782Oiex1yiP3x3Iz8OuYJFPcY+ysp6ZOI
         nRn1j4ucHDzjz208t/a8V2sMIQzuHBuXaveUFgOw=
Date:   Tue, 21 Jun 2022 16:51:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mark Hounschell <markh@compro.net>
Cc:     Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux-kernel <linux-kernel@vger.kernel.org>,
        dmaengine@vger.kernel.org
Subject: Re: [BUG] dma-mapping: remove CONFIG_DMA_REMAP
Message-ID: <YrHa/vwLds+HG6jl@kroah.com>
References: <c32d2da1-9122-66bd-12fc-916be79b33fd@compro.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c32d2da1-9122-66bd-12fc-916be79b33fd@compro.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 09:43:18AM -0400, Mark Hounschell wrote:
> Revert that commit and all works like normal. This commit breaks user land.

Seems like it only breaks an out-of-tree driver, and for obvious
reasons, there's nothing we can do about that, sorry.  You are on your
own here.  Please work with your company to get your driver merged to
the tree and then we will be glad to help out with these types of
issues.

thanks,

greg k-h
