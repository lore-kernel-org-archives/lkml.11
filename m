Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69F6C00140
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Aug 2022 06:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiHUGXv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Aug 2022 02:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiHUGXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 02:23:50 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFB91F2D5;
        Sat, 20 Aug 2022 23:23:48 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8576B68AA6; Sun, 21 Aug 2022 08:23:45 +0200 (CEST)
Date:   Sun, 21 Aug 2022 08:23:45 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Alan J. Wylie" <alan@wylie.me.uk>, linux-usb@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: Regression in 5.19.0: USB errors during boot
Message-ID: <20220821062345.GA26598@lst.de>
References: <25342.20092.262450.330346@wylie.me.uk> <Yv5Q8gDvVTGOHd8k@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yv5Q8gDvVTGOHd8k@kroah.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 04:47:14PM +0200, Greg Kroah-Hartman wrote:
> What is the output of the lspci -v for the USB 3 controller?
> 
> Christoph, any ideas?

Well, with that commit it must be related to dma ops selection.
As this appears to be an AMD system the options here are direct,
amd_iommu and possibly amd_gart as the odd one in the mix.

Alan, can you send me your .config?
