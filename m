Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8A7C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Mar 2022 10:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbiCaKIy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Mar 2022 06:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbiCaKIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 06:08:52 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26E22028A5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 03:07:05 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B6BAD68B05; Thu, 31 Mar 2022 12:07:01 +0200 (CEST)
Date:   Thu, 31 Mar 2022 12:07:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wefu@redhat.com, guoren@kernel.org, atishp@atishpatra.org,
        anup@brainfault.org, mick@ics.forth.gr, samuel@sholland.org,
        cmuellner@linux.com, philipp.tomsich@vrull.eu,
        Christoph Hellwig <hch@lst.de>,
        Atish Patra <atish.patra@wdc.com>
Subject: Re: [PATCH 1/2] riscv: Implement Zicbom-based cache management
 operations
Message-ID: <20220331100701.GJ23422@lst.de>
References: <20220307224620.1933061-1-heiko@sntech.de> <20220307224620.1933061-2-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307224620.1933061-2-heiko@sntech.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I somehow only got patch 1 out of 2, which makes reviewing this very
hard.
