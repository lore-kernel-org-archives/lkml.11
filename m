Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77627ECAAD3
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Sep 2022 15:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbiIAPIl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Sep 2022 11:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234510AbiIAPIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 11:08:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7AD84EF3
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 08:08:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3B1C61E2F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 15:08:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A78C433D6;
        Thu,  1 Sep 2022 15:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662044915;
        bh=2E4qzAZlqdzxaDQ6Sk931UgRfflnwTiFuDiHRMtDZNg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ebHUbAH9QOnvsnL5152n5Kl/rW8hItFAS2/zBDML30hTqqsKHoJSTrnNnTYiy/uZE
         yQ/J8cPchHWdbooUcCIBkDK5VD0/ncoVTMHmiRPUKWuB3LGuoGppno1wV1h7nGWbYL
         QIk2N/Bck2xORKQWHWtYll6MmK0w/vlR5b3OIw4c=
Date:   Thu, 1 Sep 2022 17:08:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tomas Winkler <tomas.winkler@intel.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Subject: Re: [PATCH v7 10/15] mei: mkhi: add memory ready command
Message-ID: <YxDK8GEkLZ8hEIeC@kroah.com>
References: <20220806122636.43068-1-tomas.winkler@intel.com>
 <20220806122636.43068-11-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220806122636.43068-11-tomas.winkler@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 06, 2022 at 03:26:31PM +0300, Tomas Winkler wrote:
> Add GSC memory ready command.
> The command indicates to the firmware that extend operation
> memory was setup and the firmware may enter PXP mode.
> 
> CC: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> ---
>  drivers/misc/mei/mkhi.h | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/mei/mkhi.h b/drivers/misc/mei/mkhi.h
> index 27a9b476904e..056b76e73d40 100644
> --- a/drivers/misc/mei/mkhi.h
> +++ b/drivers/misc/mei/mkhi.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  /*
> - * Copyright (c) 2003-2020, Intel Corporation. All rights reserved.
> + * Copyright (c) 2003-2021, Intel Corporation. All rights reserved.

It is 2022 :(

