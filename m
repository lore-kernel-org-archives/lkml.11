Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4247C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jun 2022 16:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240689AbiFJQF1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jun 2022 12:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiFJQFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 12:05:24 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64693A18E;
        Fri, 10 Jun 2022 09:05:22 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id v25so35906693eda.6;
        Fri, 10 Jun 2022 09:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ao1eOwSGGwBUHC7oBTB1HifA2RMb8BiLa95e46gEZ7k=;
        b=Ua5Phh2HXa3HCzZXHNsAfF2Ua+9lam9V1LP/yX3m6ayuH53TX5OuOZQWkLlCiZiwNH
         Qx7d4MvW7ia62IjxQWI601eSZH76MdTIuPaUQn8jZLUJmz5LuN2a7Sa+R5/+mfShZU+u
         iVlwvh+sp18nzjSVF9s559tEmE5iP8mumuIsOdkEiHlZPJoXOYaisg1xaqu0FwSNI5Xl
         kX/Hjw47F9dgWipyNZ5wm3GwEfACbPObA8jVRm4ZyR+t1lBT8Eai3UrNNTn7DQKiOc1J
         zcFy7i4T2Ttd04GXtov9MsnWDqAUxbggAG2lkDS2rtJE1RYLbdnCXGaej9Ks5qwuwMQj
         3DfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ao1eOwSGGwBUHC7oBTB1HifA2RMb8BiLa95e46gEZ7k=;
        b=4nLX/Sk71yUOvEAszbAre3XVOJy5XJ1hioMO1ZWm+LKF0JEYU3DfJxELIqeuU0/rwE
         PrHou/m6xa2BnYLr7dK90QZkemOm+hNT2jm/SQev25Z+CR9FyKg5uNDX5a3qPhkbnD2p
         6yLmatuGaO2itPdL7Fed1quUunjv5a50t5mseBJetcaIwEmI1l6s7xZZyovVGBri2rbd
         aOvJsgGvtXMxihnubtgCgp8Wv11m7ftHXqaP3iiDEhBTrzPKhb1GTI+oxk07R7mxfyOB
         C3T50lR250q4n8wEwogGZ80MrfkNHplKTzkzuTdyMJItLlRRWhlSuM46FOPpjerQoHCZ
         aApg==
X-Gm-Message-State: AOAM532QPYPjHf55+EsqjWewyuCs2YGPsogrgO1jMYDWUtXKdQJdPca+
        DNd9gAF4m3Dw2ZzKscf5pggyMXyjC6pMaLEzptU=
X-Google-Smtp-Source: ABdhPJwsfpJoi03xIYEkbG49RKTtT0o4s9nM4QrNObIadw+fASXv++7mDqAn4yjcEvjg0hlCGhwBD2fjYlKHtf98dUQ=
X-Received: by 2002:a05:6402:4390:b0:42e:b7e:e9ac with SMTP id
 o16-20020a056402439000b0042e0b7ee9acmr50974408edc.97.1654877121001; Fri, 10
 Jun 2022 09:05:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220608120358.81147-1-andriy.shevchenko@linux.intel.com>
 <20220608120358.81147-2-andriy.shevchenko@linux.intel.com>
 <20220609224523.78b6a6e6@kernel.org> <YqMmZBEsCv+f19se@smile.fi.intel.com> <20220610083918.65f3baeb@kernel.org>
In-Reply-To: <20220610083918.65f3baeb@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 10 Jun 2022 18:04:42 +0200
Message-ID: <CAHp75VdOc4w3ocAgQXLCcsjef61ap66X-PTb9hKXc_cX1fxD7w@mail.gmail.com>
Subject: Re: [PATCH net-next v1 1/5] ptp_ocp: use dev_err_probe()
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 5:43 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Fri, 10 Jun 2022 14:09:24 +0300 Andy Shevchenko wrote:
> > I have just checked that if you drop this patch the rest will be still
> > applicable. If you have no objections, can you apply patches 2-5 then?
>
> It's tradition in netdev to ask people to repost. But looks completely
> safe for me to drop patch 1, so applied 2-5.

Thanks!

> Don't tell anyone I did this.

Tschhh!


-- 
With Best Regards,
Andy Shevchenko
