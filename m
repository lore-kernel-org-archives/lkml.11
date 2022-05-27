Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E7CC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 27 May 2022 23:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355152AbiE0XlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 May 2022 19:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352495AbiE0XlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 19:41:18 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21522F6
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 16:41:15 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id v26so10327901ybd.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 16:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i6fxNe1Yr6PM7bPFKoIRTPqlhmZN8j/BfeWdZm7S+GE=;
        b=kh+ddXudedr/FfFvhJB31s60mRvJ61namZkEwazfz5hKURIbMiIzy59PZfFNwztdbo
         EuA/8/g2Shr45xriJg7oTsLTLYol/pLhi6xS3K45Uwp/CPioC9tIHhBUMrOyN+cmRHAH
         4louErDjJjimWMfZiJTYRLUZCH86PxlLRpYaaTln4aUHrNM1/dCz1C0ERRQf4MEFxvay
         +3vZmR8YG5zewoq7jQKqY/jdprEpklh8LIdX9/B7mmyT+/SgFPrUIqpzU2Hix5xAWJHw
         H4ePD6ixeJJApDOVfWgW2mw0r/coqR1QswjYnLY0bJGcyi3+cZunR8QzaELqxi/8c1C0
         8FWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i6fxNe1Yr6PM7bPFKoIRTPqlhmZN8j/BfeWdZm7S+GE=;
        b=fiNtpoNS81SISetB8WV0nARIVrHR9uzPYBZM81W0xglMqCdI2mvTwXYuoT06PC1nMb
         J+ui7/pgIrkQJVhExgHkmah8MYmHZsqjQRlwywe/WIvVlUW9vo2PkknYdbrSyRiKK6Yx
         6lTe8mUOxP750Z84C4MLdSWtWlCZM78ipMkVWK7HpTMuHEUzFSlkOx01H1tqlj9dodAL
         rrdN9QIVeNwqanWOX4AvQ6ap0VqCEIJLHSaVe7wiyQFbPQ0z9AxcEZtV0k0RyFsdL83H
         O4wnrHRtZmbzO9HT6MOvYuiXDNPoWwHddrpZ17kME2ORQQ5WDsSpAY4PS1gSIhQsIQRd
         8UNg==
X-Gm-Message-State: AOAM532BEV5e2Yy0cN2+aAhwuih7pSIvdaLVVNtsKIMYA5GluBMbIX4v
        miyvIDvZcaQhYtRS8NJsgpcfgCJGECriMKFB2ZM=
X-Google-Smtp-Source: ABdhPJxXE8RcGKITbfw6RqG9GXDU78NhnsekVk7tM1yeTVB7yk+R8s15LGau3IhaA6ubVznIFuJUNbFyDrBtslEK9qc=
X-Received: by 2002:a25:bccb:0:b0:655:879e:e1b2 with SMTP id
 l11-20020a25bccb000000b00655879ee1b2mr15636924ybm.364.1653694875094; Fri, 27
 May 2022 16:41:15 -0700 (PDT)
MIME-Version: 1.0
References: <YpCUzStDnSgQLNFN@debian> <CAHk-=wg0uGAX5DYZq+tY2KeUAR8DtR91YE1y9CkPMKkKOyE4jg@mail.gmail.com>
In-Reply-To: <CAHk-=wg0uGAX5DYZq+tY2KeUAR8DtR91YE1y9CkPMKkKOyE4jg@mail.gmail.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Sat, 28 May 2022 00:40:38 +0100
Message-ID: <CADVatmNGPbSdRNQuwJEWAaPtqb3vBYRjvsuBpoRUnhEHj=X5GQ@mail.gmail.com>
Subject: Re: mainline build failure due to f1e4c916f97f ("drm/edid: add EDID
 block count and size helpers")
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jani Nikula <jani.nikula@intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 7:56 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, May 27, 2022 at 2:07 AM Sudip Mukherjee
> <sudipm.mukherjee@gmail.com> wrote:
> >
> >         declared with attribute error: BUILD_BUG_ON failed: sizeof(*edid) != EDID_LENGTH
> >
> > And, reverting it on top of mainline branch has fixed the build failure.
>
> Hmm. That BUILD_BUG_ON() looks entirely correct, and if that sizeof()
> doesn't work, then the code doesn't work.

<snip>

>
> Very strange. It would be interesting to know where that sizeof goes
> wrong, but it would seem to be something very peculiar to your build
> environment (either that config, or your compiler).

I just tested with various values, sizeof(*edid) is 144 bytes at that place.

My last good build was with fdaf9a5840ac ("Merge tag 'folio-5.19' of
git://git.infradead.org/users/willy/pagecache")
And my setup has not changed in anyway since then. Also verified the
build failure on my laptop.


-- 
Regards
Sudip
