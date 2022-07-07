Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50A6C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Jul 2022 04:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235047AbiGGE6t (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Jul 2022 00:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiGGE6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 00:58:47 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F5D25E98;
        Wed,  6 Jul 2022 21:58:45 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 27FFD68AA6; Thu,  7 Jul 2022 06:58:41 +0200 (CEST)
Date:   Thu, 7 Jul 2022 06:58:40 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: fully convert arm to use dma-direct v3
Message-ID: <20220707045840.GA12672@lst.de>
References: <20220614092047.572235-1-hch@lst.de> <20220629062837.GA17140@lst.de> <Yrv0HLSj3xAHa+av@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yrv0HLSj3xAHa+av@kroah.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 08:41:32AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Jun 29, 2022 at 08:28:37AM +0200, Christoph Hellwig wrote:
> > Any comments or additional testing?  It would be really great to get
> > this off the table.
> 
> For the USB bits:
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

So given that we're not making any progress on getting anyone interested
on the series, I'm tempted to just pull it into the dma-mapping tree
this weekend so that we'll finally have all architectures using the
common code.

Anyone who has real concerns, please scream now.
