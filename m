Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D4AC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Feb 2022 21:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbiBNVei (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Feb 2022 16:34:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbiBNVdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 16:33:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8477D156944;
        Mon, 14 Feb 2022 13:31:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3EC261149;
        Mon, 14 Feb 2022 19:26:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C2AC340E9;
        Mon, 14 Feb 2022 19:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644866774;
        bh=8OIKkvvfaqbfiXx6HxLgwmXQKPZd32nQMI4wVpB9sD4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MxGGXIGkFK3CQXZOaO3MxVKKNcdlFIdqEiLYYwvcsmotbSYi4+niO7T6w0y/Qsua6
         +qOy+uDFncgkHa9ru6UhJLZUb7DpjOT6WqjYqSCzl28dLbMtpxc40Ve56UjKeyfWvk
         Q2xjEOXs/LQElo5sypnmq/CtYx2Dcgq1AafFBKCZ3wvXiDIXIfCOm/VLVB6n5RiD5y
         +8FP8qW3jE2S9wcTdiEjopUteIXFlit6r/Vd6aSO90xDPfnBHGZTSnXwdqISulFSgU
         1KZeseVtOR4GFs76lBfN5B2Q8seMbHAt/asKmz0HBdOHcjwJUpcPF5XFnWyEzY3KhI
         Ts+6ZrUefW+0w==
Date:   Mon, 14 Feb 2022 19:26:12 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jens Axboe <axboe@kernel.dk>, Theodore Ts'o <tytso@mit.edu>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Satya Tangirala <satyat@google.com>
Subject: Re: linux-next: manual merge of the block tree with the fscrypt tree
Message-ID: <Ygqs1PrwXnV1eu8/@gmail.com>
References: <20220214121139.2e5a4be5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214121139.2e5a4be5@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 12:11:39PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the block tree got a conflict in:
> 
>   fs/iomap/direct-io.c
> 
> between commit:
> 
>   489734ef94f4 ("iomap: support direct I/O with fscrypt using blk-crypto")
> 
> from the fscrypt tree and commit:
> 
>   07888c665b40 ("block: pass a block_device and opf to bio_alloc")
> 
> from the block tree.
> 
> I fixed it up (I think - see below) and can carry the fix as necessary.
> This is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 

Looks fine to me, thanks.

- Eric
