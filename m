Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCEB1C19F2A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Aug 2022 09:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234915AbiHKJlp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Aug 2022 05:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbiHKJlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 05:41:42 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82A62D1FC
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 02:41:40 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4M3MJf6BgNz4x1K;
        Thu, 11 Aug 2022 19:41:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1660210899;
        bh=QvU3Ii0mNqZHfLnF6Zfdgva2T6Ppk7BMjH3eteu8YK0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=kEbdDLRB31+agt8BJ/TeC6VhWX4NEHL3dNzlAAHEaVglBt/IPlWyXaQbYxPzDNupK
         VN/OxNUYdRcFRQDTumj6IpYsWApJkiEfNpC+xnmIW800GnzemkKLeC69T1tQDdt8VF
         N7ZCOmwhsPZ/rEPktpKlVXB8XRLL1+e3e8xvPPtbPYv8B1cuKUJqti67ADjcR04r7/
         Y1outOTSoXOrmVjpBPII2/A3K4LG5K8L611udCZY904nczWqIKDMpdnIh2o61ChM2Z
         faTpKkkrkJqfZLzfaY+uD9NVhnVPIC956S7DAIQ5p6oSzyY80OGjQKaLQxpqU42AnZ
         LMao+0e4mYQHQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Anders Roxell <anders.roxell@linaro.org>, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     llvm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCHv3, resend] powerpc: mm: radix_tlb: rearrange the if-else
 block
In-Reply-To: <20220810114318.3220630-1-anders.roxell@linaro.org>
References: <20220810114318.3220630-1-anders.roxell@linaro.org>
Date:   Thu, 11 Aug 2022 19:41:35 +1000
Message-ID: <87fsi3ce28.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anders Roxell <anders.roxell@linaro.org> writes:
> Clang warns:
>
> arch/powerpc/mm/book3s64/radix_tlb.c:1191:23: error: variable 'hstart' is uninitialized when used here [-Werror,-Wuninitialized]
>                                 __tlbiel_va_range(hstart, hend, pid,
>                                                   ^~~~~~
> arch/powerpc/mm/book3s64/radix_tlb.c:1175:23: note: initialize the variable 'hstart' to silence this warning
>                 unsigned long hstart, hend;
>                                     ^
>                                      = 0
> arch/powerpc/mm/book3s64/radix_tlb.c:1191:31: error: variable 'hend' is uninitialized when used here [-Werror,-Wuninitialized]
>                                 __tlbiel_va_range(hstart, hend, pid,
>                                                           ^~~~
> arch/powerpc/mm/book3s64/radix_tlb.c:1175:29: note: initialize the variable 'hend' to silence this warning
>                 unsigned long hstart, hend;
>                                           ^
>                                            = 0
> 2 errors generated.

Which version & config are you building?

I don't see this warning in my test builds.

cheers
