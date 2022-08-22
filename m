Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED5CC28D13
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Aug 2022 21:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237005AbiHVVgd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Aug 2022 17:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbiHVVg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 17:36:29 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF02152DEC
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 14:36:28 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id bt10so4102949lfb.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 14:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=5ru0aABhHpkFT/xNIs3ZgPkQqBJ5OZsLkRi6XtgKWDc=;
        b=dcayZoNHlCo4X2lBZCOuItLTviaZ8g58d6ch9c4HiqsrmeMeUSPmuGQecK7tHnrrcU
         BGZDNtotPI8KTh71ufRsdBAJD9I0Wn/JaS/a7cuRQDPcdnZDdr/puIhkK7LQ17LqLP5m
         F7mSDEKTuFxE0vpJK7tIpCoMZbPYmyZue3712Yl2OWgNZkQLUxtOw67pP67r7PPaDnhE
         Dr5EV0ORbmC57dz2HQvVdfUabDG0a3X94rd8sabU5Gtm3YMD/R+b5qXEve4IGMY19D6n
         BGVAXE8R6X58ZONsUKzTfAJuS/dmi8A3ymiKeFW/UExxBF4ePGcUFyPDhIOVZoMoPMMc
         aMFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=5ru0aABhHpkFT/xNIs3ZgPkQqBJ5OZsLkRi6XtgKWDc=;
        b=uduW96Wc/7shm/RvuVyFrYmZ1vO6nPKFf1dmaidFrzUqsqRNKIVJbRPzGX8cCI8Wfo
         uOvfxFVK4FyJ5t84EGyd3pAWnN+Qy3mbL4/38XMoDqpt4YtJVO9OyD2fIJfBDOjBzHLx
         W961xgefZYy07KBtiH5uUCzH+pSn2ZRs4/1zYM9ZvZj43GDQvDCBHCt104J9YtadeHQd
         Asa14gPd5ixB+RXTK99vNs5BdIdD1PGAdULDEHex+zrG/2il4OF7b9esOIeIrOuUfVtA
         HUIC6yfT3LXo8NCl2eUCl0UbNOIQ2obtA+HaSBYSB8ywy/GSSkj+JR4AhCsYgGpbKVPW
         gVYQ==
X-Gm-Message-State: ACgBeo14Z8psMO2+DgksEcUXRKTT6Ayl7+HykS/ohCutl+hY6liarOs2
        yIFJ5anw0FC6Vz/XtKURNpVVotEqw+KzsExOzFnWhA==
X-Google-Smtp-Source: AA6agR4VQdfm3FFb0/UvTwdOZ1B/U6O/llTvGCtgfXsaf06xvjwNGX6p0asM/se/N286IcpWF+PmcstxsiQQmfXjyoo=
X-Received: by 2002:a05:6512:33d6:b0:492:c423:1672 with SMTP id
 d22-20020a05651233d600b00492c4231672mr7240817lfg.432.1661204186888; Mon, 22
 Aug 2022 14:36:26 -0700 (PDT)
MIME-Version: 1.0
References: <CANXV_XwgZMCGXijfoUyZ9+KyM6Rgeqiq-sCfubyj_16d-2CN=A@mail.gmail.com>
 <20220815013317.26121-1-dmitrii.bundin.a@gmail.com> <CAKwvOdnnSAozX8bQ9HeSw12BV9OjpzyDmXk_BGczjVVQNN+7tQ@mail.gmail.com>
 <CANXV_Xw2wzwDdJkyV1nHPQm2JTt48SLrNc7YwrfcxOwuFA-z3w@mail.gmail.com> <CAKwvOdkiq_byi1QeCvSGb2fd+0AJ1k9WNnsHJMeaaQcPRy1Wxg@mail.gmail.com>
In-Reply-To: <CAKwvOdkiq_byi1QeCvSGb2fd+0AJ1k9WNnsHJMeaaQcPRy1Wxg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 22 Aug 2022 14:36:14 -0700
Message-ID: <CAKwvOdkPwbD-c0V-up2Ufzb-Uh7LLyD12X0FKeBa=hn+cSPA9Q@mail.gmail.com>
Subject: Re: [PATCH v3] kbuild: add debug level and macro defs options
To:     Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Eric Dumazet <edumazet@google.com>,
        Isabella Basso <isabbasso@riseup.net>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Fangrui Song <maskray@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 9:45 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> > So it seems like a reasonable choice to provide a debug info
> > level config that would explicitly set the level without relying on
> > implicits. The default value of the config is set to -g2 to not change
> > the build behavior that was before introducing the option. And it
> > works for both older and newer versions of GCC/Clang in the same way.
> > The benefits of the -g1 option are indeed questionable except that it
> > produces an image with ~20% less in size.
>
> Until there's a concrete need, YAGNI.

Or add -g1 to CONFIG_DEBUG_INFO_REDUCED.
-- 
Thanks,
~Nick Desaulniers
