Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66625C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Mar 2022 11:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbiCILks (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Mar 2022 06:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbiCILkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 06:40:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC39B4F9F7
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 03:39:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 71F2EB820D3
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 11:39:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE7EC340EE;
        Wed,  9 Mar 2022 11:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646825985;
        bh=y+Yvby6w+Zo1s8NYWaTnpXLpJ6Yz9I8OUipgiWT0tUs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jOAuXxxA1e0H43RkgOyslCw3dlJL/XhNsymsXkccM2bBPmVjoJE3yDMuEfHa1s6tF
         iMEHM392ww/wC6o8c7ZNVZJcEwXgOZdDXpFn/Kiq8aKTJWO5B+vbmSZZnd62xS5nVF
         Mx7WPXr1Ge6ds+PsFZyipx55aH648ibG6NR1nU5GyplOAag+tucZF4DMGsn+X/8X/M
         OQFwvXZk2ZsWNp3etNgIGdKMQ2R8b/psuVlehp44hDxnhoNrPA6w42MSliKG63xTSe
         q+6h3WmrwxjPrqlVfXfYDfcAcb4plcZnnyWnLsF3McAML7WhCY+Vg/wZex/lzMrEuY
         4opuk63GWUsgA==
Date:   Wed, 9 Mar 2022 11:39:35 +0000
From:   Will Deacon <will@kernel.org>
To:     Paul Semel <semelpaul@gmail.com>
Cc:     linux-kernel@vger.kernel.org, andreyknvl@google.com,
        vincenzo.frascino@arm.com, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, paul.semel@datadoghq.com
Subject: Re: [PATCH] arm64: kasan: fix include error in MTE functions
Message-ID: <20220309113935.GA352@willie-the-truck>
References: <bacb5387-2992-97e4-0c48-1ed925905bee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bacb5387-2992-97e4-0c48-1ed925905bee@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 10:30:58AM +0100, Paul Semel wrote:
> Fix `error: expected string literal in 'asm'`.
> This happens when compiling an ebpf object file that includes
> `net/net_namespace.h` from linux kernel headers.
> 
> Include trace:
>     include/net/net_namespace.h:10
>     include/linux/workqueue.h:9
>     include/linux/timer.h:8
>     include/linux/debugobjects.h:6
>     include/linux/spinlock.h:90
>     include/linux/workqueue.h:9
>     arch/arm64/include/asm/spinlock.h:9
>     arch/arm64/include/generated/asm/qrwlock.h:1
>     include/asm-generic/qrwlock.h:14
>     arch/arm64/include/asm/processor.h:33
>     arch/arm64/include/asm/kasan.h:9
>     arch/arm64/include/asm/mte-kasan.h:45
>     arch/arm64/include/asm/mte-def.h:14

Do you know where this issue was introduced? I can't tell whether this patch
is a fix for 5.17, or something needed only for 5.18 (and if so, which tree
introduced the problem).

Thanks,

Will
