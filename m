Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73619C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 13:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbiDFNdQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Apr 2022 09:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiDFNcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:32:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8748A6799A4
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 03:31:49 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C97C23A;
        Wed,  6 Apr 2022 03:22:13 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.10.98])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A93D3F718;
        Wed,  6 Apr 2022 03:22:10 -0700 (PDT)
Date:   Wed, 6 Apr 2022 11:22:07 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Tong Tiangen <tongtiangen@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [RFC PATCH -next V2 2/7] arm64: fix page_address return value in
 copy_highpage
Message-ID: <Yk1pz7IYwEyGDVNV@FVFF77S0Q05N>
References: <20220406091311.3354723-1-tongtiangen@huawei.com>
 <20220406091311.3354723-3-tongtiangen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406091311.3354723-3-tongtiangen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 09:13:06AM +0000, Tong Tiangen wrote:
> Function page_address return void, fix it.
> 
> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>

This looks like a sensible cleanup, but the commit title and message aren't
that clear.

Can you please make this:

| arm64: fix types in copy_highpage()
|
| In copy_highpage() the `kto` and `kfrom` local variables are pointers to
| struct page, but these are used to hold arbitrary pointers to kernel memory.
| Each call to page_address() returns a void pointer to memory associated with
| the relevant page, and copy_page() expects void pointers to this memory.
|
| This inconsistency was introduced in commit:
|
|   2563776b41c31908 ("arm64: mte: Tags-aware copy_{user_,}highpage() implementations")
|
| ... and while this doesn't appear to be harmful in practice it is clearly wrong.
|
| Correct this by making `kto` and `kfrom` void pointers.
|
| Fixes: 2563776b41c31908 ("arm64: mte: Tags-aware copy_{user_,}highpage() implementations")

With that:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> ---
>  arch/arm64/mm/copypage.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/mm/copypage.c b/arch/arm64/mm/copypage.c
> index b5447e53cd73..0dea80bf6de4 100644
> --- a/arch/arm64/mm/copypage.c
> +++ b/arch/arm64/mm/copypage.c
> @@ -16,8 +16,8 @@
>  
>  void copy_highpage(struct page *to, struct page *from)
>  {
> -	struct page *kto = page_address(to);
> -	struct page *kfrom = page_address(from);
> +	void *kto = page_address(to);
> +	void *kfrom = page_address(from);
>  
>  	copy_page(kto, kfrom);
>  
> -- 
> 2.18.0.huawei.25
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
