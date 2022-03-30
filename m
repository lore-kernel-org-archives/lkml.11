Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C682C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Mar 2022 05:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242869AbiC3FUm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Mar 2022 01:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbiC3FUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 01:20:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6BC48890
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 22:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=4FbjI0mGO2cB0Id2W97AkYofax
        X5kj+mwsbJj6HYZ2QLgHdKWChD4QVvgt+ES6OPJjZxIFRgFTPg6im8jDwtasYkwpi4ml2DisxC0go
        AHkqth3yh+Npiu/yyrDACA0ewtt6qqnDwT1tKdFHTBXIOaXx12ZAXYtkdnDwsIROIcGtt6/mBWMzd
        VN7WL3JfII5dNund6267rMwt3vAhF0JuJP6q1aU4VBvNPv2TPxBh+HQ5o2LETS9E6CsvSu4BWNm/5
        AUSGq7VBgwOJpUgxSqefBtETE02L+l0giU8KZvX1UAR8bklanlaYOX4d0ovg/HeFMdgdeiCnXzGWh
        h1LN4Oug==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZQjD-00EGmb-Jw; Wed, 30 Mar 2022 05:18:43 +0000
Date:   Tue, 29 Mar 2022 22:18:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     mpenttil@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        apopple@nvidia.com, jhubbard@nvidia.com, rcampbell@nvidia.com,
        jgg@ziepe.ca, vbabka@suse.cz
Subject: Re: [PATCH v6] mm/hmm/test: use char dev with struct device to get
 device node
Message-ID: <YkPoM8P0NIlachv3@infradead.org>
References: <20220330004725.13428-1-mpenttil@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330004725.13428-1-mpenttil@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
