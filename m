Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A25EC28D13
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Aug 2022 06:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbiHVGQu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Aug 2022 02:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232775AbiHVGQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 02:16:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A81275C8
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 23:16:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7340660DD9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 06:16:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2AB1C433D6;
        Mon, 22 Aug 2022 06:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661149005;
        bh=oam4vUYw/KVwSNy5YSjAsGlmt/+2xtbnVpkrdwCR28M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GfzVmHFTV7uV0QBJ4DvCoYyavuTCM6iUvvA9TxKHxlyRi5TeT5bJlnpr5INtylRA/
         a+mEpkoxNQd56fvbIkbMimWYbXqdkV8+kVDAp6OqKkKdl7V7Mxw0xrSgmCu2Ay4x72
         4M4WnFQCE97Otk3J5scF58Mp9115tKzF7bJ79LiI=
Date:   Mon, 22 Aug 2022 08:16:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] devres: remove devm_ioremap_np
Message-ID: <YwMfSdEfgfsnaEJw@kroah.com>
References: <20220822061424.151819-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822061424.151819-1-hch@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 08:14:24AM +0200, Christoph Hellwig wrote:
> devm_ioremap_np has never been used anywhere since it was added in early
> 2021, so remove it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  Documentation/driver-api/driver-model/devres.rst |  1 -
>  include/linux/io.h                               |  2 --
>  lib/devres.c                                     | 15 ---------------
>  3 files changed, 18 deletions(-)

Nice catch!  I'll go queue this up, thanks.

greg k-h
