Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641B6C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Mar 2022 06:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348095AbiCXGS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Mar 2022 02:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347185AbiCXGSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 02:18:25 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D839681B;
        Wed, 23 Mar 2022 23:16:54 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D871768BEB; Thu, 24 Mar 2022 07:16:50 +0100 (CET)
Date:   Thu, 24 Mar 2022 07:16:50 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 7/9] nvme-apple: Serialize command issue
Message-ID: <20220324061650.GB12330@lst.de>
References: <20220321165049.35985-1-sven@svenpeter.dev> <20220321165049.35985-8-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321165049.35985-8-sven@svenpeter.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 05:50:47PM +0100, Sven Peter wrote:
> From: Jens Axboe <axboe@kernel.dk>
> 
> This controller shouldn't need serialization of command issue since
> the SQ is replaced by a simple array and commands are issued by writing
> the array index to a MMIO register.
> Without serialization however sometimes commands are still executed
> correctly and appear in the CQ but never trigger an interrupt.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> [sven: added our best guess why this needs to be done]
> Signed-off-by: Sven Peter <sven@svenpeter.dev>

This really should go into the previous patch.
