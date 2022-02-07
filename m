Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AFEC4167D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Feb 2022 07:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240511AbiBGHuL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Feb 2022 02:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235898AbiBGHtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 02:49:45 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F93C043184
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 23:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UcF3TmO8gMJDNho3UCi/3NRz3Ku+zKXzuhi1ha055vc=; b=wXsjzM9RYNVa28neM6wAn0MYUd
        LJ9GAf4gWX9pIW17MA8OGRW7q9AKWfFqMM9OK3hFXlS3rTjRDn1f7wh7Qo2aJPEH3BzaxFFv3uUi0
        RFvPOd3s6cmj4AN1zPosjSTEpQ1KkgjpD82FI7MxRs3aK149DApCPq/dGf2lmYHeSPdP3Cb5m6LjJ
        FSe2tXIH31HoidckH8WyLMEshhuiEEMrtzlLpTuvxMyHwbyEfd3pWsLwf3e/5yWmSvClVJuI1BCY2
        HdSu6hsGrLRdXKgzOlf6XFUAq5UJYzqKeA3zRM5ije4LcTwArZvkDi2TZ3ncLOeYGYo32ajlk0bXT
        cQOcXhog==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nGymN-009Fo5-Ca; Mon, 07 Feb 2022 07:49:43 +0000
Date:   Sun, 6 Feb 2022 23:49:43 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 30/75] mm/memcg: Convert mem_cgroup_swapout() to take a
 folio
Message-ID: <YgDPF+AJgUrO3hS/@infradead.org>
References: <20220204195852.1751729-1-willy@infradead.org>
 <20220204195852.1751729-31-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204195852.1751729-31-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 07:58:07PM +0000, Matthew Wilcox (Oracle) wrote:
>  #ifdef CONFIG_MEMCG_SWAP
> -extern void mem_cgroup_swapout(struct page *page, swp_entry_t entry);
> +extern void mem_cgroup_swapout(struct folio *folio, swp_entry_t entry);

Might be worth to drop the extern while you're at it.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
