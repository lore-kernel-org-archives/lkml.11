Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C544CC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Mar 2022 10:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241372AbiCJKrP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Mar 2022 05:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiCJKrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 05:47:10 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D19F213DE3C;
        Thu, 10 Mar 2022 02:46:09 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 06AE892009C; Thu, 10 Mar 2022 11:46:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id F3D0292009B;
        Thu, 10 Mar 2022 10:46:08 +0000 (GMT)
Date:   Thu, 10 Mar 2022 10:46:08 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@kernel.org
Subject: Re: [PATCH] MIPS: Handle address errors for accesses above CPU max
 virtual user address
In-Reply-To: <20220222155345.138861-1-tsbogend@alpha.franken.de>
Message-ID: <alpine.DEB.2.21.2203101040530.47558@angie.orcam.me.uk>
References: <20220222155345.138861-1-tsbogend@alpha.franken.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Feb 2022, Thomas Bogendoerfer wrote:

> Address errors have always been treated as unaliged accesses and handled
> as such. But address errors are also issued for illegal accesses like
> user to kernel space or accesses outside of implemented spaces. This
> change implements Linux exception handling for accesses to the illegal
> space above the CPU implemented maximum virtual user address and the
> MIPS 64bit architecture maximum. With this we can now use a fixed value
> for the maximum task size on every MIPS CPU and get a more optimized
> access_ok().

 Decades ago I had a patch to handle this with CPU-specific limits, which 
in the end I have not submitted for one reason or another.  I guess we 
didn't have what is `cpu_vmbits' nowadays.  I'll see if I can dig it out 
and check if there's anything interesting there we might also require.

 Overall good work, and I'm rather embarassed we have gone so far without 
it.  Thanks!

  Maciej
