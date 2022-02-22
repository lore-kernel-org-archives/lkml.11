Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD5FC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Feb 2022 10:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbiBVK11 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Feb 2022 05:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiBVK1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 05:27:22 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814F7127D5F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 02:26:57 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3FE8A1F397;
        Tue, 22 Feb 2022 10:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645525616; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w1hg232T/yWKq7vGtVyNo0OEgr0wbTVArMC8JKVB+m8=;
        b=ovsHd8BJu5ZGWXYkkmH2y62O0geJ6mMX+IvK7ogKTok8QytXsMXH8hizEzDSq69zawifTX
        WvqFcU1SRzgh6XD4yErlNkJaH+fo+vmhEmiOJg04yLqFw90zz91jazeSvpo6c1UAEAw9mG
        MbgWP4mdhWQGpt9BmPsGnM0IWk9L9hw=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2AEACA3B88;
        Tue, 22 Feb 2022 10:26:56 +0000 (UTC)
Date:   Tue, 22 Feb 2022 11:26:52 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add myself as a memcg co-maintainer
Message-ID: <YhS6bCYZKMbLFdrs@dhcp22.suse.cz>
References: <20220221233951.659048-1-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221233951.659048-1-roman.gushchin@linux.dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 21-02-22 15:39:51, Roman Gushchin wrote:
> Add myself as a memcg co-maintainer. My primary focus over last few
> years was the kernel memory accounting stack, but I do work on some
> other parts of the memory controller as well.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 66aa3a589f6a..ecdb90e99ba7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4991,6 +4991,7 @@ CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)
>  M:	Johannes Weiner <hannes@cmpxchg.org>
>  M:	Michal Hocko <mhocko@kernel.org>
>  M:	Vladimir Davydov <vdavydov.dev@gmail.com>
> +M:	Roman Gushchin <roman.gushchin@linux.dev>
>  L:	cgroups@vger.kernel.org
>  L:	linux-mm@kvack.org
>  S:	Maintained
> -- 
> 2.35.1

-- 
Michal Hocko
SUSE Labs
