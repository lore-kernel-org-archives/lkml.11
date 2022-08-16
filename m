Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDBEC25B0E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Aug 2022 11:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbiHPLV6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Aug 2022 07:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234606AbiHPLVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:21:31 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63BF7B7A4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 02:49:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 28BD9CE1727
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 09:49:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95EF6C433D6;
        Tue, 16 Aug 2022 09:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660643347;
        bh=WWioMFcNN2dl6v/4lVUXRRr6/HAg8tayDniICrS0uxU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kvzkpRTafvVeoPO+7cPSAY6Uej/op8RJyCJ8jozt/xYS5fNGR+xr3CcQJhX2dpgBY
         WPp7R0fKWb7iPGFrT5G3H8lNnacaR4JyLzc/U23JgfFKV0ZY3AvvVDmKxBqYTqLykJ
         iFosH5ieKzNaIr+2sEJVQBgOFZi7/CN6+bm334Mk=
Date:   Tue, 16 Aug 2022 11:49:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Atanasov <alexander.atanasov@virtuozzo.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nadav Amit <namit@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/4] Make place for common balloon code
Message-ID: <YvtoDxvefWUJBfAS@kroah.com>
References: <20220816094117.3144881-1-alexander.atanasov@virtuozzo.com>
 <20220816094117.3144881-2-alexander.atanasov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816094117.3144881-2-alexander.atanasov@virtuozzo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 12:41:14PM +0300, Alexander Atanasov wrote:
> File already contains code that is common along balloon
> drivers so rename it to reflect its contents.
> mm/balloon_compaction.c -> mm/balloon_common.c
> 
> Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
> ---
>  MAINTAINERS                                              | 4 ++--
>  arch/powerpc/platforms/pseries/cmm.c                     | 2 +-
>  drivers/misc/vmw_balloon.c                               | 2 +-
>  drivers/virtio/virtio_balloon.c                          | 2 +-
>  include/linux/{balloon_compaction.h => balloon_common.h} | 2 +-
>  mm/Makefile                                              | 2 +-
>  mm/{balloon_compaction.c => balloon_common.c}            | 4 ++--
>  mm/migrate.c                                             | 2 +-
>  mm/vmscan.c                                              | 2 +-
>  9 files changed, 11 insertions(+), 11 deletions(-)
>  rename include/linux/{balloon_compaction.h => balloon_common.h} (99%)

Why rename the .h file?  It still handles the "balloon compaction"
logic.

thanks,

greg k-h
