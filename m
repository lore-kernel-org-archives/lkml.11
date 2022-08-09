Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AB0C19F2D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Aug 2022 08:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239544AbiHIIIU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Aug 2022 04:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233351AbiHIIIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 04:08:16 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0B71C10B
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 01:08:13 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7D89868AA6; Tue,  9 Aug 2022 10:08:09 +0200 (CEST)
Date:   Tue, 9 Aug 2022 10:08:09 +0200
From:   ChristophHellwig <hch@lst.de>
To:     Liwei Song <liwei.song@windriver.com>
Cc:     MiquelRaynal <miquel.raynal@bootlin.com>,
        RichardWeinberger <richard@nod.at>,
        VigneshRaghavendra <vigneshr@ti.com>,
        ChristophHellwig <hch@lst.de>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd_blkdevs: add mtd_table_mutex lock back to
 blktrans_{open, release} to avoid race condition
Message-ID: <20220809080809.GB14727@lst.de>
References: <20220809075753.21950-1-liwei.song@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809075753.21950-1-liwei.song@windriver.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2022 at 03:57:53PM +0800, Liwei Song wrote:
> without lock mtd_table_mutex in blktrans_{open, release}, there will
> be a race condition when access devices /dev/mtd1 and /dev/mtdblock1
> at the same time with a high frequency open and close test:
> 
> kernel BUG at drivers/mtd/mtdcore.c:1221!
> lr : blktrans_release+0xb0/0x120

This does not seem on a current mainline kernel and seems to be
a somewhat incomplete backtrace.  Can you send the full dmesg of
a latest mainline run and maybe share the reproducer?

> diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
> index b8ae1ec14e17..147e4a11dfe4 100644
> --- a/drivers/mtd/mtd_blkdevs.c
> +++ b/drivers/mtd/mtd_blkdevs.c
> @@ -188,6 +188,8 @@ static int blktrans_open(struct block_device *bdev, fmode_t mode)
>  
>  	kref_get(&dev->ref);
>  
> +	if (!mutex_trylock(&mtd_table_mutex))
> +		return ret;

No, that's not really the solution.

Turning the kref_get above into a kref_get_unless_zero might be better
path to look into.
