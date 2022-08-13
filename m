Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739FCC25B0F
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Aug 2022 10:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239368AbiHMKzB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Aug 2022 06:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238945AbiHMKy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 06:54:58 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA735722D
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 03:54:57 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id s11so4034610edd.13
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 03:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=T80P74qbpj5vnMOr57txdNOpWY9dQuakWIHmQmaO0bo=;
        b=vz43f7IsrsmFgS0prhQY7gZi2KYVbGQ1NRKidNZSyuaKi3iz4+uqkAeN9lEgNHcD+h
         mL6sdzVe9vdHQSpCNbZ/8+mmryxjZQy62rgIFI64fy6EB1ItGHn6knn7IcaxmQWKIpZJ
         cAAg06Wo9RXL0fs8Rw8M/XA0/SxS9f1lQcYeNxgG6C1Ttt59q4oIWCyIaLCJw93OEyYa
         ozTC4cXBaIIEuad4jRNcVs35lRUtDbyK87uXOHga+TIVmO5Phle8KkldZTeoqY6bFGi6
         fOYGt8kQ1mqqyXVKRlFYEtqqBGxS+4skaBPdlEmLu1Erb7PC3M1kRW9EXH6mroH9c/zx
         wKQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=T80P74qbpj5vnMOr57txdNOpWY9dQuakWIHmQmaO0bo=;
        b=csb83Vt/nse1ri8XNABIat/V8mXdYMeikVRmx+lYOguvJubvKsiSik9TvPEi+aPArA
         9xLHYpb/X7CNMNSEgxHXk6MUoITrFopGdeRaeU0WTusUDCsdoOlPHtscvxj1AjXZNKLj
         Lpr/VrFoHz0Q4pOP58xCshVhxcXhB9uyBiciZvWOjfbBzcNDFzSGRe0FDsnzKrI4xkI+
         KEHKwK5aB/zL1ky16xZbklOE95EMaNLhQinU9gWGwMFrsIYjk1AWNt/Pxuk3xajZ6hkD
         LC7/MjDiDivtcVBufpWWNleEUn6jIafMR5U9uyX4p2w69zsc30FlBccGkOWJMxkMNe8M
         mBdg==
X-Gm-Message-State: ACgBeo1cTsRXfigX2o56Lqh4tAUURVX1FtUWEZwoditj/6gbZc8O4NS8
        gRxBZGfeQQZJ4/K0johVNgg/N3pdYfo+TXXDwHhPig==
X-Google-Smtp-Source: AA6agR5Sp7DIrEkdUIGRTVjCP5YraoJlt0EehiCtwAuXGuwm2/AhpZCyJmlO50m0eSeYVRXGcuTkEIWEZqv5BUBFX1s=
X-Received: by 2002:aa7:c70d:0:b0:440:432a:5f9e with SMTP id
 i13-20020aa7c70d000000b00440432a5f9emr6865623edq.110.1660388096101; Sat, 13
 Aug 2022 03:54:56 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYt_cc5SiNv1Vbse=HYY_+uc+9OYPZuJ-x59bROSaLN6fw@mail.gmail.com>
 <CAGETcx8bGwDkPP=d2MtcY69YmTyckUSa8xAwNVOPOyTR8jPk=A@mail.gmail.com>
 <CA+G9fYv0DFZi2rMPQTHvK8yD7g0LZTxN76iKZxP4pi4+8Rstxg@mail.gmail.com> <CAGETcx9Fae8tVhf+JrbYTnau5njLmjz75u-gJGkT6f7wjVdCyg@mail.gmail.com>
In-Reply-To: <CAGETcx9Fae8tVhf+JrbYTnau5njLmjz75u-gJGkT6f7wjVdCyg@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 13 Aug 2022 16:24:44 +0530
Message-ID: <CA+G9fYvhyqErxfAqjxLW33wuknWsoxgCWEq-EAHujdz5Rih4iA@mail.gmail.com>
Subject: Re: [next] arm: PM: domains: Delete usage of driver_deferred_probe_check_state()
To:     Saravana Kannan <saravanak@google.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

On Sat, 13 Aug 2022 at 06:23, Saravana Kannan <saravanak@google.com> wrote:
>
> On Wed, Jul 27, 2022 at 10:35 PM Naresh Kamboju
> <naresh.kamboju@linaro.org> wrote:
>
> Ah, I forgot to CC you on a series that might fix this. Can you give
> this a shot please?

I have tested your patch and boot is successful on x15 device.

>
> https://lore.kernel.org/lkml/20220810060040.321697-1-saravanak@google.com/

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>

- Naresh
PS: Add these tested by tags in the main thread.

- Naresh
