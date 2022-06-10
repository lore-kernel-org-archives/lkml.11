Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F14C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jun 2022 08:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244113AbiFJIAO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jun 2022 04:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347084AbiFJIAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 04:00:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC972067AB;
        Fri, 10 Jun 2022 01:00:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1ACE0B8083A;
        Fri, 10 Jun 2022 08:00:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F7EC34114;
        Fri, 10 Jun 2022 08:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654848007;
        bh=rIT5rAC8mwzXd9v1qd5sMTexcVFRTr1GesOWEmu8Wws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NlboDRo98OjDCefRGijDSqyZu7a2wKmNKeEnhW+cI+cMmkEE6RgZNNAnU5TOFmfIc
         jwzf7MWHPPgDnaCdjFYYFeYAdLYk2v9rgR9Vn9lKvjtPQolynd4xvlcs0ZBjEf1H/o
         VrEt0MefzpYq/3FUjrv4m8Caarr38QtaJAY4K8Bv28Oa2QecvGQQF4ZHETYzqZyZpK
         2Mf5AzjRKPNrfSUidqV3ditTaEw2f3QeOKGBuAsJXrFxOx9rafaPRjZgQNjZgv1441
         ojFokEBHAwMMClKbeEu/BwwQh805gIKgqojUjpfCk4i3F+QGlySpH/ErdwPmIGJTZA
         dkgjoHtpzc3Xw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nzZYp-0004yN-83; Fri, 10 Jun 2022 10:00:03 +0200
Date:   Fri, 10 Jun 2022 10:00:03 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Jared Kangas <kangas.jd@gmail.com>
Cc:     vaibhav.sr@gmail.com, elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, linux-staging@lists.linux.dev,
        mgreer@animalcreek.com, Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v2] staging: greybus: audio: fix loop cursor use after
 iteration
Message-ID: <YqL6A3pVC8LOqE4d@hovoldconsulting.com>
References: <20220609214517.85661-1-kangas.jd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609214517.85661-1-kangas.jd@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 02:45:18PM -0700, Jared Kangas wrote:
> gbaudio_dapm_free_controls() iterates over widgets using the
> list_for_each_entry*() family of macros from <linux/list.h>, which
> leaves the loop cursor pointing to a meaningless structure if it
> completes a traversal of the list. The cursor was set to NULL at the end
> of the loop body, but would be overwritten by the final loop cursor
> update.
> 
> Because of this behavior, the widget could be non-null after the loop
> even if the widget wasn't found, and the cleanup logic would treat the
> pointer as a valid widget to free.
> 
> To fix this, introduce a temporary variable to act as the loop cursor
> and copy it to a variable that can be accessed after the loop finishes.
> Due to not removing any list elements, use list_for_each_entry() instead
> of list_for_each_entry_safe() in the revised loop.
> 
> This was detected with the help of Coccinelle.
> 
> Fixes: 510e340efe0c ("staging: greybus: audio: Add helper APIs for dynamic audio modules")
> Cc: stable@vger.kernel.org
> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
> Reviewed-by: Johan Hovold <johan@kernel.org>
> Signed-off-by: Jared Kangas <kangas.jd@gmail.com>
> ---
> 
> Changes since v1:
>  * Removed safe list iteration as suggested by Johan Hovold <johan@kernel.org>
>  * Updated patch changelog to explain the list iteration change
>  * Added tags to changelog based on feedback (Cc:, Fixes:, Reviewed-by:)

Apparently Greg applied this to staging-next before we had a change to
look at it. You should have received a notification from Greg when he
did so.

	https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/commit/?h=staging-next&id=80c968a04a381dc0e690960c60ffd6b6aee7e157

It seems unlikely that this would cause any issues in real life, but
there's still a chance it will be picked up by the stable team despite
the lack of a CC stable tag.

I've just sent a follow-up patch to replace the list macro.

Johan
