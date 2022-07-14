Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB025C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jul 2022 21:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiGNViq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jul 2022 17:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbiGNVio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 17:38:44 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3FFAE6D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 14:38:42 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id a10so3686831ljj.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 14:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a1BPCOU0S8iLJ+DI8V3mTWw27zrRrIaENDKL+lLVRDM=;
        b=d9ptBNGjxYf6Rd//GdDmRSfzD45ifgMwjLxxyFX+i4jMZ+IJo4RTmDV+mQTB7ZvLMx
         Nq+ArH2jS1OtXHEDfSURC2xuL/ZZxfJe76eUfFZSMtiyU8ieaQ/q9Xg8qjoDVcQYsDzP
         OzJ/3aNpsn8KWiBC8c+QjuA2tQhgX0YxNq4SysqbYSpS06Lu6V/yKsLLeS4r8ugad4Fi
         SMNCdG02w6+IR5MZEmkPRNVL/RjFKGxXIITkpPGGWQiGGlpc1R8HZ+8d/vRFHn+y1Gwi
         uGkCuUFqL2nQmbqOAccecFeFibcLcAOpwhd5lEYKKaKhP9RARNQrN41u/fdATFjgcwer
         Sz/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a1BPCOU0S8iLJ+DI8V3mTWw27zrRrIaENDKL+lLVRDM=;
        b=idpIbdlknwoVPpL+VSsVHoezlmwMaNT8z0HCNTQvDiATbye8Rb5o7mcS28ko865vIN
         wcqOrVDKJJh/2UN83GS2RP30xa4VQXIMvIQn0vdf1HUfuQFwf5xQTspSsRl6coOY69/f
         z9QCuO179j4vN83hWQFXJXUQpyLlonQZsTfhLh/PXL5ZHhVOdnjJIXhL+cPpdRRZMpx8
         exe8S+p3Z9pPSbGI/sf+CjwuQVJq5eXbFKqHPyPLh1hXFZEU8hovWC/DiIhwWQLoV+RX
         NMCW1kXkLnyHRoO4/0sbE3/RHQm+xly13z3XcT4t4aEUc6tub2sSw4O9k/NzgoQx5tRu
         QpHw==
X-Gm-Message-State: AJIora+Ow6cJpNCRmRxJwDi2ZtmYRwIPhZADGRd+41utWZyh3sA07pwh
        L7XRQZi0JsNvRi5p9giiQ0FvIZlDWZH36y/6CdgrNQ==
X-Google-Smtp-Source: AGRyM1sUJ7vRhOTvHnAzFXwl5l4d1fyp3Frm959403qykkzqb9n3jgzwrKJh+jZq6vDWYIza8eWbphCxj0Vfya0OSg8=
X-Received: by 2002:a2e:3109:0:b0:25a:8a0c:40e2 with SMTP id
 x9-20020a2e3109000000b0025a8a0c40e2mr5265245ljx.26.1657834720312; Thu, 14 Jul
 2022 14:38:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220714205646.4023495-1-ndesaulniers@google.com> <CAHk-=whnndsMXO=32vFn9-Osw4r8-NvROV1rtsbxjw9Uvj1WPA@mail.gmail.com>
In-Reply-To: <CAHk-=whnndsMXO=32vFn9-Osw4r8-NvROV1rtsbxjw9Uvj1WPA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 14 Jul 2022 14:38:28 -0700
Message-ID: <CAKwvOd=PB9Kpbnf3y0e5u6LrZ=Lv2Ex8O7y=VY63D67Jf2eyHQ@mail.gmail.com>
Subject: Re: [PATCH] ubsan: disable UBSAN_DIV_ZERO for clang
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 2:25 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The way you do that is by warning, and giving it defined behavior. It
> really is that simple.

int do_div (int dividend, int divisor) {
  return dividend / divisor;
}

has UB should divisor ever be zero, not much different from:

int deref (int *foo) {
  return *foo;
}

when foo is NULL.  Should the two of those be:

int do_div (int dividend, int divisor) {
  if (!divisor)
    return -EOOPS;
  return dividend / divisor;
}
int deref (int *foo) {
  if (!foo)
    return -EOOPS;
  return *foo;
}

or keep the unchecked versions and wait for a report from a user or
bot with a sanitizer splat?

I get the sanitizer doesn't work as advertised. I _agree_ with you.
Hence this patch (which I _think_ works towards your point, shouldn't
you Ack it?).  I feel like you're talking past me without addressing
my point, let me try rephrasing it:

I _additionally_ think we should be adding more checks to guard
against division by zero to the kernel sources.  Or are we happy to
wait and find out if divisors are ever zero and fix them as they pop
up/become problematic?
-- 
Thanks,
~Nick Desaulniers
