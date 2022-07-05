Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FC6C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Jul 2022 10:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbiGEKlP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Jul 2022 06:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbiGEKkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 06:40:46 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4E0315802;
        Tue,  5 Jul 2022 03:40:45 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1o8fz0-0002Jv-04; Tue, 05 Jul 2022 12:40:42 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 8DCB0C0230; Tue,  5 Jul 2022 12:25:27 +0200 (CEST)
Date:   Tue, 5 Jul 2022 12:25:27 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Zhang Jiaming <jiaming@nfschina.com>
Cc:     rdunlap@infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, liqiong@nfschina.com,
        renyu@nfschina.com
Subject: Re: [PATCH v2] MIPS: Fix some typos
Message-ID: <20220705102527.GH9951@alpha.franken.de>
References: <20220622090713.24370-1-jiaming@nfschina.com>
 <20220622102720.30450-1-jiaming@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622102720.30450-1-jiaming@nfschina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 06:27:20PM +0800, Zhang Jiaming wrote:
> Change 'modifed' to 'modified'.
> Change 'relys' to 'relies'.
> 
> Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
> ---
>  .../mips/cavium-octeon/executive/cvmx-helper-board.c |  4 ++--
>  arch/mips/include/asm/octeon/cvmx-helper-board.h     | 12 ++++++------
>  2 files changed, 8 insertions(+), 8 deletions(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
