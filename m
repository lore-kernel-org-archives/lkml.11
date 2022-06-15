Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB87C43334
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jun 2022 13:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348568AbiFONPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jun 2022 09:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345668AbiFONPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 09:15:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A995E2A969
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 06:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aCliT9MV6ttW0KpyuydNdYdmYuXW3sKXYsk92n5Vl2s=; b=NK2kDDW+JyCgPSX5zWJuUAb69y
        hazxvJrhn742/Cdd+2lNelGIwzK1xmXb09uZG15Lo0Ag/DRGt/SIpRZ/uPeSxMCPC6UQMI8VsJ+rc
        EJpUzTwvx1/RBYGd7fn2cYvNuFp6h9FAHE3Hvc+BPnoPGwoY9U8o+NqlJLCcNs2gzVs2//+SuL65l
        wrkhOVeKdrpk1jd781OW+mCau0ytcSnWFMNPSb1zVNCpMhEQiUJG5BrtH2IWEYO4fKPwx/vtfSyJW
        S3UYBFH2A/xmU6bIITUxiIE2JWqseDcKC9Gmram32aDMqUXXjVXrMc9VgzDgPAafcU44HtKngaJ8g
        XTQi+3bQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o1Ss5-00EeCS-Cu; Wed, 15 Jun 2022 13:15:45 +0000
Date:   Wed, 15 Jun 2022 06:15:45 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/2] mm/mmap: Drop __SXXX/__PXXX macros from across
 platforms
Message-ID: <YqnbgWHmfd9SIp6O@infradead.org>
References: <20220613053354.553579-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613053354.553579-1-anshuman.khandual@arm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I relaly like this.  The __SXXX/__PXXX are a complete mess, and this
cleans it up nicely.  So with any remaining issues sorted out I'm
all for it:

Acked-by: Christoph Hellwig <hch@lst.de>
