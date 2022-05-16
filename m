Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3C2C433FE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 May 2022 06:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240088AbiEPGAt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 May 2022 02:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240069AbiEPGAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 02:00:45 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D28CE04;
        Sun, 15 May 2022 23:00:44 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id DEE5F68D08; Mon, 16 May 2022 08:00:34 +0200 (CEST)
Date:   Mon, 16 May 2022 08:00:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wefu@redhat.com, guoren@kernel.org, atishp@atishpatra.org,
        anup@brainfault.org, mick@ics.forth.gr, samuel@sholland.org,
        cmuellner@linux.com, philipp.tomsich@vrull.eu, robh+dt@kernel.org,
        krzk+dt@kernel.org, devicetree@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Atish Patra <atish.patra@wdc.com>
Subject: Re: [PATCH v2 2/3] riscv: Implement Zicbom-based cache management
 operations
Message-ID: <20220516060033.GC12339@lst.de>
References: <20220511214132.2281431-1-heiko@sntech.de> <20220511214132.2281431-3-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511214132.2281431-3-heiko@sntech.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm still only getting one of three patches here, making it impossible
to review.
