Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E40C28CF5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jan 2022 16:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236461AbiAZQWC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jan 2022 11:22:02 -0500
Received: from verein.lst.de ([213.95.11.211]:40637 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236372AbiAZQWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 11:22:01 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3DD1368AFE; Wed, 26 Jan 2022 17:21:58 +0100 (CET)
Date:   Wed, 26 Jan 2022 17:21:57 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     hch@lst.de, konrad@kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, tientzu@chromium.org,
        guozhengkui@vivo.com
Subject: Re: [PATCH 0/3] Some minor SWIOTLB cleanups
Message-ID: <20220126162157.GA31431@lst.de>
References: <cover.1643028164.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1643028164.git.robin.murphy@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to the dma-mapping for-next tree.
