Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5664DC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 24 May 2022 11:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236680AbiEXLcx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 May 2022 07:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233022AbiEXLcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 07:32:50 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E2C38BD28;
        Tue, 24 May 2022 04:32:47 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1ntSmM-0002HG-00; Tue, 24 May 2022 13:32:46 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 4B522C031F; Tue, 24 May 2022 13:31:05 +0200 (CEST)
Date:   Tue, 24 May 2022 13:31:05 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Juerg Haefliger <juerg.haefliger@canonical.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: Re: [PATCH] MIPS: Kconfig: Fix indentation and add endif comment
Message-ID: <20220524113105.GA7893@alpha.franken.de>
References: <20220524080311.22133-1-juergh@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524080311.22133-1-juergh@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 10:03:11AM +0200, Juerg Haefliger wrote:
> The convention for indentation seems to be a single tab. Help text is
> further indented by an additional two whitespaces. Fix the lines that
> violate these rules.
> 
> While add it, add a missing trailing endif comment.
> 
> Signed-off-by: Juerg Haefliger <juergh@canonical.com>
> ---
>  arch/mips/Kconfig | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
