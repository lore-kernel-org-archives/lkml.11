Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8EBC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 27 May 2022 15:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353580AbiE0PCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 May 2022 11:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242146AbiE0PCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 11:02:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4873F3BBC4
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 08:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hGyoUi94cq7Vfw020XtVXOMPZovJcvjml8At2o+1KI8=; b=HPsIaNCLckJxdUq2OcYUYs4Gqz
        Ca5opjitgxaBMH2oo0ZPFJIVnfMCbafkSl1jwA6JZX21Rxw4nNv+GgeSkCsQR/RHt7egmJlwGkjIA
        K474mCaD7gK2YCbKPTqTp+qhKSQmB1MgpaOA2LplKdod8uAyGpGoq7qM+dzI28Um0XXkQVErh9uLn
        gnxGB63VK7BE9iMTVSu3Ql1+UGtGwWw0wfcPHZoGRre/O24XrWLe+NEkHQr3ec0/i3+gR2GaxQ4uC
        VTgNiSoLEQEWLyLtR9PDDcD2zKECELBz+vCZHLb2LfdAG31se/3A459K33nbPjzeX914Mxzj6iaSx
        YQluiViw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nubTt-002AqY-KR; Fri, 27 May 2022 15:02:25 +0000
Date:   Fri, 27 May 2022 16:02:25 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmscan: don't try to reclaim freed folios
Message-ID: <YpDoAZtQtQf6U8D2@casper.infradead.org>
References: <20220527080451.48549-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527080451.48549-1-linmiaohe@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 04:04:51PM +0800, Miaohe Lin wrote:
> If folios were freed from under us, there's no need to reclaim them. Skip
> these folios to save lots of cpu cycles and avoid possible unnecessary
> disk IO.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/vmscan.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index f7d9a683e3a7..646dd1efad32 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1556,12 +1556,18 @@ static unsigned int shrink_page_list(struct list_head *page_list,
>  		folio = lru_to_folio(page_list);
>  		list_del(&folio->lru);
>  
> +		nr_pages = folio_nr_pages(folio);
> +		if (folio_ref_count(folio) == 1) {
> +			/* folio was freed from under us. So we are done. */
> +			WARN_ON(!folio_put_testzero(folio));

What?  No.  This can absolutely happen.  We have a refcount on the folio,
which means that any other thread can temporarily raise the refcount,
so this WARN_ON can trigger.  Also, we don't hold the folio locked,
or an extra reference, so nr_pages is unstable because it can be split.

> +			goto free_it;
> +		}
> +
>  		if (!folio_trylock(folio))
>  			goto keep;
>  
>  		VM_BUG_ON_FOLIO(folio_test_active(folio), folio);
>  
> -		nr_pages = folio_nr_pages(folio);
>  
>  		/* Account the number of base pages */
>  		sc->nr_scanned += nr_pages;
> -- 
> 2.23.0
> 
> 
