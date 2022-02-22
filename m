Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6198AC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Feb 2022 08:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiBVIsV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Feb 2022 03:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiBVIsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 03:48:12 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 289F4A418C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 00:47:48 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nMQpn-0001CP-01; Tue, 22 Feb 2022 09:47:47 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 32E2AC2609; Tue, 22 Feb 2022 09:45:49 +0100 (CET)
Date:   Tue, 22 Feb 2022 09:45:49 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Nemanja Rakovic <nemanja.rakovic@syrmia.com>
Cc:     linux-kernel@vger.kernel.org, dragan.mladjenovic@syrmia.com,
        elver@google.com
Subject: Re: [PATCH V3] mips-next: Enable KCSAN
Message-ID: <20220222084549.GB7049@alpha.franken.de>
References: <20220221121225.8699-1-nemanja.rakovic@syrmia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221121225.8699-1-nemanja.rakovic@syrmia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 01:12:25PM +0100, Nemanja Rakovic wrote:
> Replaces KASAN_SANITIZE with KCSAN_SANITIZE in
> boot/compressed/Makefile.
> 
> Fixes: e0a8b93efa23 mips: Enable KCSAN
> Signed-off-by: Nemanja Rakovic <nemanja.rakovic@syrmia.com>
> ---
>  arch/mips/boot/compressed/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
> index a35f78212ea9..6cc28173bee8 100644
> --- a/arch/mips/boot/compressed/Makefile
> +++ b/arch/mips/boot/compressed/Makefile
> @@ -38,7 +38,7 @@ KBUILD_AFLAGS := $(KBUILD_AFLAGS) -D__ASSEMBLY__ \
>  KCOV_INSTRUMENT		:= n
>  GCOV_PROFILE := n
>  UBSAN_SANITIZE := n
> -KASAN_SANITIZE			:= n
> +KCSAN_SANITIZE			:= n
>  
>  # decompressor objects (linked with vmlinuz)
>  vmlinuzobjs-y := $(obj)/head.o $(obj)/decompress.o $(obj)/string.o $(obj)/bswapsi.o
> -- 
> 2.17.1

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
