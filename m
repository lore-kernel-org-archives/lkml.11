Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D13C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  1 May 2022 11:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346519AbiEALiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 May 2022 07:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237006AbiEALiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 07:38:07 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8EAD61BEB6;
        Sun,  1 May 2022 04:34:42 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 848F792009C; Sun,  1 May 2022 13:34:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 75AD092009B;
        Sun,  1 May 2022 12:34:41 +0100 (BST)
Date:   Sun, 1 May 2022 12:34:41 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Stephen Zhang <starzhangzsd@gmail.com>
cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        liam.howlett@oracle.com, Geert Uytterhoeven <geert@linux-m68k.org>,
        ebiederm@xmission.com, alobakin@pm.me, f.fainelli@gmail.com,
        paul@crapouillou.net, linux@roeck-us.net, anemo@mba.ocn.ne.jp,
        zhangshida@kylinos.cn, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH v3] MIPS: adding a safety check for cpu_has_fpu
In-Reply-To: <20220501030956.786012-1-starzhangzsd@gmail.com>
Message-ID: <alpine.DEB.2.21.2205011232020.9383@angie.orcam.me.uk>
References: <20220501030956.786012-1-starzhangzsd@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 May 2022, Stephen Zhang wrote:

> diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
> index de8cb2ccb781..57ff0f8a507c 100644
> --- a/arch/mips/include/asm/cpu-features.h
> +++ b/arch/mips/include/asm/cpu-features.h
> @@ -134,6 +134,11 @@
>  # endif
>  #else
>  # define raw_cpu_has_fpu	cpu_has_fpu
> +# ifndef CONFIG_MIPS_FP_SUPPORT
> +#  if cpu_has_fpu
> +#   error "Forcing `cpu_has_fpu' to non-zero is not supported"
> +#  endif
> +# endif
>  #endif

 For this to work for `nofpu' the check has to be outside the conditional, 
possibly right below the comment we've been discussing.

  Maciej
