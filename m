Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02785CCA473
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jul 2022 15:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235443AbiGVPEb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jul 2022 11:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235402AbiGVPEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 11:04:30 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1417393B;
        Fri, 22 Jul 2022 08:04:29 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C96A768AFE; Fri, 22 Jul 2022 17:04:26 +0200 (CEST)
Date:   Fri, 22 Jul 2022 17:04:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dma-mapping: update comment after dmabounce removal
Message-ID: <20220722150426.GA7275@lst.de>
References: <20220720190208.11270-1-lukas.bulwahn@gmail.com> <CAK8P3a04pfMoTbWDSdUPYXhXi03i3AjWM1B-8j2Z1OJKRmC14A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a04pfMoTbWDSdUPYXhXi03i3AjWM1B-8j2Z1OJKRmC14A@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 02:50:20PM +0200, Arnd Bergmann wrote:
> The e3217540c271 commit is only in Christoph's dma-mapping tree, so this would
> ideally get applied on top before the merge window.

I'll pick it up.
