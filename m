Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28808C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Mar 2022 08:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbiCGIoj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Mar 2022 03:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiCGIog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 03:44:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6473533E0F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 00:43:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EBB88B81017
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 08:43:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F73C340F3;
        Mon,  7 Mar 2022 08:43:37 +0000 (UTC)
Date:   Mon, 7 Mar 2022 08:43:34 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Rongwei Wang <rongwei.wang@linux.alibaba.com>
Cc:     will@kernel.org, maz@kernel.org, joey.gouly@arm.com,
        mark.rutland@arm.com, akpm@linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] arm64: improve display about CPU architecture in
 cpuinfo
Message-ID: <YiXFtrK9O917eHQk@arm.com>
References: <20220307030417.22974-1-rongwei.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307030417.22974-1-rongwei.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 11:04:17AM +0800, Rongwei Wang wrote:
> Now, it is unsuitable for both ARMv8 and ARMv9 to show a
> fixed string "CPU architecture: 8" in /proc/cpuinfo.
> 
> Signed-off-by: Rongwei Wang <rongwei.wang@linux.alibaba.com>
> ---
>  arch/arm64/kernel/cpuinfo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
> index 330b92e..6d9b7e8 100644
> --- a/arch/arm64/kernel/cpuinfo.c
> +++ b/arch/arm64/kernel/cpuinfo.c
> @@ -195,7 +195,7 @@ static int c_show(struct seq_file *m, void *v)
>  
>  		seq_printf(m, "CPU implementer\t: 0x%02x\n",
>  			   MIDR_IMPLEMENTOR(midr));
> -		seq_printf(m, "CPU architecture: 8\n");
> +		seq_printf(m, "CPU architecture: aarch64\n");

In hindsight, 'aarch64' would have made more sense since 8/9/10 whatever
are just marketing. That said, we should not apply this patch as it has
potential ABI implications.

-- 
Catalin
