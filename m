Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DD5C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 May 2022 02:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376479AbiEMCQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 May 2022 22:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347937AbiEMCQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 22:16:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0803C4BFF3
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 19:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sJnARy5TGz4NpCzf3IzEC2y86PKjT72on0U1COCcsiY=; b=La+cZ0PiXhgVAZf9GrKw0MGt13
        A/qJeOL+7cPMG0h4QGK1tPteCkZSWazDjuWDc+XVBShe/Fe2p+nBRAyYYbK5QdHjE8KXIXze5GhX2
        B/cmHpiiqGGA5iy96ptFNHXE+Aw38ny02uI0DCYoolfcplF11yeT0KmQ3bB4k+1w2+aFwMncosdXP
        kixjpgxm2+zAdWt+16cG++hFBwgMIjkwTEoBtGIkcyI/BDKkK5WFc6wxKY2ngUpoWzlIRCe37ZItb
        LLV2HWk10fW+59HOfQjLAr9z0ziBWLeIgCt22gKkEs/karD3ZSLdB7Itz/qgN+Hfqu49IdfKxrztw
        +got7fdg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1npKrE-006xVl-Lc; Fri, 13 May 2022 02:16:44 +0000
Date:   Fri, 13 May 2022 03:16:44 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     songmuchun@bytedance.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: rmap: use the correct parameter name for
 DEFINE_PAGE_VMA_WALK
Message-ID: <Yn2/jIOgJKBtEdoc@casper.infradead.org>
References: <20220512174551.81279-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512174551.81279-1-shy828301@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 10:45:50AM -0700, Yang Shi wrote:
> The parameter used by DEFINE_PAGE_VMA_WALK is _page not page, fix the
> parameter name.  It didn't cause any build error, it is probably because
> the only caller is write_protect_page() from ksm.c, which pass in page.
> 
> Fixes: 2aff7a4755be ("mm: Convert page_vma_mapped_walk to work on PFNs")
> Signed-off-by: Yang Shi <shy828301@gmail.com>

Oops.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
