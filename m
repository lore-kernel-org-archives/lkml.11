Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140B9C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jun 2022 05:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237943AbiFIFGH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jun 2022 01:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiFIFGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 01:06:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C1126522A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 22:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lSjKiwGQP2bLdZmsJuNaLJfxZDGjC6fCq2g/NdyMPNA=; b=kyhL2c0fixHav+CSRIiyWMtFN7
        AtDNsnF/9FvWJ9TIx9fua/CrNv5rR8a9O7oji3ME60GbokDgdhgvD0ea2XdXEW/L1DOT//y9eaYzo
        JnuI00fO4ezPxNMBvHkQYYI5xIPoHzR9wnf4anfLqVEwyENKdzkr/7GIIOrh15zyrv+YMfLMdP9s5
        6Rvc7JdDtTpL7W2pcS0iqoBpYYs8PLlaD0HauJabPoVr7WpXOlJQlGsGN0JStdxSNMixCdQE7blhE
        RaUJDr2rfJW4kg5HofoJ8jqgC2HUgKr4MOCFxVgU1Mt6OJy/VvcugFl1p5U4yhYTwg9+HBWpohhZ5
        n20MR6mw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nzAMl-00Gn4g-0a; Thu, 09 Jun 2022 05:05:55 +0000
Date:   Wed, 8 Jun 2022 22:05:54 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     iommu@lists.linux-foundation.org, xen-devel@lists.xenproject.org,
        x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, hch@infradead.org,
        m.szyprowski@samsung.com, jgross@suse.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        sstabellini@kernel.org, mpe@ellerman.id.au, konrad.wilk@oracle.com,
        mst@redhat.com, jasowang@redhat.com, joe.jin@oracle.com
Subject: Re: [PATCH RFC v1 4/7] swiotlb: to implement io_tlb_high_mem
Message-ID: <YqF/sphJj6n+22Si@infradead.org>
References: <20220609005553.30954-1-dongli.zhang@oracle.com>
 <20220609005553.30954-5-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609005553.30954-5-dongli.zhang@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All this really needs to be hidden under the hood.
