Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FFEC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Feb 2022 15:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355789AbiBNPUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Feb 2022 10:20:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355781AbiBNPUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 10:20:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761435F8E8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 07:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Qr2y9smPLhABHY4CroiGMzJ6xRTz2IT9aOQZeTRdcAA=; b=RvPTsgMyLuheHX9yQiaR0/Igwl
        4OLmmnWQNwB7JZjQffqPeljm58g5orQ5hGf15S/tc+6pjg7pTjOKdJX2g+W9Hu6Ijwqn2Y8y9d/pc
        pBFDYzIxuDURcL3v7XQKasaawY5lvMCS5iIzdjbYYPKM9QAC8xBNmLioWus1ehT2uV2KzFpBZIk8j
        8fzBZy3Ca4lUXMvI9Wcq7X93dW16mQ+HyLWekw42YUpye2I3ZaSLeNW5nYHRksCwfHWDotLuBgJqs
        V+J1p6N4LpB+S47/AX8qhSW/bT6ZCUw7eR+duuL27+yrne0MGBaL8LgBa/dAsJ62Q/KPNV1ts+Axa
        Pb1faHTQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJd9S-00D1ch-Lm; Mon, 14 Feb 2022 15:20:30 +0000
Date:   Mon, 14 Feb 2022 15:20:30 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [willy-pagecache:for-next 52/85] mm/page_vma_mapped.c:246
 page_vma_mapped_walk() warn: always true condition '(pvmw->nr_pages >= (1 <<
 ( - 12))) => (0-u32max >= 0)'
Message-ID: <YgpzPru8aFA5sHOI@casper.infradead.org>
References: <202202141933.YLNzdo4f-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202202141933.YLNzdo4f-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Dan, is this an smatch bug?

On Mon, Feb 14, 2022 at 07:53:39PM +0800, kernel test robot wrote:
> tree:   git://git.infradead.org/users/willy/pagecache for-next
> head:   c267b33d0001488f1d9dad12d6a87655e174d914
> commit: 9733dd1f11d6b6f8a38fa82f0cc014f7840cbd67 [52/85] mm: Convert page_vma_mapped_walk to work on PFNs
> config: xtensa-randconfig-m031-20220213 (https://download.01.org/0day-ci/archive/20220214/202202141933.YLNzdo4f-lkp@intel.com/config)
> compiler: xtensa-linux-gcc (GCC) 11.2.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> smatch warnings:
> mm/page_vma_mapped.c:246 page_vma_mapped_walk() warn: always true condition '(pvmw->nr_pages >= (1 << ( - 12))) => (0-u32max >= 0)'

[...]

>    244				if ((pvmw->flags & PVMW_SYNC) &&
>    245				    transparent_hugepage_active(vma) &&
>  > 246				    (pvmw->nr_pages >= HPAGE_PMD_NR)) {
>    247					spinlock_t *ptl = pmd_lock(mm, pvmw->pmd);

The config in question doesn't enable CONFIG_TRANSPARENT_HUGEPAGE,
so this condition should turn into
	if ((pvmw->flags & PVMW_SYNC) && false && true)
and I don't think smatch should warn on the third clause of the if
being always-true when the second one is false.  Of course, it's not a
literal "false", it's:

static inline bool transparent_hugepage_active(struct vm_area_struct *vma)
{
        return false;
}

unless my debugging / understanding of this issue has gone astray.
