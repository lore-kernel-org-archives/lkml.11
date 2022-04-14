Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EC2C35294
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 15:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351642AbiDNPkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 11:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245520AbiDNOh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 10:37:28 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5996FBE38
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 07:30:27 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id b24so6565287edu.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 07:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yqVUnyTrdGzzp4ZTHGXM3CWg4LdrPaGzwtzosxnpYJw=;
        b=Xc/aUrg0ahKT8QbRWirSVbjz0aoFXK8HjWAVfiKS3ehuJN7Yl+bYVpxE9rxVTsgxZc
         jXNR1bI26IdYB1CJDYMpbldCSRFYh3mUSsxr2mn5UmcikLAlCg8Ir5jCmOOxQK/eVFhB
         AUeOutri3ibGpOx9u3ma0yTAHBxrN/OsByrBSbHKJvSY6hbjeP5Fz8WSf9UJC08hU9gb
         9WnR3LU5QMyEmAGfudYwKnET7JCVFr9ZN08H5cIjgO1GdBMHi2fPCYRHBYrzTCGTNcAF
         PRD6ilkJqi53BqJgrhVv112WiIcJCCh5SCfrjQc+UwJj23zXt2cleIHwz7AkLoeRnteF
         nJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yqVUnyTrdGzzp4ZTHGXM3CWg4LdrPaGzwtzosxnpYJw=;
        b=ptpV8ed9ZmEfznkZcQ1/YpB0NwBgjiZIt+Vy8VVNHZ/+31gQFcyxHXoz/YSbEyNSIu
         3Gbyev0hGgC/3dZgnBne9WLL4Biwdc/BTkdiYvQB5F7ZLoNLIJljlKB3z7pneKgAUYYY
         cCUNfvuALsYEl8wnMpwgVV2TfqQ4feBb11q7V8eE0IWzzm7esbOeWZsF+F8uXE4l3z/k
         H/D5lMtKXUhP4uMlxcHSTc6migDmW0qTIZoNi7mp8z4OSU4fJGk+5jguFesFiIOvsNOx
         VWNsLt10uvrtTfcGA6k77VtjHnn261iKB+2inl9zNutKklXFT1AF2fYA6WtVrRDZ9Ay5
         IsPw==
X-Gm-Message-State: AOAM533KH9M6AOWaq32uFrv9CjTVmxb4IUFhLENuwi0X80eag9emLcgU
        ws2/FT+rZeOcSYhoKv2ixbOXhcGVvcFli7UXFwHVYHhv
X-Google-Smtp-Source: ABdhPJyg+8Mm6cCLmoGGWAe6/JOhiSWlO4bPWeBmmJ5IUGYdhM3IEnc8QY6wZ8OhdbgdYFJaOMu+DnCCR2SW7nUVQFU=
X-Received: by 2002:a05:6402:270b:b0:419:3383:7a9f with SMTP id
 y11-20020a056402270b00b0041933837a9fmr3316555edd.191.1649946625790; Thu, 14
 Apr 2022 07:30:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220331070115.29421-1-bjorn.ardo@axis.com>
In-Reply-To: <20220331070115.29421-1-bjorn.ardo@axis.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Thu, 14 Apr 2022 09:30:14 -0500
Message-ID: <CABb+yY1zrHYLBjY_EoC7bkTsWcKOhzCjp-5vgvqP0HEAJicdXQ@mail.gmail.com>
Subject: Re: [PATCH] mailbox: forward the hrtimer if not queued and under a lock
To:     =?UTF-8?B?QmrDtnJuIEFyZMO2?= <bjorn.ardo@axis.com>
Cc:     kernel@axis.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 2:01 AM Bj=C3=B6rn Ard=C3=B6 <bjorn.ardo@axis.com> =
wrote:
>
> This reverts commit c7dacf5b0f32957b24ef29df1207dc2cd8307743,
> "mailbox: avoid timer start from callback"
>
> The previous commit was reverted since it lead to a race that
> caused the hrtimer to not be started at all. The check for
> hrtimer_active() in msg_submit() will return true if the
> callback function txdone_hrtimer() is currently running. This
> function could return HRTIMER_NORESTART and then the timer
> will not be restarted, and also msg_submit() will not start
> the timer. This will lead to a message actually being submitted
> but no timer will start to check for its compleation.
>
> The original fix that added checking hrtimer_active() was added to
> avoid a warning with hrtimer_forward. Looking in the kernel
> another solution to avoid this warning is to check hrtimer_is_queued()
> before calling hrtimer_forward_now() instead. This however requires a
> lock so the timer is not started by msg_submit() inbetween this check
> and the hrtimer_forward() call.
>
This is a very dense api used by many use-cases, I am not confident
making any changes without confirming its a real issue with the common
code. Please share your client code and traces, that will help me get
a clearer picture.

Thanks.
