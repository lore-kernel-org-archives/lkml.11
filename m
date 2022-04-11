Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49316C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Apr 2022 08:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344003AbiDKJB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Apr 2022 05:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344002AbiDKJB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:01:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B7A286F4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 01:59:41 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1BD5021115;
        Mon, 11 Apr 2022 08:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649667580; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yym+/I6u//ozhc2zOZPC1O+yPiCJTgPKVNmp6jtW5XY=;
        b=XxWqmXVMraBVrm9/9a1ObsoomHNnSINj7CKniUwKgeFDA1Ny3GoEJhT/SR6YL+gwfu024u
        UR6sgIXRP8cDKWwDpnapwLi7uE9hDkA+zaPwmduotvvQ0bRY13+F7v1SJi50b3p9gwIaN5
        vlQeb23apbsb6/Jt3Rn82MLrM8UzPuU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649667580;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yym+/I6u//ozhc2zOZPC1O+yPiCJTgPKVNmp6jtW5XY=;
        b=q0Aiicajw/Tq2Jsh9GpLgprlXwhdtBRHnxgF+HBV0gAmHZlk4cHsL/LLaGCS2fPUbUMiWL
        7JkE32i5MKWSWqBA==
Received: from kunlun.suse.cz (unknown [10.100.128.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DEB9DA3B94;
        Mon, 11 Apr 2022 08:59:39 +0000 (UTC)
Date:   Mon, 11 Apr 2022 10:59:38 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Coiby Xu <coxu@redhat.com>
Cc:     kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 3/3] arm64: kexec_file: use more system keyrings to
 verify kernel image signature
Message-ID: <20220411085938.GA163591@kunlun.suse.cz>
References: <20220401013118.348084-1-coxu@redhat.com>
 <20220401013118.348084-4-coxu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401013118.348084-4-coxu@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2022 at 09:31:18AM +0800, Coiby Xu wrote:
> Currently, a problem faced by arm64 is if a kernel image is signed by a
> MOK key, loading it via the kexec_file_load() system call would be
> rejected with the error "Lockdown: kexec: kexec of unsigned images is
> restricted; see man kernel_lockdown.7".

This is because image_verify_sig uses only the primary keyring that
contains only kernel built-in keys to verify the kexec image.

> This patch allows to verify arm64 kernel image signature using not only
> .builtin_trusted_keys but also .platform and .secondary_trusted_key
> keyring.
> 
> Acked-by: Will Deacon <will@kernel.org>
> Signed-off-by: Coiby Xu <coxu@redhat.com>
> ---
>  arch/arm64/kernel/kexec_image.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
> index 9ec34690e255..51af1c22d6da 100644
> --- a/arch/arm64/kernel/kexec_image.c
> +++ b/arch/arm64/kernel/kexec_image.c
> @@ -14,7 +14,6 @@
>  #include <linux/kexec.h>
>  #include <linux/pe.h>
>  #include <linux/string.h>
> -#include <linux/verification.h>
>  #include <asm/byteorder.h>
>  #include <asm/cpufeature.h>
>  #include <asm/image.h>
> @@ -133,8 +132,7 @@ static void *image_load(struct kimage *image,
>  #ifdef CONFIG_KEXEC_IMAGE_VERIFY_SIG
>  static int image_verify_sig(const char *kernel, unsigned long kernel_len)
>  {
> -	return verify_pefile_signature(kernel, kernel_len, NULL,
> -				       VERIFYING_KEXEC_PE_SIGNATURE);
> +	return kexec_kernel_verify_pe_sig(kernel, kernel_len);
>  }
>  #endif

You can eliminate image_verify_sig here aswell and directly assign
kexec_kernel_verify_pe_sig to fops.

Thanks

Michal
