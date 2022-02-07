Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00E6C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Feb 2022 07:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235579AbiBGHtt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Feb 2022 02:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234697AbiBGHpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 02:45:34 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE800C043181
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 23:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=X9XBmgyJgbMWGUH5V7dpdbPDjz
        31UDg8A1kE5VEBEm+2gBIddhY/touIYqCs6O62Mqb8RZqSPRVDC8sH+tuN1JrPTNFPChsVs6SWQq1
        afFMTn2sMnmzLURFLM0b6f9NG1n3bdgiDYMAthAVWxt2a7NbBJApi8ejQeXxiZ4CDws1xWF9CRkEL
        NvIxJPaV3WFTSLjgLY2NstwctNxreAyFdvYdcobeL/ki85BoYX/H5aVRe7/jSkA85GGw+ZIudwNgp
        DlvR3Q8Eh9MCiAYICeThhuypBPXjGvH7TQBzhqhDGjYE//BzHAmGzSU7Ls9h+uYzNsrGHzSpwvDtv
        fjuBvHnw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nGyiG-009FaV-N8; Mon, 07 Feb 2022 07:45:28 +0000
Date:   Sun, 6 Feb 2022 23:45:28 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH 04/75] mm/gup: Change the calling convention for
 compound_range_next()
Message-ID: <YgDOGOvbhKM+SQlF@infradead.org>
References: <20220204195852.1751729-1-willy@infradead.org>
 <20220204195852.1751729-5-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204195852.1751729-5-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
