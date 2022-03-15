Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0525EC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Mar 2022 08:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345834AbiCOIXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Mar 2022 04:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345858AbiCOIWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:22:54 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B034BFF1;
        Tue, 15 Mar 2022 01:21:43 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 210CA68AA6; Tue, 15 Mar 2022 09:21:40 +0100 (CET)
Date:   Tue, 15 Mar 2022 09:21:39 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the nvdimm tree with the block tree
Message-ID: <20220315082139.GA3447@lst.de>
References: <20220315191831.15816703@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315191831.15816703@canb.auug.org.au>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 07:18:31PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the nvdimm tree got a conflict in:
> 
>   drivers/nvdimm/blk.c
> 
> between commits:
> 
>   322cbb50de71 ("block: remove genhd.h")
>   20072ec82864 ("nvdimm-blk: use bvec_kmap_local in nd_blk_rw_integrity")
> 
> from the block tree and commit:
> 
>   f8669f1d6a86 ("nvdimm/blk: Delete the block-aperture window driver")
> 
> from the nvdimm tree.

Yeah, the conflict resolution looks obviously correct :)

Thanks!
