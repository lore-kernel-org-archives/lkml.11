Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AA0C433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 May 2022 11:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236556AbiEXLRA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 May 2022 07:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236529AbiEXLQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 07:16:06 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F291A805
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 04:16:05 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L6s8412j8z4yTR;
        Tue, 24 May 2022 21:16:04 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     paulus@samba.org, benh@kernel.crashing.org,
        YueHaibing <yuehaibing@huawei.com>, christophe.leroy@csgroup.eu,
        mpe@ellerman.id.au
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220517094830.27560-1-yuehaibing@huawei.com>
References: <20220517094830.27560-1-yuehaibing@huawei.com>
Subject: Re: [PATCH -next] powerpc/book3e: Fix build error
Message-Id: <165339057319.1718562.17208569105645113277.b4-ty@ellerman.id.au>
Date:   Tue, 24 May 2022 21:09:33 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 May 2022 17:48:30 +0800, YueHaibing wrote:
> arch/powerpc/mm/nohash/fsl_book3e.c: In function ‘relocate_init’:
> arch/powerpc/mm/nohash/fsl_book3e.c:348:2: error: implicit declaration of function ‘early_get_first_memblock_info’ [-Werror=implicit-function-declaration]
>   early_get_first_memblock_info(__va(dt_ptr), &size);
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Add missing include file linux/of_fdt.h to fix this.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/book3e: Fix build error
      https://git.kernel.org/powerpc/c/7574dd080ee0a1e8a9c6312dc7c8fe97f73415ff

cheers
