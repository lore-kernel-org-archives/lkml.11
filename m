Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94300C433FE
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Feb 2022 08:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241076AbiBGIGU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Feb 2022 03:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243228AbiBGH4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 02:56:00 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35503C043181
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 23:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QIxgtA0eCA+ZkgUuD6H+aBRkZzuDMxkwQajlhoBH55U=; b=bn/Xq4kW4kNeTn/3YXPp+sVfZl
        xqdvVLZz03Nu6XHcsRiheDpHfjJnVrlBT9h0RTRVvQ+OdOgt3MqnNd+rOKelp/790rthpVYbmvgnB
        PmROHFaCESqGG+KnpsVTyZa1jX1gtKTyw5gHcE/SyODcWEan+zkA3FNOj3MjQLYfZ/PI13sbMcGJE
        B2ZVsRzyDrW92/bN7KeJMDqPHS9sX6vleh7JDobUKlhxRVKQnJwbEo5JE2SbY3fJza4ZDtfil8BYd
        oUL+Z1JN8c0ZTpbf/208WwMHXzwX8qL4ZHhJQrZCZxTwygIUuPO5PRbnt9my+aETzBA14GN55DrVK
        d94GZrKA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nGysQ-009GY4-Q3; Mon, 07 Feb 2022 07:55:58 +0000
Date:   Sun, 6 Feb 2022 23:55:58 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 40/75] mm: Add pvmw_set_page() and pvmw_set_folio()
Message-ID: <YgDQjo96YHJQOXRi@infradead.org>
References: <20220204195852.1751729-1-willy@infradead.org>
 <20220204195852.1751729-41-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204195852.1751729-41-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 07:58:17PM +0000, Matthew Wilcox (Oracle) wrote:
> Instead of setting the page directly in struct page_vma_mapped_walk,
> use this helper to allow us to transition to a PFN approach in the
> next patch.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
