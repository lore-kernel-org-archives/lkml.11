Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB06C43334
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jul 2022 16:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiGKQKM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jul 2022 12:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbiGKQKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 12:10:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B8C7821B;
        Mon, 11 Jul 2022 09:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Yv/cCXkvdegWQDc0hxz1IcTh2VseNOqN5ZAXrrO5pL4=; b=w4sitqjjocX6/l+MMRL0bAQPus
        9JhqeNRUeUFV+9Zv4Topm6vzHLXYGRxitIZjDFhIkUDMf6bnFShmm2lwRQGEUARHIv3feODf2/3YM
        lPCL/vfLxyFvylztBf+4YjDpvcimDMrFv/LtItKz94INmjcreMSMmuFnRN959hKIhnymOcj5K2Vke
        pRb+/AC14tzroUdWnLwUVVUe6Tm1Oqc3BdzyroJbmj1Nxo+OG4wePwTIwGMluWWh7Oc9hYEnoxqzN
        s+YV061Nmf+aVWbYRh7bT9uvJACM4qmyA8Z4JW/+4oI4FS2m3DanLulGydwcz+Cjg9NX6sEqTtCSs
        yw4wv2jA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oAvyt-0038S1-Fb; Mon, 11 Jul 2022 16:09:55 +0000
Date:   Mon, 11 Jul 2022 09:09:55 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Li Chen <me@linux.beauty>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH 0/4] add struct page and Direct I/O support to reserved
 memory
Message-ID: <YsxLU66tNvi10c82@infradead.org>
References: <20220711122459.13773-1-me@linux.beauty>
 <Ysw7TMFO8Mw0nq8x@infradead.org>
 <181ee01d384.b809bd01412268.496620746959082770@linux.beauty>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <181ee01d384.b809bd01412268.496620746959082770@linux.beauty>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 12:05:06AM +0800, Li Chen wrote:
> My use case has been stated in the cover letter, but our driver is not ready for upstream yet.

Which means we can't review the use case.  I'd suggest you come back
when you submit your driver.

> With DMA allocator, we can access buffer in kernel space, not userspace, however, this patch

Take a look at dma_mmap_* on how to map DMA coherent allocations to
usersapce.  This is of course easily possible.
