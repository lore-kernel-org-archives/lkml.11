Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9626C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 May 2022 16:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356348AbiELQMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 May 2022 12:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356291AbiELQLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 12:11:47 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB4ED666A6;
        Thu, 12 May 2022 09:11:42 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1npBPf-0001Vm-02; Thu, 12 May 2022 18:11:39 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 7F290C01DC; Thu, 12 May 2022 18:09:09 +0200 (CEST)
Date:   Thu, 12 May 2022 18:09:09 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: tools: no need to initialise statics to 0
Message-ID: <20220512160909.GC14475@alpha.franken.de>
References: <20220508023146.100385-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220508023146.100385-1-wangborong@cdjrlc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 08, 2022 at 10:31:46AM +0800, Jason Wang wrote:
> Static variables do not need to be initialised to 0, because compiler
> will initialise all uninitialised statics to 0. Thus, remove the
> unneeded initializations.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>  arch/mips/boot/tools/relocs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/boot/tools/relocs.c b/arch/mips/boot/tools/relocs.c
> index 1bf53f3524b3..02fc85f3e8ff 100644
> --- a/arch/mips/boot/tools/relocs.c
> +++ b/arch/mips/boot/tools/relocs.c
> @@ -351,7 +351,7 @@ static void read_symtabs(FILE *fp)
>  
>  static void read_relocs(FILE *fp)
>  {
> -	static unsigned long base = 0;
> +	static unsigned long base;
>  	int i, j;
>  
>  	if (!base) {
> -- 
> 2.35.1

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
