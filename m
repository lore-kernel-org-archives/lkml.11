Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC5AC433FE
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Apr 2022 15:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378799AbiDDQB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Apr 2022 12:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242759AbiDDQB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:01:26 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66401AD85;
        Mon,  4 Apr 2022 08:59:28 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id AB6CB68AFE; Mon,  4 Apr 2022 17:59:24 +0200 (CEST)
Date:   Mon, 4 Apr 2022 17:59:24 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hector Martin <marcan@marcan.st>
Cc:     Christoph Hellwig <hch@lst.de>, Sven Peter <sven@svenpeter.dev>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 6/9] nvme-apple: Add initial Apple SoC NVMe driver
Message-ID: <20220404155924.GA9764@lst.de>
References: <20220321165049.35985-1-sven@svenpeter.dev> <20220321165049.35985-7-sven@svenpeter.dev> <20220324061620.GA12330@lst.de> <18f3a7e6-16d1-2037-90e7-1c0b1b2fbb1c@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18f3a7e6-16d1-2037-90e7-1c0b1b2fbb1c@marcan.st>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 12:57:33AM +0900, Hector Martin wrote:
> The kernel hard limit is 100-character lines, not 80-character lines.
> Maintainers for existing drivers are certainly free to stick to 80 chars
> if they like it that way, but I don't see why we should still be
> enforcing that for new code. See bdc48fa11e46.

Because 100 is completely utterly unreadable if is not for individual
lines like strings, and that is actually how Linus stated it in CodingStyle.

Your code as-is is completely unreadable and will not go into
drivers/nvme/ in that form.
