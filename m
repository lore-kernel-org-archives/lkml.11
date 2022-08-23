Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5A0C32772
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 19:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbiHWTMh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 15:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbiHWTL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:11:56 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A11F11F76C
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 10:49:48 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id gb36so28885222ejc.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 10:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=L5vDksmX6kl63axC8fTX4W4UjA4ULlvaj4B5Lk9Uogw=;
        b=L+f8XLyA+qC3dl1BiCC63A2xsLWVaxkUCI8S39DAVQxI//2aOX6pcoVv2ZPow3f3tC
         cK4lPzuqIIdDHFHXKyO2KRbploN722Rcfnxi0O2cYIf2lTkK9Fw2w0sZDrK1Ee8IxrD+
         yU8xkJbWfAL0qZkeN4oSBiGVPBJpQQw9qv15o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=L5vDksmX6kl63axC8fTX4W4UjA4ULlvaj4B5Lk9Uogw=;
        b=Ho2dHF2fJULG83q8x5cUjP4Rv/wBLnK6pZYedWYy/mYiLxcgGFy1Vx5xdA+cW7u8MI
         U4AdRjdBR9KsIvKcb9OHCTjCBE8Rs1EwyN4Gd2qEuMfxVDtfMIUC45ehrOT1vKzgOOed
         GPZgrQ766ZrmaItenCg+ita4zSPAFkyIYtbaaDwLKv0g4DsCDERzjmZwTfSEpk3JbXJ5
         qzbxZwRReOSV3s6sToxVdkJBKNGkeNMQtOFbaUS5m2ZYkYZUrO5LBe1aCCauXJw/yO8x
         zJaM6AOF5pVOdY+uk+2P59IcMHOSTkyqUBGUyqgaQnANaYAIFDEXUd3tm9IujEJNtggu
         72Eg==
X-Gm-Message-State: ACgBeo1uhmrRrxHMvG1CLL8BDyvDkmTgwgwNRSk/SkWHTLWZWEoaOUq7
        su1XR3bvTbRxN79gfUdkxr3p5Mpjj0GZ5ycUe0g=
X-Google-Smtp-Source: AA6agR66jamEWZ+iX5s/Dw1SmmtBzgnAEUrEKoaF1rPj+ZDlc73iA9cClwcHGXBYN8gAkRUQFCfhoQ==
X-Received: by 2002:a05:6402:350e:b0:447:3ca9:1162 with SMTP id b14-20020a056402350e00b004473ca91162mr1509511edd.170.1661276276087;
        Tue, 23 Aug 2022 10:37:56 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id 10-20020a170906218a00b00731747c3107sm144394eju.73.2022.08.23.10.37.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 10:37:55 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id h1so7560040wmd.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 10:37:55 -0700 (PDT)
X-Received: by 2002:a05:600c:3556:b0:3a6:220e:6242 with SMTP id
 i22-20020a05600c355600b003a6220e6242mr2799346wmq.145.1661276274837; Tue, 23
 Aug 2022 10:37:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5mtDFpaAWeGCtrfm_WPM6j-Gkt_O80=nKfp6y39aXaBr6w@mail.gmail.com>
 <CAHk-=wi+xbVq++uqW9YgWpHjyBHNB8a-xad+Xp23-B+eodLCEA@mail.gmail.com> <YwSWLH4Wp6yDMeKf@arm.com>
In-Reply-To: <YwSWLH4Wp6yDMeKf@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 23 Aug 2022 10:37:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=whU7QiwWeO81Rf+KGh0rGS9CEfKUXc5eik+Z0GaVJgu4A@mail.gmail.com>
Message-ID: <CAHk-=whU7QiwWeO81Rf+KGh0rGS9CEfKUXc5eik+Z0GaVJgu4A@mail.gmail.com>
Subject: Re: strlcpy() notes (was Re: [GIT PULL] smb3 client fixes)
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 1:56 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> With load_unaligned_zeropad(), the arm64 implementation disables tag
> checking temporarily. We could do the same with read_word_at_a_time()
> (there is a kasan_check_read() in this function but it wrongly uses a
> size of 1).

The "size of 1" is not wrong, it's intentional, exactly because people
do things like

    strscpy(dst, "string", sizeof(dst));

which is a bit unfortunate, but very understandable and intended to
work. So that thing may over-read the string by up to a word. And
KASAN ends up being unhappy.

            Linus
