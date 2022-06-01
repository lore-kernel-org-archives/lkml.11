Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90AD7C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jun 2022 16:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356159AbiFAQkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jun 2022 12:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242316AbiFAQkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 12:40:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43E86FD03;
        Wed,  1 Jun 2022 09:40:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61273B81747;
        Wed,  1 Jun 2022 16:40:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E35C385A5;
        Wed,  1 Jun 2022 16:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654101610;
        bh=ngWabIAgFRbmBczx0Ejy4RsHzpCNzNviJplGolvHT0c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HnAjj9VXETvo30txPzcJ4+0j/fYt5VhwG+7ZqNtCyTOYs96QDdelxNJfI0hEljfEv
         R2hFfUZnSF/qTCxuK8IAH1R4Y2ou8npXxQFY5GAsHBiSmy0YfPsXql4WiShxYczI+a
         kAC7BDnKZorjSdiOQBTMPFTJpe5FFTabQ9uezl3fLHa09bbVSD7VQcPyektYArxfde
         gdd4rbP9IjHRaKdMSa2/xnpndYIIuwBLbVK6dhei9pL+F71VBEkihqEe4b376deyvC
         nK6lb4m4/2MuCob1V2JbpNvaSkMEmx3kZrKmp41zj54c8GhlwnEs9rQdEgrH+/H/aK
         K68jEw3Q9QJ7g==
Date:   Wed, 1 Jun 2022 09:40:06 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Reference to non-existing config X86_SMAP in config
 UBSAN_UNREACHABLE
Message-ID: <20220601164006.2f34nr6a7wgx25ja@treble>
References: <CAKXUXMwyf5jbfKCh0k+G=begmqXQo-q-qGfAVmecoKUiSnOYWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKXUXMwyf5jbfKCh0k+G=begmqXQo-q-qGfAVmecoKUiSnOYWA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2022 at 12:50:47PM +0200, Lukas Bulwahn wrote:
> Dear Josh,
> 
> Commit dbae0a934f09 ("x86/cpu: Remove CONFIG_X86_SMAP and "nosmap"")
> from Borislav removes the config X86_SMAP and makes smap on x86
> default.
> 
> Josh, your commit 03f16cd020eb ("objtool: Add CONFIG_OBJTOOL") makes
> config UBSAN_UNREACHABLE in lib/Kconfig.ubsan refer to this
> non-existing config X86_SMAP.
> 
> See this hunk in lib/Kconfig.ubsan:
> 
> diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
> index f3c57ed51838..c4fe15d38b60 100644
> --- a/lib/Kconfig.ubsan
> +++ b/lib/Kconfig.ubsan
> @@ -94,7 +94,7 @@ config UBSAN_UNREACHABLE
>         bool "Perform checking for unreachable code"
>         # objtool already handles unreachable checking and gets angry about
>         # seeing UBSan instrumentation located in unreachable places.
> -       depends on !STACK_VALIDATION
> +       depends on !(OBJTOOL && (STACK_VALIDATION || UNWINDER_ORC || X86_SMAP))
>         depends on $(cc-option,-fsanitize=unreachable)
>         help
>           This option enables -fsanitize=unreachable which checks for control
> 
> I think X86_SMAP can just be dropped in this line, but I leave it up
> to you to change, as I am not completely certain on the needed change
> and if that just breaks the config dependencies for stack validation.
> 
> By the way, this issue was identified with the script
> ./scripts/checkkconfigsymbols.py

Hi Lukas,

Thanks for reporting this.  I'll post a fix shortly.

-- 
Josh
