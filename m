Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A84C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Feb 2022 13:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241523AbiBQN6V (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Feb 2022 08:58:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241519AbiBQN6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 08:58:18 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DBA3627B4BB;
        Thu, 17 Feb 2022 05:58:03 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 8389B92009C; Thu, 17 Feb 2022 14:58:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 7CCD092009B;
        Thu, 17 Feb 2022 13:58:01 +0000 (GMT)
Date:   Thu, 17 Feb 2022 13:58:01 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: remove asm/war.h
In-Reply-To: <20220217134630.42203-1-tsbogend@alpha.franken.de>
Message-ID: <alpine.DEB.2.21.2202171352060.56785@angie.orcam.me.uk>
References: <20220217134630.42203-1-tsbogend@alpha.franken.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Feb 2022, Thomas Bogendoerfer wrote:

> diff --git a/arch/mips/kernel/r4k-bugs64.c b/arch/mips/kernel/r4k-bugs64.c
> index 35729c9e6cfa..11392e40d034 100644
> --- a/arch/mips/kernel/r4k-bugs64.c
> +++ b/arch/mips/kernel/r4k-bugs64.c
> @@ -163,7 +163,8 @@ static __always_inline __init void check_mult_sh(void)
>  	}
>  
>  	pr_cont("no.\n");
> -	panic(bug64hit, !R4000_WAR ? r4kwar : nowar);
> +	panic(bug64hit, !IS_ENABLED(CONFIG_CPU_R4000_WORKAROUNDS) ? r4kwar :
> +								    nowar);

 I think it'll read better if formatted like this:

	panic(bug64hit,
	      !IS_ENABLED(CONFIG_CPU_R4000_WORKAROUNDS) ? r4kwar : nowar);

or without the negation even:

	panic(bug64hit,
	      IS_ENABLED(CONFIG_CPU_R4000_WORKAROUNDS) ? nowar : r4kwar);

Likewise throughout.

  Maciej
