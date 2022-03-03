Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A46FC433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Mar 2022 14:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbiCCOYo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Mar 2022 09:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiCCOYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 09:24:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F69517129D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 06:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xhpDNXXrUENoRW8oouM6cOT2aBxbIx77sOMKklVUAFQ=; b=ijiJ7KGrUpn+dfSISyWBMQjjC4
        kp1GjP6Ap/LG4Z+OB4w3m8TMtAIfVKALFyY8V+/vF3FZneFdBhq9PyE+scYyzITTFqMsLlgKJjjnj
        WaEr1Csw18MQZNaKR7sS8Rg77uMacrBznpECmiF3gBQJo78xcSfZTz35e0pr6ldhpC3WgGoa4wN/9
        QfdVY9cE/H7LcRRRI3HItC1OavLuPWkE3dGo21cdHRGKMB3JlWCu6pfYl3eVekO+hi7ehlw0ERCby
        JdkUIeYt9WLASGGhUTRsTcDYKXp0I1MUoefxM4m9LvtZzM2BT97GPL0sqIId07F0Os22gQaAgwpN+
        pCfqOnYg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPmMz-00BiCQ-0o; Thu, 03 Mar 2022 14:23:53 +0000
Date:   Thu, 3 Mar 2022 14:23:52 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH mmotm] mm/munlock: mlock_vma_folio() check against
 VM_SPECIAL
Message-ID: <YiDPeJ+7DVWpsuRv@casper.infradead.org>
References: <9b95d366-1719-f8e2-a5a3-429f9e808288@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b95d366-1719-f8e2-a5a3-429f9e808288@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 05:35:30PM -0800, Hugh Dickins wrote:
> Although mmap_region() and mlock_fixup() take care that VM_LOCKED
> is never left set on a VM_SPECIAL vma, there is an interval while
> file->f_op->mmap() is using vm_insert_page(s), when VM_LOCKED may
> still be set while VM_SPECIAL bits are added: so mlock_vma_folio()
> should ignore VM_LOCKED while any VM_SPECIAL bits are set.
> 
> This showed up as a "Bad page" still mlocked, when vfree()ing pages
> which had been vm_inserted by remap_vmalloc_range_partial(): while
> release_pages() and __page_cache_release(), and so put_page(), catch
> pages still mlocked when freeing (and clear_page_mlock() caught them
> when unmapping), the vfree() path is unprepared for them: fix it?
> but these pages should not have been mlocked in the first place.
> 
> I assume that an mlockall(MCL_FUTURE) had been done in the past; or
> maybe the user got to specify MAP_LOCKED on a vmalloc'ing driver mmap.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
> Diffed against top of next-20220301 or mmotm 2022-02-28-14-45.
> This patch really belongs as a fix to the mm/munlock series in
> Matthew's tree, so he might like to take it in there (but the patch
> here is the foliated version, so easiest to place it after foliation).

It looks like it fixes "mm/munlock: mlock_pte_range() when mlocking or
munlocking", so I'll fold it into that patch?

>  mm/internal.h | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -421,8 +421,15 @@ extern int mlock_future_check(struct mm_struct *mm, unsigned long flags,
>  static inline void mlock_vma_folio(struct folio *folio,
>  			struct vm_area_struct *vma, bool compound)
>  {
> -	/* VM_IO check prevents migration from double-counting during mlock */
> -	if (unlikely((vma->vm_flags & (VM_LOCKED|VM_IO)) == VM_LOCKED) &&
> +	/*
> +	 * The VM_SPECIAL check here serves two purposes.
> +	 * 1) VM_IO check prevents migration from double-counting during mlock.
> +	 * 2) Although mmap_region() and mlock_fixup() take care that VM_LOCKED
> +	 *    is never left set on a VM_SPECIAL vma, there is an interval while
> +	 *    file->f_op->mmap() is using vm_insert_page(s), when VM_LOCKED may
> +	 *    still be set while VM_SPECIAL bits are added: so ignore it then.
> +	 */
> +	if (unlikely((vma->vm_flags & (VM_LOCKED|VM_SPECIAL)) == VM_LOCKED) &&
>  	    (compound || !folio_test_large(folio)))
>  		mlock_folio(folio);
>  }
