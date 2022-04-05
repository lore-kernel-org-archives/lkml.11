Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B915C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 04:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbiDEEiv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 00:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiDEEiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 00:38:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E79812AD9
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 21:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=PishwmSkba+6D+6k5V6o5GGkHq
        YGEgWPT+5Ej32Ri0lLLNFizXF1ZK/uGD6uXpIGH5knUGR6/E2XVKTQgJmjbGvB75gYk3l/mSDACQr
        fqQ3icDeZj4TQtnwYnAZM1oVSpHQWJcdEA5L1xFY2hDx2yX3CUaZljHlq3RVjjcK6Pcb0f5It8nfa
        s0TgF3FCsXVwPEzOxcoJtKEf4slt7sBdHH9HSrAVcugsaKLcZB5CRWGfV9gjYzNLSqi7rHpaomcKO
        hGg/SRwP0eWGc+RVy/ozq3kbCIqHfGrg5ZMIedLSLZzoc1P/R9odCNsx2KlEuMpk61VU50/hT3d+h
        CcUrqfDQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbatz-00H56R-Ij; Tue, 05 Apr 2022 04:34:47 +0000
Date:   Mon, 4 Apr 2022 21:34:47 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Suthikulpanit Suravee <Suravee.Suthikulpanit@amd.com>,
        Hegde Vasant <Vasant.Hegde@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] dma-iommu: Check that swiotlb is active before
 trying to use it
Message-ID: <YkvG57GhOygOs4iP@infradead.org>
References: <20220404204723.9767-1-mario.limonciello@amd.com>
 <20220404204723.9767-3-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404204723.9767-3-mario.limonciello@amd.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
