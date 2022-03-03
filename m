Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5721DC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Mar 2022 11:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbiCCLDQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Mar 2022 06:03:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbiCCLDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 06:03:05 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD0417BC6B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 03:02:20 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 806AC68AFE; Thu,  3 Mar 2022 12:02:16 +0100 (CET)
Date:   Thu, 3 Mar 2022 12:02:16 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Igor Zhbanov <i.zhbanov@omprussia.ru>,
        Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] kernel: dma-debug: fix return value of __setup handlers
Message-ID: <20220303110216.GA15318@lst.de>
References: <20220228220453.23726-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228220453.23726-1-rdunlap@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to the dma-mapping tree.
