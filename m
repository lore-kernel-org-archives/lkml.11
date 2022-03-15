Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B859DC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Mar 2022 16:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350288AbiCOQzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Mar 2022 12:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350282AbiCOQzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 12:55:13 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E404E37ABF
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 09:54:00 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id bn33so27339182ljb.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 09:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7w9l4K+vQSjlWhwnZW0PPcugEDNn1dSWiRZByr+CSKU=;
        b=QAV4mcQih963HLU1bA4pOimN2PrfqeizNgGTbtny64oUxGR4PaKLiXNb2hU38KQQeV
         uD1BWtxM/FROQJIkCF4vaEMfX/gDey6nC99+s3I2uinPXsMuIFZY7WAi/2WycG9lQ/OY
         +CuEdBPGpcv/BJegkz7QLBqTzNbUsop2p1KMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7w9l4K+vQSjlWhwnZW0PPcugEDNn1dSWiRZByr+CSKU=;
        b=jAui364Np82lL8BjZ7AAdGpFfc6Yy5T6ttNVJN5VWeceP4ZjioBwLCV4FUoGcL9mTD
         I4iPLmcS/BpqS1EGOfYayeudzvpavqbH5kN4mBKmSGWB7ckJ/uOlbkCjl/MJfCQWI6lX
         Elc0fc6B1I3c+cN0ekKJnF6800trMmd/Sp6c8BVBYRYDyhmlK8HK4ye/G2NLpweFLnfC
         4iWhnhBxgUFsVoxtzWwAJDz6YepPDXHIJU0RltGJg9kJyHOIK1Rrtqm/64ZMhBe7wzTI
         HOcQF6MYslG4+qYP1O7WP89E2xuJ1TWdbgaWjeVYkJhd4Er/XzLneYvJgUx2atspnoo9
         AeiQ==
X-Gm-Message-State: AOAM53245wRlPecu7xl3GP6ovOaSF8Wbv4/BD/QLjwSYBeJnSD7MvhyU
        4Gaka1U0T2XYREyjoWMu4KxDcwCYynQ8dmTD
X-Google-Smtp-Source: ABdhPJzUVqAvk9zdzGLSqN8r/3sg9jfdbVmLWvSwsQit8eH0VE9EqIfoa1cSDQ0Wrqq/qr8+wjTBWA==
X-Received: by 2002:a2e:a804:0:b0:249:1ad3:fdf3 with SMTP id l4-20020a2ea804000000b002491ad3fdf3mr14374777ljq.61.1647363238326;
        Tue, 15 Mar 2022 09:53:58 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id q15-20020a19f20f000000b0044376b4e80bsm3692883lfh.279.2022.03.15.09.53.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 09:53:56 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id bu29so34218048lfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 09:53:55 -0700 (PDT)
X-Received: by 2002:a05:6512:2037:b0:448:92de:21de with SMTP id
 s23-20020a056512203700b0044892de21demr6965471lfs.52.1647363235312; Tue, 15
 Mar 2022 09:53:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220315165205.1502325-1-brgl@bgdev.pl>
In-Reply-To: <20220315165205.1502325-1-brgl@bgdev.pl>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Mar 2022 09:53:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiN3gqjC_rDQ=b0W=XpC8oSsvLhT2O+MnGr1FWEVGMGVw@mail.gmail.com>
Message-ID: <CAHk-=wiN3gqjC_rDQ=b0W=XpC8oSsvLhT2O+MnGr1FWEVGMGVw@mail.gmail.com>
Subject: Re: [PATCH] Revert "gpio: Revert regression in sysfs-gpio (gpiolib.c)"
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marcelo Roberto Jimenez <marcelo.jimenez@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Thierry Reding <treding@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 9:52 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> This commit - while attempting to fix a regression - has caused a number
> of other problems. As the fallout from it is more significant than the
> initial problem itself, revert it for now before we find a correct
> solution.

I'll add the links and the cc's to this and apply it.

                Linus
