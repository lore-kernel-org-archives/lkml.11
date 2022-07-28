Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818DCC04A68
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jul 2022 14:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbiG1OWt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jul 2022 10:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbiG1OWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 10:22:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169BA52E7B
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 07:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oQ2Oy2vE4Y+KSIGzjxEVBp2pts3FTmVlEXlZ7nc293g=; b=17Nfu7QprtLx4tSqmzV3nyP25V
        cS/32MAHrV4eNdjizAUbj+oYqIFG71iB6ww+XxOkWgwQ/nznuD8SvehCQ74C/qpcmsLeYumGg/juB
        FAwrAj7iteF8VQYEf2QKrROAx6F0gk+yq60AwG9/BOREWsn2AHWp8N9/M2KOJRp4Pp0RT7zHLrvT4
        6c8HIDKt75Hq4AuhG8RWNSdCXXH/faM9P3jbqHJh3DSixPirWSvkL//UqTWFBNIGrOv9wi2bEitE7
        hNX1QE+wfWQ013fBQvf5h5UNCgq2V5eFOI7BzcnUrWN0F/CRuYdaCh8tZWoGGfNg2QZjHs4O9vdUt
        W1TJA+0g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oH4PN-00A5rM-I7; Thu, 28 Jul 2022 14:22:37 +0000
Date:   Thu, 28 Jul 2022 07:22:37 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Tianyu Lan <ltykernel@gmail.com>
Cc:     hch@infradead.org, m.szyprowski@samsung.com, robin.murphy@arm.com,
        Tianyu Lan <tiala@microsoft.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] swiotlb: Fix passing local variable to
 debugfs_create_ulong()
Message-ID: <YuKbrTcSFHA7agvR@infradead.org>
References: <20220728072420.1782744-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728072420.1782744-1-ltykernel@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, applied.
