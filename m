Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99918C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Feb 2022 15:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237477AbiB1PML (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Feb 2022 10:12:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbiB1PMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 10:12:08 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6693E7D013
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 07:11:29 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1F643219A2;
        Mon, 28 Feb 2022 15:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646061088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nx7T66rlXmn1/P94LhUa9N7gYHbptxzfbjxOTP+KV4s=;
        b=VfQxld1BmxyYbbrWlbYbmtaO5z/+1FK2e0PIL7TViQVtn9j2aPqGuUHJzQVi3LMKcK0Hmp
        /AtM8OzRx6P2s13LsmgOvEJkw/ihsfEJwxUF2LET2eAYaw/K5UpBbHkHpKHRPkAPxK4EKs
        fWsQFV4WPDY2Sn1WquqZUs+8klUariM=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DF3FDA3B83;
        Mon, 28 Feb 2022 15:11:27 +0000 (UTC)
Date:   Mon, 28 Feb 2022 16:11:24 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/oom_kill: remove unneeded is_memcg_oom check
Message-ID: <YhzmHHxDs9lnFajc@dhcp22.suse.cz>
References: <20220224115933.20154-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224115933.20154-1-linmiaohe@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 24-02-22 19:59:33, Miaohe Lin wrote:
> oom_cpuset_eligible is always called when !is_memcg_oom. Remove this
> unnecessary check.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!

> ---
>  mm/oom_kill.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 9fea6d3c1ec7..c70a4330e548 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -122,9 +122,6 @@ static bool oom_cpuset_eligible(struct task_struct *start,
>  	bool ret = false;
>  	const nodemask_t *mask = oc->nodemask;
>  
> -	if (is_memcg_oom(oc))
> -		return true;
> -
>  	rcu_read_lock();
>  	for_each_thread(start, tsk) {
>  		if (mask) {
> -- 
> 2.23.0

-- 
Michal Hocko
SUSE Labs
