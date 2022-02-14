Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A82C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Feb 2022 07:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241195AbiBNHQc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Feb 2022 02:16:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233987AbiBNHQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 02:16:30 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6891859395;
        Sun, 13 Feb 2022 23:16:23 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id CE31468AFE; Mon, 14 Feb 2022 08:16:20 +0100 (CET)
Date:   Mon, 14 Feb 2022 08:16:20 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the akpm-current tree
Message-ID: <20220214071620.GB17137@lst.de>
References: <20220214180040.44f8316a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214180040.44f8316a@canb.auug.org.au>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 06:00:40PM +1100, Stephen Rothwell wrote:
> Presumably caused by commit
> 
>   5ba71dc7727a ("mm: don't include <linux/memremap.h> in <linux/mm.h>")
> 
> I applied the following patch:

Thanks,

the fixup looks good to me.
