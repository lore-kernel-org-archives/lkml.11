Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F17EC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Feb 2022 07:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241038AbiBGHv2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Feb 2022 02:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240201AbiBGHuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 02:50:08 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF8EC043184
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 23:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JH56PqPPiJPmCClnDIg1VBXPjJyz5O2vfhNgYVvhf4o=; b=IhqKOrpXUm1VVMwn1kh3pteAli
        vUoQVPGPknwcJIGJ/Y4L0LAJ/I0vGZwqjFKVzMMeuUED8whlwFg3IsqzZCvqHIg1vjenOBTkDeR5O
        tqZxts+z9LxQRmhQGT1o9iawL1w5RZlb8LSd2Ujd9avjF5vB132k+bh5ZLo4ohNQ9/O9t3F+G7oBM
        21CEdPImJJ0EFfIMWAgiGTjfHdZxWIDHUiF9rsSU9zZ9bGkHjD67snOQ5G/JjrFtMDu/39hyHALZT
        1FGUrpvkZbg8SWTlfRqmSnetXcmbCbvoC5M8rUrqNMY/4MyHLlVo7AMwg8znAJ0+2RVhzdfwji8lI
        U/X3at+g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nGymk-009FqT-Jv; Mon, 07 Feb 2022 07:50:06 +0000
Date:   Sun, 6 Feb 2022 23:50:06 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 31/75] mm: Add lru_to_folio()
Message-ID: <YgDPLh6l2n47DpLE@infradead.org>
References: <20220204195852.1751729-1-willy@infradead.org>
 <20220204195852.1751729-32-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204195852.1751729-32-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 07:58:08PM +0000, Matthew Wilcox (Oracle) wrote:
> Since page->lru occupies the same bytes as compound_head, any page
> on the LRU list must be a folio.

Any reason to not turn this into an inline function?
