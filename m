Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30069C00140
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Aug 2022 06:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbiHJGYm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Aug 2022 02:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiHJGYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 02:24:40 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF3A6D9C2
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 23:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660112679; x=1691648679;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=0ehwEycYZmTzgxqjzkcGB9NIAU0k8XRrwb9NK6VoLoI=;
  b=LHQNUc0oPaU6K3PbaglFba0IrI2HOi1jr+3KiFRzgkhtR2+0h5XBTrAw
   Y/rdgWCMXDVmAfusaLUqAc4OOT5RCIgrgeTa9Ad7HEcfzeJ+kg5qtDda+
   j309ofHc3uqMqM7sbrXFINjqFPgPmk3OZtejlOphZUlnmdCiX7MhAt50Z
   d60H4N6ozlRNFS99lW1EIrgiELOyo0DZKhHW0yfXG2ZWNKSjWwBM5IxQz
   PdpCs1PJymjINO3nO+xVMn1q6CQVtmhwdWgwW8bp79bGKoh7LfXA+27EB
   41Eae2i+My6zkWNcmZASCDd9q793s6X+1r9l+wIKVLdkXs/WPu9moILUg
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="352740956"
X-IronPort-AV: E=Sophos;i="5.93,226,1654585200"; 
   d="scan'208";a="352740956"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 23:24:39 -0700
X-IronPort-AV: E=Sophos;i="5.93,226,1654585200"; 
   d="scan'208";a="581108867"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 23:24:36 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andi Kleen <andi.kleen@intel.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v3 4/7] mm/thp: Carry over dirty bit when thp splits on pmd
References: <20220809220100.20033-1-peterx@redhat.com>
        <20220809220100.20033-5-peterx@redhat.com>
Date:   Wed, 10 Aug 2022 14:24:33 +0800
In-Reply-To: <20220809220100.20033-5-peterx@redhat.com> (Peter Xu's message of
        "Tue, 9 Aug 2022 18:00:57 -0400")
Message-ID: <877d3gfwf2.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Xu <peterx@redhat.com> writes:

> Carry over the dirty bit from pmd to pte when a huge pmd splits.  It
> shouldn't be a correctness issue since when pmd_dirty() we'll have the page
> marked dirty anyway, however having dirty bit carried over helps the next
> initial writes of split ptes on some archs like x86.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/huge_memory.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 0611b2fd145a..e8e78d1bac5f 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2005,7 +2005,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>  	pgtable_t pgtable;
>  	pmd_t old_pmd, _pmd;
>  	bool young, write, soft_dirty, pmd_migration = false, uffd_wp = false;
> -	bool anon_exclusive = false;
> +	bool anon_exclusive = false, dirty = false;
>  	unsigned long addr;
>  	int i;
>  
> @@ -2098,6 +2098,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>  			SetPageDirty(page);
>  		write = pmd_write(old_pmd);
>  		young = pmd_young(old_pmd);
> +		dirty = pmd_dirty(old_pmd);

Nitpick: This can be put under

		if (pmd_dirty(old_pmd))
			SetPageDirty(page);

Not a big deal.

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

>  		soft_dirty = pmd_soft_dirty(old_pmd);
>  		uffd_wp = pmd_uffd_wp(old_pmd);
>  
> @@ -2161,6 +2162,9 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>  				entry = pte_wrprotect(entry);
>  			if (!young)
>  				entry = pte_mkold(entry);
> +			/* NOTE: this may set soft-dirty too on some archs */
> +			if (dirty)
> +				entry = pte_mkdirty(entry);
>  			if (soft_dirty)
>  				entry = pte_mksoft_dirty(entry);
>  			if (uffd_wp)
