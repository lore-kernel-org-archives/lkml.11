Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E79CCA483
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jun 2022 12:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235020AbiF3MD6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jun 2022 08:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234351AbiF3MDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 08:03:55 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FA374795
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 05:03:53 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id w83so25722030oiw.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 05:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zOvwIwWqR5EO2lNFoUUmwz2sETLTMOQ7ejH+OnZOrOk=;
        b=PqQLLZJ2ZKkoxPkrHyZg0oRJQxv1SwlVRLyoUwWodeUAplwjnNWtX44JGPQJq25nqg
         kgNzTI1diYu8vYNssW6Q+NKIdJ856q2SGtZxxEjA9Qvg510fdECJarMB00L4jW3D93wH
         y35e8mPJ7xBAxJFt+xnZ0h7CxMEHW3L5HhZ1BwiiFT2m6c7LSCyvAXBF4T9wmI00kyiP
         o4bUpROLYIyHMF2trI2e6+sJq6wQimYkQCAt6nFiXybJuyz9NoMCSVW1b1EKJCOECuUL
         FbQX4wAnlIqZeM5tstXJDWBCceA7Ndt80RxHipCG+bi7ArAHddo2LLva5c+XIxpEFGoY
         OBPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zOvwIwWqR5EO2lNFoUUmwz2sETLTMOQ7ejH+OnZOrOk=;
        b=ljN80TaqyaCcLwACAQS9wXLfjjfhxZZSYjR1DEI+UkHAedNTPsVLSECOs9Q4kJ22LJ
         cAXpBAwE+2Q4jIOv2JMU2PMgs0xiXsh9Q4ptbjoScND9Rd4FHcCGDC0yzuDHaCbI/gmR
         rSTReBuHCt3reXSVDanvNp5l889EIl41xvsZdLwrsUxYnxaP/PNz7+gxUqhwMKU6q9E2
         +X/vkibhV/zxM8Yvx2g8vQW+xxGJmDTabOpzOBUywmX+JllPOoHWDc6HoW300YoG47T6
         FisGo22OKgIXLmlFnrTuBMzwCdf2DaF3eoO/e0Kha0K+HL08cdrZl/uig61Hwqyy74vE
         lmTw==
X-Gm-Message-State: AJIora8Jd0rq/0acExO6MVvLdOhBUfkqhaX61GOtF2DfnfoGNy4VV1TY
        yYQ4y+ft5duX8L1x96s7zf/wPWYZMKXqjMUkz0Sh7w==
X-Google-Smtp-Source: AGRyM1t9+3h6Mrk2A/8pgzvzC9lNsAp1cEGjS3G83IqK9iIHIM2ki9s58k4XQIujrkIi67LTOGdsX+1et3HfwtpuRfM=
X-Received: by 2002:a05:6808:2124:b0:335:7483:f62d with SMTP id
 r36-20020a056808212400b003357483f62dmr6311959oiw.112.1656590632727; Thu, 30
 Jun 2022 05:03:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220630085845.74566-1-jiaming@nfschina.com>
In-Reply-To: <20220630085845.74566-1-jiaming@nfschina.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 30 Jun 2022 05:03:41 -0700
Message-ID: <CALMp9eSTQXHna7D9vH-nt1dXkbN3F-Bdx8pHUOQSXLcNtt=J7A@mail.gmail.com>
Subject: Re: [PATCH] KVM: MIPS/MMU: Fix spelling mistake
To:     Zhang Jiaming <jiaming@nfschina.com>
Cc:     chenhuacai@kernel.org, aleksandar.qemu.devel@gmail.com,
        tsbogend@alpha.franken.de, linux-mips@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        liqiong@nfschina.com, renyu@nfschina.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 1:59 AM Zhang Jiaming <jiaming@nfschina.com> wrote:
>
> Change 'writeable' to 'writable'.
>
> Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>

Writeable is generally accepted as an alternative spelling of
writable. You're fighting a losing battle.
