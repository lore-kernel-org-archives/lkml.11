Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CF4C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Mar 2022 23:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiCCAAF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Mar 2022 19:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiCCAAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 19:00:04 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C7121835
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 15:59:19 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id o6so4567582ljp.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 15:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=npju3rHc3mRSfcSts2+QJjEKDIhH7Izt6iSeFW3/QF8=;
        b=EGUemDJqLPj5B1hkkSx83siUMy1VVgYpLmLW+ISOhNuoXtHKsSw2hUGh04Nr1SSJBa
         r1zlSLuTwOVX4majvP3P2eRAehp5T6N3EhkQMRRzPZTVKm7dG9AMpyQkHmmlptVAkH1M
         9qJqcvZhIGwX2krc9gtYqqgwwQlmQpMuIj2tBVKllvQa6ewTZR3bIzSlOMcvz81A9HgK
         U6a1Rlq0X8a/j+BcebndmqCX94BKI7/Pk6tA767h9fKeB1KajrFXzeZtGEtmtGtKzQ82
         MRbBDpAmm2KjoZQU/U/PLkzR0auLS/dAQCdKPVFuvLwFIJNhxluwc4Nr3f7cAO8VDXZ4
         jz0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=npju3rHc3mRSfcSts2+QJjEKDIhH7Izt6iSeFW3/QF8=;
        b=Z3E5Oh7EggGB3lodMKOH+V0mSfQH7fXI2qCtqzPXkK1vsAd1zJiMuU8VwqmWo5z1Hv
         WIX4b2fSTXb76Xd4dEn/uMzBrlAMzfx6jhbaGlpwT+crJkfASMFfmAI3ZXVt7m+SrqDH
         cJDhd5w1dbtWNua/nvLwOSdeiGN4HV6KSZAWCjC9499dDV10e9Y8niP+JGb/vM8JjRbf
         UVpr7qRrNq0NqxKsJAs7gVNYM42ug/xl29n5OaUevXiDohvz2fI0vFWTM2zLZZ87kcDt
         7BqUIypHiUYFheod7UGBKGdndAO54ay9VTKkEnSD4JWCpWZxIxQxpyvU9TKPeG0kl8Xz
         zatQ==
X-Gm-Message-State: AOAM532wvMzk+HismwLOh1LoVBxioI6ju7pA6mhCxJePdpXDT81VAFWm
        vHkLP6PAs7vmrPOgdWCikvLFBT+g6rDz3LLoZDQUiKnPB1Nx6g==
X-Google-Smtp-Source: ABdhPJwNGg4cChj44h6sHunDdkaG9C78703PQ9UZNkp6xZHGYO9BRG6dBg6H3kef6ltm6p6P5d5rhHI0dHWUyV3MtyU=
X-Received: by 2002:ac2:46ef:0:b0:443:3c30:a372 with SMTP id
 q15-20020ac246ef000000b004433c30a372mr19890713lfo.626.1646261686698; Wed, 02
 Mar 2022 14:54:46 -0800 (PST)
MIME-Version: 1.0
References: <20220301145233.3689119-1-arnd@kernel.org> <20220301145233.3689119-3-arnd@kernel.org>
 <CA+icZUWCTuVeohWvePhxYY3WC9xAYSy9nP1xQQf=tFH_mWDCNQ@mail.gmail.com>
In-Reply-To: <CA+icZUWCTuVeohWvePhxYY3WC9xAYSy9nP1xQQf=tFH_mWDCNQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 2 Mar 2022 14:54:35 -0800
Message-ID: <CAKwvOdn04aoWO_384k5HQodwA1-DCFwU50iRXQXh_BQk5pyz7w@mail.gmail.com>
Subject: Re: [PATCH 3/3] Kbuild: use -std=gnu11 for KBUILD_USERCFLAGS
To:     sedat.dilek@gmail.com
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Jani Nikula <jani.nikula@intel.com>,
        David Sterba <dsterba@suse.com>, Alex Shi <alexs@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kbuild@vger.kernel.org, llvm@lists.linux.dev,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 2, 2022 at 2:14 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Wed, Mar 2, 2022 at 10:47 AM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > As we change the C language standard for the kernel from gnu89 to
> > gnu11, it makes sense to also update the version for user space
> > compilation.
> >
>
> Overdue.
>
> Can you point me to a lore link where I can easily fetch the full 3/3
> v3 patchset?

Hey Sedat!

$ b4 am https://lore.kernel.org/lkml/20220301145233.3689119-1-arnd@kernel.org/
-o - | git am -3

https://people.kernel.org/monsieuricon/introducing-b4-and-patch-attestation

>
> I would like to give this a try on x86-64 with my latest kernel-config
> (based on the latest kernel-config v5.17-rc5 from Debian/unstable).
>
> What Linux source base do I need?
> Is Linux v5.17-rc6 good enough (patchset applicable) for testing?

I suspect so.
-- 
Thanks,
~Nick Desaulniers
