Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC93AECAAD1
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Aug 2022 10:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbiHaK04 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Aug 2022 06:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiHaK0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 06:26:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC15BB7EDD
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 03:26:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9B4F4B81FF7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 10:26:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A33BC433D6;
        Wed, 31 Aug 2022 10:26:47 +0000 (UTC)
Date:   Wed, 31 Aug 2022 11:26:33 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Yun Levi <ppbuk5246@gmail.com>
Cc:     Baoquan He <bhe@redhat.com>, will@kernel.org,
        nramas@linux.microsoft.com, thunder.leizhen@huawei.com,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kexec@lists.infradead.org
Subject: Re: [PATCH v2-RESEND] arm64/kexec: Fix missing extra range for
 crashkres_low.
Message-ID: <Yw83WQOgQf2yICaM@arm.com>
References: <CAM7-yPTdihLsPjDKM-0OEszxNd8n0bgeRseiEkCsSZW-uuaRvw@mail.gmail.com>
 <20220830092839.3197-1-ppbuk5246@gmail.com>
 <Yw49m7Hpq+NIZYWw@arm.com>
 <CAM7-yPQjjwM_fCgojYHbrhE4GFCX22VLoCiTVkorNG6hQDj9EQ@mail.gmail.com>
 <Yw62//C+LmH+BcEh@MiWiFi-R3L-srv>
 <CAM7-yPRKC8hGSoSe34+RbCuRDdv88QsFzD=VznM2v9yu0YZMWA@mail.gmail.com>
 <CAM7-yPRp7wpP1a=SrH4o2SBijF4ZfxkLTe7vpRXq_D_y1Kz-1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM7-yPRp7wpP1a=SrH4o2SBijF4ZfxkLTe7vpRXq_D_y1Kz-1g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 10:49:30AM +0900, Yun Levi wrote:
> Like crashk_res, Calling crash_exclude_mem_range function with
> crashk_low_res area would need extra crash_mem range too.
> 
> Add one more extra cmem slot in case of crashk_low_res is used.
> 
> Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
> Fixes: 944a45abfabc ("arm64: kdump: Reimplement crashkernel=X")
> Cc: stable@vger.kernel.org

To be even more precise, it should be:

Cc: <stable@vger.kernel.org> # 5.19.x

> Acked-by: Baoquan He <bhe@redhat.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm64/kernel/machine_kexec_file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/machine_kexec_file.c
> b/arch/arm64/kernel/machine_kexec_file.c
> index 889951291cc0..a11a6e14ba89 100644
> --- a/arch/arm64/kernel/machine_kexec_file.c
> +++ b/arch/arm64/kernel/machine_kexec_file.c
> @@ -47,7 +47,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
>   u64 i;
>   phys_addr_t start, end;
> 
> - nr_ranges = 1; /* for exclusion of crashkernel region */
> + nr_ranges = 2; /* for exclusion of crashkernel region */
>   for_each_mem_range(i, &start, &end)
>   nr_ranges++;

Something happened to the whitespace here, so the patch can't be
applied.

-- 
Catalin
