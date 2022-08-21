Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E44EC00140
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Aug 2022 23:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbiHUXJT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Aug 2022 19:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbiHUXJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 19:09:16 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6D613EBE
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 16:09:13 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4M9rlm38Xjz4wgr;
        Mon, 22 Aug 2022 09:09:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1661123348;
        bh=ot4vNPXID2qHzyKPZNzTF6jzsfFG44Rik1Jxj+q9etI=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=qnKx3AW22cbizwm3VfJDlQCqjy1Qh8ntG4y0D6gtqPBW8EcSMZqHYv2C4VF90ju19
         9fS3oiyNGeZ5majD6ugg7+mGAX2z0RrePFUK3MrIlcMH2AcTQVieiJcDi2o+56BRYI
         yacNyzgRYObAsD4vzOJdiYasClSjYqbHV0P/nqTkL28PcGn57Q6sQT/MY6TbVmEygg
         cQX9+TKOVAhG9sOYNK5p2T3bMh+O0YW/DUrEB8JS//ehqg17f6dew7RnL40Z6cQSkA
         4kKQzYDkwua5PMsLQK93WpWaWmvKlAkpf4NBlekF5PfSeS2O/oMf0oEVElgoqFs3rn
         Vq0uCHqtiPe/g==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH] kernel: exit: cleanup release_thread()
In-Reply-To: <20220819014406.32266-1-wangkefeng.wang@huawei.com>
References: <20220819014406.32266-1-wangkefeng.wang@huawei.com>
Date:   Mon, 22 Aug 2022 09:09:06 +1000
Message-ID: <87r119kxd9.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kefeng Wang <wangkefeng.wang@huawei.com> writes:
> Only x86 has own release_thread(), introduce a new weak
> release_thread() function to clean empty definitions in
> other ARCHs.
>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
..
>  arch/powerpc/include/asm/processor.h    | 1 -
>  arch/powerpc/kernel/process.c           | 5 -----

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
