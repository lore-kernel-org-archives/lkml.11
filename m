Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F8DCCA47C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jul 2022 21:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240821AbiGNVwR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jul 2022 17:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240744AbiGNVwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 17:52:13 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7551A6F7F1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 14:52:11 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id ez10so5732793ejc.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 14:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gCwGv/e/gf0C6iderKEIRJdi0X+OWhvleA0ffjecAUA=;
        b=dxV59InvESm2MJqKBf3+U1Ds3/hawDeEnGZ38sSmB5Il756bzpwxIre3Atc0Q1lkzC
         hyBFGJ3TV2g0q8oktcCZOMFI8cRxHm73bG0bhfMCqzN/UjJnIR7jKT4a9XBskQw9dd6h
         OqDy+jIwcgGlmmWZTsqokmdOnUKSxRvScSSq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gCwGv/e/gf0C6iderKEIRJdi0X+OWhvleA0ffjecAUA=;
        b=jWPQWrB6zkqk+e89aHjI9aqsxNGb6WJZog5oQELfqxHf7SaQZOOZIHLikQivbYJqRp
         tQAwyRW0PqrwQgVpgg7RP6JflPsVtEZsvpavbRkZTmVYIBPotxJNkrzluK+wps34/JOD
         pXc2bOszyE9KSCA2v+5RepqYjw7VnUIGD+iMpY/HBB3tyw7IAgiFTM9uj2lEd1uZdFUV
         PbwuUSYUkHt8A+kvcJTvHighiSsXypluaJcTKz/gquPPcQNEBaxzVbqc6bVxHjGmUEfl
         9MRvrvCDoG6VI1EP0O2PoRMV3ozNFWIpyoC9vU+eSvgj/wXppkl0awF2wong3KWB8AQz
         tZ4w==
X-Gm-Message-State: AJIora8Sz2JhhellAaUasa7VhnM7qT9Kdqm6wCOFx+6iTsK+hniBWoWS
        NV0Mi4R9MX2+YTSHAFyILVRmaEBdhmwCJ/IzHy0=
X-Google-Smtp-Source: AGRyM1vQCFbeqRg/1DwUpadXOB1RnmKiQq6mVVNq2ZDZvVZh2wNj0AdTptB4ZBCso+DwkFvksOLZqg==
X-Received: by 2002:a17:907:16ab:b0:72c:7533:7262 with SMTP id hc43-20020a17090716ab00b0072c75337262mr8985908ejc.288.1657835529863;
        Thu, 14 Jul 2022 14:52:09 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id lo25-20020a170906fa1900b006ff802baf5dsm1187411ejb.54.2022.07.14.14.52.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 14:52:09 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id v14so4307855wra.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 14:52:08 -0700 (PDT)
X-Received: by 2002:a5d:544b:0:b0:21d:70cb:b4a2 with SMTP id
 w11-20020a5d544b000000b0021d70cbb4a2mr9822619wrv.281.1657835528671; Thu, 14
 Jul 2022 14:52:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220713152436.2294819-1-nathan@kernel.org> <20220714143005.73c71cf8@kernel.org>
In-Reply-To: <20220714143005.73c71cf8@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 14 Jul 2022 14:51:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi+O_3+uef45jxj1+GhT+H0vXs9iz8rpjk49vCiyLS4DA@mail.gmail.com>
Message-ID: <CAHk-=wi+O_3+uef45jxj1+GhT+H0vXs9iz8rpjk49vCiyLS4DA@mail.gmail.com>
Subject: Re: [PATCH v2] x86/speculation: Use DECLARE_PER_CPU for x86_spec_ctrl_current
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        stable <stable@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 2:30 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> Hi, sorry to bother, any idea on the ETA for this fix getting into
> Linus's tree? I'm trying to figure out if we should wait with
> forwarding the networking trees or this will take a while.

Well, I have that patch by now in my own clang tree, but was holding
it off just because I was expecting a few other fixes for the fallout.

But if this particular one causes problems for maintainers, I can
easily just take it right away just cherry-pick it from my own
test-tree to my "main" tree.

            Linus
