Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7139DC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jan 2022 07:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbiAMHV1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jan 2022 02:21:27 -0500
Received: from verein.lst.de ([213.95.11.211]:48760 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229670AbiAMHV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 02:21:26 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id F41FA68B05; Thu, 13 Jan 2022 08:21:22 +0100 (CET)
Date:   Thu, 13 Jan 2022 08:21:22 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] erofs: fix fsdax partition offset handling
Message-ID: <20220113072122.GA21315@lst.de>
References: <20220113051845.244461-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220113051845.244461-1-hsiangkao@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good, thanks for fixing this up:

Reviewed-by: Christoph Hellwig <hch@lst.de>
