Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359C2C433FE
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Mar 2022 08:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352148AbiCPIyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Mar 2022 04:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346087AbiCPIyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 04:54:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D3C27FE9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 01:53:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51F5461560
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 08:53:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394A4C340E9;
        Wed, 16 Mar 2022 08:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647420804;
        bh=ekLZb1lbsVmd4fFmXwiqzIWmyw2ad5ve/nwLpaF/zPQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=WKqSf2pUUMqXLJTkULj7fj1QQVTwBXv7eUcNotlQpZexaIEytHZ0X+SSewVT+razl
         UKeiir/DNztl1Kh7SK+llTzjK7sW5TK64rjqjU8kYhsNqJqdg7Qx3J7yNHs/Jrs7r/
         dPUZspJqIUdow6AZX6DIEHvcw47rW+x4KrO02Ca6na6EVTVQevcMRctfrEVg/kc7sf
         3+cnisHSa4xsVu3Z65QNMWotf4nQZsh24Z9J+JnNPRJ1k0wrxWYpgAWN1Qioxh977f
         XQiXdbx2UDHkbQMo53Id24mTIbfiUfr1c8YFr22/ng1JZsH3zN9pmy2jN9tt9OzFZr
         6qMGHeGWw3UOQ==
From:   sj@kernel.org
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, sj@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: minor cleanup for damon_pa_young
Date:   Wed, 16 Mar 2022 08:53:15 +0000
Message-Id: <20220316085315.21054-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220316081528.6034-1-linmiaohe@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miaohe,


Thank you for this patch!

On Wed, 16 Mar 2022 16:15:28 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> if need_lock is true but folio_trylock fails, we should return false
> instead of NULL to match the return value type exactly. No functional
> change intended.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> ---
>  mm/damon/paddr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index a01495cebdad..21474ae63bc7 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -152,7 +152,7 @@ static bool damon_pa_young(unsigned long paddr, unsigned long *page_sz)
>  	need_lock = !folio_test_anon(folio) || folio_test_ksm(folio);
>  	if (need_lock && !folio_trylock(folio)) {
>  		folio_put(folio);
> -		return NULL;
> +		return false;
>  	}
>  
>  	rmap_walk(folio, &rwc);
> 
> -- 
> 2.23.0
> 
> 
> 
