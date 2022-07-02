Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCCDC433EF
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Jul 2022 09:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbiGBJoM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Jul 2022 05:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiGBJoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 05:44:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2F713DD7
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 02:44:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2E1B60B30
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 09:44:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFBFFC34114;
        Sat,  2 Jul 2022 09:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656755049;
        bh=eEHHSuYuqZS5McmgfU626Axa9JPZVKK9isQ4pht82jA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r+EE9SVzQ+GRkB3D+I3QaY7n9xdGIS78EWAP5eMzIsIPcSAH04e7hO5BBmU3Wa8eS
         snNXdrw3/lLINOt+A0LLIwuUl5+30S91r59iX/Do4Ju4Y86OwM2an3GsQKGaUeSEqF
         kvpCPxnyIe987aOjyhWgqDws2P9JK1vHbZdwmeTLw59Q4+tbNAPV4cxrOrQDeHtzeA
         SdWljkHNgElRaCFJv/DKrgwBvgpC8sChFrIDwtogL6cFU7Gq+dELL9JnXu9bDbRqTn
         KXzjcIwDFMLoMv3pNDcMQGWjJ/nxUgYc3ZfXavOrxStJdJRExmIdFTK4l5JfipLlp6
         apjLVqtBkN5tg==
Received: by pali.im (Postfix)
        id ED2E4777; Sat,  2 Jul 2022 11:44:05 +0200 (CEST)
Date:   Sat, 2 Jul 2022 11:44:05 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: e500: Fix compilation with gcc e500 compiler
Message-ID: <20220702094405.tp7eo4df7fjvn2ng@pali>
References: <20220524093939.30927-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220524093939.30927-1-pali@kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 24 May 2022 11:39:39 Pali Rohár wrote:
> gcc e500 compiler does not support -mcpu=powerpc option. When it is
> specified then gcc throws compile error:
> 
>   gcc: error: unrecognized argument in option ‘-mcpu=powerpc’
>   gcc: note: valid arguments to ‘-mcpu=’ are: 8540 8548 native
> 
> So do not set -mcpu=powerpc option when CONFIG_E500 is set. Correct option
> -mcpu=8540 for CONFIG_E500 is set few lines below in that Makefile.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Cc: stable@vger.kernel.org

Michael, do you have any objections about this patch?

> ---
>  arch/powerpc/Makefile | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index eb541e730d3c..87f9f29ac9d2 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -22,11 +22,16 @@ ifdef CONFIG_PPC32
>  # or platform code sets later on the command line, but they are needed
>  # to set a sane 32-bit cpu target for the 64-bit cross compiler which
>  # may default to the wrong ISA.
> +# Never set -mcpu=powerpc option for gcc e500 compiler because this
> +# option is unsupported and throws error. The correct option for
> +# CONFIG_E500 is -mcpu=8540 and it is set few lines below.
> +ifndef CONFIG_E500
>  KBUILD_CFLAGS		+= -mcpu=powerpc
>  KBUILD_AFLAGS		+= -mcpu=powerpc
>  endif
>  endif
>  endif
> +endif
>  
>  ifdef CONFIG_PPC_BOOK3S_32
>  KBUILD_CFLAGS		+= -mcpu=powerpc
> -- 
> 2.20.1
> 
