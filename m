Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B6EC43334
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jun 2022 22:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234614AbiFSW7o (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jun 2022 18:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbiFSW7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 18:59:43 -0400
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14389DCB
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 15:59:41 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 25JMxQEe012632;
        Mon, 20 Jun 2022 07:59:27 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 25JMxQEe012632
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1655679567;
        bh=0124zpITfI5G6OA5F7EcRpetdGkeILk3yk8sPHGF9Lo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=J38ZvtvP8SKTq0XerFyGz3kNqQ2MTZju83AjWtBE/muJcPKWDDKUBR0GVSbZM60QV
         WGmxT+4wwnfsooUhh/oy2XsjeyaDkINOZyh+TJWej7OdZSKp5cdVnSbNOskgxDulhx
         s6JuKwoExws9JMuQ0TMAVpk0FSOa4xUJ7hNoS4C0vSXIb0w+FeuwZwCOi5yilix4G3
         zm3mCtlhEBtDfHuHrTtfDUg+j2Xz5mqU0oa0/WRv5BOu4FBrso/zZHGeVwz87HHTBF
         r5ybCn0roFKCR6uBNc7MQB83kE6jCF12PmubTWRdDLEc5bwRUawHLkjurc2djiwpqa
         qgQsM/UAU954A==
X-Nifty-SrcIP: [209.85.221.51]
Received: by mail-wr1-f51.google.com with SMTP id o8so12331543wro.3;
        Sun, 19 Jun 2022 15:59:27 -0700 (PDT)
X-Gm-Message-State: AJIora8WRwSZlE3pyi2gr9J6xwdXsHLXwGKwrKvxA3RDH2W3jwno4Z8+
        +TpaQjsRQxALYAL7eVD0B+SlhnaI6reG5InjhtU=
X-Google-Smtp-Source: AGRyM1uH2aT9R6Kjl4mUyPmKjKTrynoT6AUejYpE5i86yNrNFXv5LJCE9cT6ZYzimizFSlKXFqnO628plXelofKIHzM=
X-Received: by 2002:a05:6000:1f09:b0:21a:5f3:316a with SMTP id
 bv9-20020a0560001f0900b0021a05f3316amr20323654wrb.682.1655679566035; Sun, 19
 Jun 2022 15:59:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220416174710.269226-1-masahiroy@kernel.org> <165037936030.4207.3583631675331739342.tip-bot2@tip-bot2>
In-Reply-To: <165037936030.4207.3583631675331739342.tip-bot2@tip-bot2>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 20 Jun 2022 07:58:47 +0900
X-Gmail-Original-Message-ID: <CAK7LNATRH4sHYrZk556Sjo4nP=S3qD170OMCZ21n0TEz7gyDUw@mail.gmail.com>
Message-ID: <CAK7LNATRH4sHYrZk556Sjo4nP=S3qD170OMCZ21n0TEz7gyDUw@mail.gmail.com>
Subject: Re: [tip: x86/tdx] x86/build: remove unused OBJECT_FILES_NON_STANDARD_test_nx.o
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     linux-tip-commits@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi x86 maintainers.

On Tue, Apr 19, 2022 at 11:42 PM tip-bot2 for Masahiro Yamada
<tip-bot2@linutronix.de> wrote:
>
> The following commit has been merged into the x86/tdx branch of tip:
>
> Commit-ID:     51e8253cf5444299db09e1027160bf503ef49ec9
> Gitweb:        https://git.kernel.org/tip/51e8253cf5444299db09e1027160bf503ef49ec9
> Author:        Masahiro Yamada <masahiroy@kernel.org>
> AuthorDate:    Sun, 17 Apr 2022 02:47:10 +09:00
> Committer:     Dave Hansen <dave.hansen@linux.intel.com>
> CommitterDate: Tue, 19 Apr 2022 07:17:16 -07:00
>
> x86/build: remove unused OBJECT_FILES_NON_STANDARD_test_nx.o
>
> Commit 3ad38ceb2769 ("x86/mm: Remove CONFIG_DEBUG_NX_TEST")
> removed arch/x86/kernel/test_nx.c
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Link: https://lkml.kernel.org/r/20220416174710.269226-1-masahiroy@kernel.org



What happened to this patch?

This has not been merged into the mainline.
It does not show up in linux-next either.





> ---
>  arch/x86/kernel/Makefile | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index c41ef42..d8b2a81 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -34,8 +34,6 @@ KASAN_SANITIZE_sev.o                                  := n
>  # by several compilation units. To be safe, disable all instrumentation.
>  KCSAN_SANITIZE := n
>
> -OBJECT_FILES_NON_STANDARD_test_nx.o                    := y
> -
>  ifdef CONFIG_FRAME_POINTER
>  OBJECT_FILES_NON_STANDARD_ftrace_$(BITS).o             := y
>  endif



-- 
Best Regards
Masahiro Yamada
