Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73601C43334
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jul 2022 11:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236117AbiGMLYA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jul 2022 07:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235996AbiGMLXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 07:23:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7375926F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 04:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jPpk/pEiVupb47vyGqtd0ROkKLt8OSpqCTatt4CV4y8=; b=4Y5onEIPjbxcELiGeVmlz3DAuf
        pGP/8pfZEw0rAFP7V8vyaRl6rzAxv10eMIn/gf2hRo+GUa2E39oUPRnYHvOMfXD3K1frFC5zbEhjn
        zouKFm9wl3OI4QBSOt3ga2Y/cCFbjLV6W9Trgru1yxXA4VJHIbAR1C4Zk9MlwlVdPJhZ4mY3iW27h
        0hx1EdJ7+9is/n5PHZqf6vLCjYcqeY+pQ5yYltGT4o5pqyomIOfIwj2l2T4rlfF4SVminHkT6hfpR
        P+N5661twENgxxaj4FgRKc7seJoZgMnli4/Mk6/kU97EgCAHthDYKD6NiSUQIiyfEhcgPTHgtkR4g
        hbwKQPag==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBaT3-0035U0-Pv; Wed, 13 Jul 2022 11:23:45 +0000
Date:   Wed, 13 Jul 2022 04:23:45 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Tianyu Lan <ltykernel@gmail.com>
Cc:     hch@infradead.org, m.szyprowski@samsung.com, robin.murphy@arm.com,
        Tianyu Lan <tiala@microsoft.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] swiotlb: Check nslabs after initialization in the
 swiotlb_init_remap()
Message-ID: <Ys6rQbLaUKYXtWMP@infradead.org>
References: <20220713082454.700487-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713082454.700487-1-ltykernel@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, I've folded this in.
