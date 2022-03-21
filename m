Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043B8C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Mar 2022 16:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351514AbiCUQz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Mar 2022 12:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235324AbiCUQzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:55:53 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8F25FB8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:54:27 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id t25so25567554lfg.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3QHsnyUwRgh9Zh5qpeVweLlzxCn7D7LuIU3RUmgqums=;
        b=egpi7bBEIGYij/LrErQD5lmja50L04iTQ7SBgwFYf0PQb3jA12zLVfP27psT7ngrVr
         FawBlv5grMXE2q6NPehTrvRvEc12Gsg9iJoVfhK9H7lkb7pX2rgvbyRIqMdTjVkumZdm
         5pZuwDSuZYlmBKI2tvrXlJ0XBPH1XXkpj85Q0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3QHsnyUwRgh9Zh5qpeVweLlzxCn7D7LuIU3RUmgqums=;
        b=r63ZUSuqpkVQqx4R+V5PF7DkFTwVAx/1zXYhjkGn1Tj0SQDftKHkdRhA/kd5ogIQve
         jrnlqOgCnoZ3tYN6d+d7VZ1FHOdTjUm4950DdppEcr1w93aFJyJApADv+ar/szsZHW+L
         MNznp9fGlFPuSnFZIVkphWcc9ppj3ALQlvWvA70pLmYRBlleQN539qRmLbkd+4mDXt3h
         /RNFtmgivymVCQL/F1vRhEiuYPLWpP+d6ovuZ2LuUep0luqPxWKzsrfReZcUm7d1CAj5
         205L/b1Rsv/oXktdu0fiqyOV7BzzA3kiczze1XwlnOj2v6ElcPwF58vXrctY26U6MzvQ
         tVTQ==
X-Gm-Message-State: AOAM530/ysIZaZByf6KypcxSqY4gHvR+OfV5XUwqQtcvaKC6ed/DVkJj
        27AYVLLwkHiJOQBpS5PNn1BP3v20cLKhha+iKZc=
X-Google-Smtp-Source: ABdhPJzuQeYwv6xI1kbaJVzEdDc7wYbLg+Nc3kYKKgxxt9BM8/Y5s0RcMsm1LNiheXtSWR0ORKcTLg==
X-Received: by 2002:ac2:410d:0:b0:443:7e85:2a4 with SMTP id b13-20020ac2410d000000b004437e8502a4mr14880905lfi.220.1647881663156;
        Mon, 21 Mar 2022 09:54:23 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id w27-20020ac2599b000000b004481e254f08sm1844773lfn.240.2022.03.21.09.54.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 09:54:22 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id bn33so20719173ljb.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:54:22 -0700 (PDT)
X-Received: by 2002:a2e:9904:0:b0:247:ec95:fdee with SMTP id
 v4-20020a2e9904000000b00247ec95fdeemr16344514lji.291.1647881661878; Mon, 21
 Mar 2022 09:54:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wj4fFjx2pgbGNBM4wJs3=eReZ05EQyprzgT2Jv8qJ2vJg@mail.gmail.com>
 <20220321145822.GA1158046@roeck-us.net>
In-Reply-To: <20220321145822.GA1158046@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Mar 2022 09:54:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgKR6aLAuo2xYCMXht0uzNA=2mYV2ymx+drs02BK1zaMg@mail.gmail.com>
Message-ID: <CAHk-=wgKR6aLAuo2xYCMXht0uzNA=2mYV2ymx+drs02BK1zaMg@mail.gmail.com>
Subject: Re: Linux 5.17
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 7:58 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Build results:
>         total: 155 pass: 155 fail: 0
> Qemu test results:
>         total: 488 pass: 488 fail: 0

Thanks for verifying. We got there eventually, even if it was unusually painful.

                Linus
