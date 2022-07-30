Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A587C19F2C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jul 2022 09:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbiG3JJG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jul 2022 05:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiG3JJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 05:09:03 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB57B357EF;
        Sat, 30 Jul 2022 02:09:01 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1oHiSy-000199-00; Sat, 30 Jul 2022 11:09:00 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 758B0C0192; Sat, 30 Jul 2022 11:02:35 +0200 (CEST)
Date:   Sat, 30 Jul 2022 11:02:35 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Alexander A Sverdlin <alexander.sverdlin@nokia.com>
Cc:     linux-mips@vger.kernel.org, Joe Perches <joe@perches.com>,
        Corey Minyard <cminyard@mvista.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] MIPS: Restore CONFIG_CAVIUM_RESERVE32
Message-ID: <20220730090235.GA4620@alpha.franken.de>
References: <20220725091740.28188-1-alexander.sverdlin@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725091740.28188-1-alexander.sverdlin@nokia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 11:17:38AM +0200, Alexander A Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> 
> We have been using the option but the definition in the Kconfig has not
> been upstreamed. Fix that.
> 
> Alexander Sverdlin (2):
>   MIPS: Introduce CAVIUM_RESERVE32 Kconfig option
>   Revert "MIPS: octeon: Remove vestiges of CONFIG_CAVIUM_RESERVE32"
> 
>  arch/mips/cavium-octeon/Kconfig                    | 12 +++++++
>  arch/mips/cavium-octeon/executive/cvmx-cmd-queue.c | 21 +++++++++---
>  arch/mips/cavium-octeon/setup.c                    | 38 +++++++++++++++++++++-
>  3 files changed, 66 insertions(+), 5 deletions(-)

series applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
