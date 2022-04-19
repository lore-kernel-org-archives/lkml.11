Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1F7C4332F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Apr 2022 05:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348683AbiDSFrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Apr 2022 01:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbiDSFrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 01:47:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089B627FD7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 22:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=TnEQll+eBh1Ey36hApYxQP6G3m
        LebYE2b1XUMVcgoLDnyseSbU7/gZOXXYm4XTqddXV3kI357H8g3Bqp2aoTEVbyynMuy2YUh/DoGWC
        H+GQO9xwetNjyex6+qCowERgtJgMGM+7tyd6sujsINdniJvcOjmAvt3SmTMpeuubdesZQT+InRcq4
        XwV3pAeziYH1fALhc+enIPm9lcvJ6+Yndxbea8QYEFpnbKUJ6RIbhHGlVyvol+D5YqsU601t+qA56
        L2rsQ0FrmVw/LKOaoJRbqAQoKbMcOSzxZqHe9ZBIr9hmnoa8W84uRhPjPi9vqwy9v2qYAl5WqNvgy
        gSkf9q7w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nggf5-001cFR-Fu; Tue, 19 Apr 2022 05:44:27 +0000
Date:   Mon, 18 Apr 2022 22:44:27 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iommu/vt-d: Change return type of
 dmar_insert_one_dev_info()
Message-ID: <Yl5MOxKAyNY1AXag@infradead.org>
References: <20220416120423.879552-1-baolu.lu@linux.intel.com>
 <20220416120423.879552-2-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220416120423.879552-2-baolu.lu@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
