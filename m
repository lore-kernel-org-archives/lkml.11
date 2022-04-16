Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B612C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Apr 2022 05:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiDPF6G (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Apr 2022 01:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiDPF56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 01:57:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396172E095
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 22:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=kMcem6muCtTXNqsopWLyZ9KtYeViiCS3WXyDPoUdWSs=; b=UKlTIjTIyzTCh5gDYG05jRSGgn
        nGNuUohCebuE+1FjaDUL3PE86I81XGyqL4uIQX+0zxNDAwNdzbMk9zcW4dz22UbApaF1uQEBvdQ8+
        XfHA+IOamd3OnsAFjqn5womNmuyT2PqmRkJs+F6aSJkEm5Ml+Ef12PONPH8N1hJOejCbcJRGHo2TC
        jKWbZyQ6HEcqn5A8SPABExyHuPhCw/pOy4rs4iQs/g63gs2gAxojoCa533N/cuIRyoJqNaWZIU9d8
        xxAolr+BVIwMA+4ac7B4unGQZInjnUB3/QUWn8ECY0aEXbBXAtZ/0bca4S0Fi7dTmm3ZbJnytUUob
        Ne760+PA==;
Received: from [2a02:1205:504b:4280:f5dd:42a4:896c:d877] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nfbP0-00CJWX-FV; Sat, 16 Apr 2022 05:55:22 +0000
Date:   Sat, 16 Apr 2022 07:55:18 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [GIT PULL] dma-mapping fixes for Linux 5.18
Message-ID: <YlpaRgHee1NPl2XB@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 4fe87e818ea492ade079cc01a31d088e445f8539:

  dma-mapping: move pgprot_decrypted out of dma_pgprot (2022-04-01 06:46:51 +0200)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.18-2

for you to fetch changes up to 9e02977bfad006af328add9434c8bffa40e053bb:

  dma-direct: avoid redundant memory sync for swiotlb (2022-04-14 06:30:39 +0200)

----------------------------------------------------------------
dma-mapping fixes for Linux 5.18

 - avoid a double memory copy for swiotlb (Chao Gao)

----------------------------------------------------------------
Chao Gao (1):
      dma-direct: avoid redundant memory sync for swiotlb

 kernel/dma/direct.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
