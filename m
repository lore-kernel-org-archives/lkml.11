Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE75C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Mar 2022 10:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234467AbiCaKFw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Mar 2022 06:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234485AbiCaKFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 06:05:49 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF58B53E9
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 03:03:59 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8B8CF68BFE; Thu, 31 Mar 2022 12:03:56 +0200 (CEST)
Date:   Thu, 31 Mar 2022 12:03:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, wefu@redhat.com,
        liush@allwinnertech.com, guoren@kernel.org, atishp@atishpatra.org,
        anup@brainfault.org, drew@beagleboard.org, hch@lst.de,
        arnd@arndb.de, wens@csie.org, maxime@cerno.tech,
        gfavor@ventanamicro.com, andrea.mondelli@huawei.com,
        behrensj@mit.edu, xinhaoqu@huawei.com, mick@ics.forth.gr,
        allen.baum@esperantotech.com, jscheid@ventanamicro.com,
        rtrauben@gmail.com, samuel@sholland.org, cmuellner@linux.com,
        philipp.tomsich@vrull.eu
Subject: Re: [PATCH v8 12/14] riscv: remove FIXMAP_PAGE_IO and fall back to
 its default value
Message-ID: <20220331100356.GI23422@lst.de>
References: <20220324000710.575331-1-heiko@sntech.de> <20220324000710.575331-13-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324000710.575331-13-heiko@sntech.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 01:07:08AM +0100, Heiko Stuebner wrote:
> If not defined in the arch, FIXMAP_PAGE_IO defaults to PAGE_KERNEL_IO,
> which we defined when adding the svpbmt implementation.
> 
> So drop the FIXMAP_PAGE_IO riscv define.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
