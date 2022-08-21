Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32890C00140
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Aug 2022 05:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiHUFzn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Aug 2022 01:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiHUFzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 01:55:41 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78C715704
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 22:55:40 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 43BAE68AA6; Sun, 21 Aug 2022 07:55:37 +0200 (CEST)
Date:   Sun, 21 Aug 2022 07:55:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 2/4] ARM: footbridge: remove leftover from
 personal-server
Message-ID: <20220821055537.GB25950@lst.de>
References: <20220818211550.3272321-1-arnd@kernel.org> <20220818211550.3272321-3-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818211550.3272321-3-arnd@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 11:15:48PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The machine was removed a while ago, and the checks are
> now useless.

Curious, should entries for removed machines be kept in the mach-types
file?  Because that makes it really easy to leave dead code like this
around.

The patch itself looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
