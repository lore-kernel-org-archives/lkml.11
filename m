Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53EDC4332F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Feb 2022 08:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243845AbiBGIGZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Feb 2022 03:06:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243770AbiBGH5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 02:57:17 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8913C043189
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 23:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=O/FJRFDOXKEyCI3acEahSV8Zga
        vkNvKgJIEQe5vfaFoGTWt2MhEOCU1ezBf9ACviMHS4diYjFZxaPjrD+3QxETcKqCQnjHUB1BRqvQI
        PGC1NYXVsTteLXV0IYppxm8Ym80Y32CNPJ+Lt4ooWKuQXsPCgFjvML9aGMCxx1zaqu+YsCtOr/Lee
        9GABQMgsWdOL0nzXq8C5ICINtdTah7ZGrllf88xCWad2QJnFZbWzRRPlDX9UaWW6JbhvigebHDMgl
        rCLSFZmrgp61iAOSw5zN1TNHQV5iO4PUungUb/bkZqq35OwFl+i/PH64A9KIoApjhTQO8KriHnZEK
        CMnVw/qg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nGyte-009H9E-AA; Mon, 07 Feb 2022 07:57:14 +0000
Date:   Sun, 6 Feb 2022 23:57:14 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 43/75] mm/page_idle: Convert page_idle_clear_pte_refs()
 to use a folio
Message-ID: <YgDQ2rO00UZOrFHW@infradead.org>
References: <20220204195852.1751729-1-willy@infradead.org>
 <20220204195852.1751729-44-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204195852.1751729-44-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
