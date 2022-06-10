Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB1EC43334
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jun 2022 08:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347439AbiFJIVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jun 2022 04:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347346AbiFJISp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 04:18:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38112574C6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 01:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FsGmRpWL6F/atJFd7eU0CvsgBB4vqNspDhxxgQCHQwA=; b=EGmIeLAaUQFdkeWTBbXWZ4azDV
        yptGshIlMmxL3ZCgQxfQv4CR/vsruZXnCovEYvYpzGSIHAtMlVlucC0AJ/YCu+E+RG0jM2t+lGC5r
        ScQ8HTtNbTESUML4NAngb6nwJHvy9/igL+TC8szz2cUhPsfQUVLAqADpafFiBBEXj9hWwBOjD4hyM
        j05CnEHmUcsJQGsdt+de5bCUodiKtGLEJaLmkmLMVQRZi4t/LDv78XAl2PaDbbsTch5UhOtpllBkD
        XHpLcZPlw3HZ21nFpFrah2Mn+1WJxXxijuRTeVB+4PK/lXs64JVgqOXv8WYF/BB7ElPFUwGl5Vg+3
        FsH14CUw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nzZqs-006iyq-HA; Fri, 10 Jun 2022 08:18:42 +0000
Date:   Fri, 10 Jun 2022 01:18:42 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 2/5] mm/vmalloc: Extend __alloc_vmap_area() with extra
 arguments
Message-ID: <YqL+YnR86cbCXJkW@infradead.org>
References: <20220607093449.3100-1-urezki@gmail.com>
 <20220607093449.3100-3-urezki@gmail.com>
 <Yp8fRttJPpZ+0+gu@infradead.org>
 <CA+KHdyXMhH1uf92Pv_6H1Qar4BsTdfykdr3jC=KwG8Fe6Je=PQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+KHdyXMhH1uf92Pv_6H1Qar4BsTdfykdr3jC=KwG8Fe6Je=PQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 03:02:42PM +0200, Uladzislau Rezki wrote:
> I wrote about it in the cover latter. It is a preparation work for
> making vmalloc per-cpu.

Then:

 a) state this in the actual patch commit log.  Those need to be
    standalone and sufficiently describe what the patch is doing.
 b) do that in the actual series that makes use of them.  In fact
    for these kinds of changes the prep patch really seems like a bad
    idea to start with and it would be much easier to follow if the
    changes were done in the main patch.

