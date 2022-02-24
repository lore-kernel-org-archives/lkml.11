Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD714C433FE
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Feb 2022 08:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbiBXI05 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Feb 2022 03:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbiBXI0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 03:26:55 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1722E26F4E2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 00:26:26 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C20681F43D;
        Thu, 24 Feb 2022 08:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645691184; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=adxedwQWkr5jfagPKOdhZGUwUnLYqrYeTaIwwWUOYlE=;
        b=FskKERZifrad1o6nZ0DWDHdrq+F/hS1tMewn8it5JtjAAcRDiFhVQ7B63thBQhiM2a3scE
        Vfz2PbPm6MiVzipadsRGDOF6AS/jkET+2Ku20GNK9S8vSPK8kWL/rC4xSasAYpWCNFB3Ry
        aqPSOJOgtuiVbc2CcuQaxgKPiIL5Mng=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 76F46A3B8C;
        Thu, 24 Feb 2022 08:26:20 +0000 (UTC)
Date:   Thu, 24 Feb 2022 09:26:24 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Vladimir Davydov <vdavydov.dev@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] MAINTAINERS: remove myself from memcg maintainers
Message-ID: <YhdBMPcsc9g9kY8x@dhcp22.suse.cz>
References: <4ad1f8da49d7b71c84a0c15bd5347f5ce704e730.1645608825.git.vdavydov.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ad1f8da49d7b71c84a0c15bd5347f5ce704e730.1645608825.git.vdavydov.dev@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 23-02-22 12:37:42, Vladimir Davydov wrote:
> Signed-off-by: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>

Thanks for all your contributions!
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 777cd6fa2b3d..cbadcffbff50 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4913,7 +4913,6 @@ F:	kernel/cgroup/cpuset.c
>  CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)
>  M:	Johannes Weiner <hannes@cmpxchg.org>
>  M:	Michal Hocko <mhocko@kernel.org>
> -M:	Vladimir Davydov <vdavydov.dev@gmail.com>
>  L:	cgroups@vger.kernel.org
>  L:	linux-mm@kvack.org
>  S:	Maintained
> -- 
> 2.25.1

-- 
Michal Hocko
SUSE Labs
