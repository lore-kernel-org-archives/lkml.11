Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEFFC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Mar 2022 08:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244099AbiC3IIG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Mar 2022 04:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244092AbiC3IIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 04:08:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD61D2E6B8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 01:06:19 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7A9B221605;
        Wed, 30 Mar 2022 08:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1648627578; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Um5MncWQPFK069jInV5QbM0hF4fayUXS1W56obOkrFk=;
        b=gojrEkSRQEgWFK1XNxkCS3aNTUXaXPocr2R7tm2tGJZ9AYJ4wWLbcKFl9rl2BKHSSgcBp8
        +RrlEZ/jEkqw3j2XXMdTPhVVwj7f4T+mJIawfsl7XKqgMUy5ZNW3PB28N/9/crLubb+OKm
        kUQUTXQEcU5iVDguo8N3rp2jEDU99p0=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3F6BCA3B9B;
        Wed, 30 Mar 2022 08:06:18 +0000 (UTC)
Date:   Wed, 30 Mar 2022 10:06:17 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Jaewon Kim <jaewon31.kim@samsung.com>
Cc:     minchan@kernel.org, ngupta@vflare.org, senozhatsky@chromium.org,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, s.suk@samsung.com,
        jaewon31.kim@gmail.com
Subject: Re: [PATCH] zram_drv: add __GFP_NOWARN flag on call to zs_malloc
Message-ID: <YkQPefdRc+hxIXEV@dhcp22.suse.cz>
References: <CGME20220330052214epcas1p250cff6b3168a1c9c253e1fe70e68ca8b@epcas1p2.samsung.com>
 <20220330052502.26072-1-jaewon31.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330052502.26072-1-jaewon31.kim@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 30-03-22 14:25:02, Jaewon Kim wrote:
> The page allocation with GFP_NOIO may fail. And zram can handle this
> allocation failure. We do not need to print log for this.

GFP_NOIO doesn't have any special meaning wrt to failures. zram
allocates from the memory reclaim context which is a bad design IMHO.
The failure you are seeing indicates that PF_MEMALLOC context (memory
reclaim) which is allow to dip into memory reserves without any limit
cannot find any memory! This is really bad and it is good to learn about
that.

Your description doesn't really explain why we should be ignoring that
situation. Is the memory allocation failure gracefully recoverable?

-- 
Michal Hocko
SUSE Labs
