Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0C3C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Mar 2022 06:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbiC2Gia (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Mar 2022 02:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbiC2Gi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 02:38:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471DD1D41B3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 23:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BLn23ZPzFztDmKi1r1MS0HG3EmTPbihADR06egULMkA=; b=FU+QQA9ZpAEVDVXWOFgSWn4vAe
        vCDQ7JhwFailgLwyMcxDwEGJ+pkh3+xhmPZhhGiUlulrXd+bIjD1HH3LmxvaNMppNncIBvBTzXNNE
        x6QsZ14Ohy4VXLMmOecd5F8fYphuQoWcq0Uitr2CCXm3VIM0xrEtjtg5rBsSpp7WqMg4INJgATACR
        wZ1CoPa4EflUhSEIb+Z8xsDTycAEU6tE6WOmfBKsv0LTvyaQAB7LJ3XgML5+UiS0rMQTsuLFDVBg+
        2FhvZ3hkHKAqYJMUYyFnqVrbPpx/lwELDbCRjLS2KiSgCpXi37EFDawQ8L4scnU9H3Bviyyh0Bpyh
        ZM8dZ5gQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZ5T6-00BDGn-0A; Tue, 29 Mar 2022 06:36:40 +0000
Date:   Mon, 28 Mar 2022 23:36:39 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Rolf Eike Beer <eb@emlix.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: mm: use mmap_assert_write_locked() instead of open coding it
Message-ID: <YkKo93R1Fm0JXXtS@infradead.org>
References: <5827758.TJ1SttVevJ@mobilepool36.emlix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5827758.TJ1SttVevJ@mobilepool36.emlix.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 10:24:51AM +0200, Rolf Eike Beer wrote:
> In case the lock is actually not held at this point this also avoids a
> stale lock reference if built with NDEBUG.

The change looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

But I don't think NDEBUG is a thing in the kernel.
