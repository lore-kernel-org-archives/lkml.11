Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C29C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Mar 2022 02:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239017AbiCBCdx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Mar 2022 21:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiCBCdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 21:33:51 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B2D4C7B6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 18:33:08 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id b12so510244qvk.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 18:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lSiSPFe8iX4s/Cskxwb02KRknvY9DHD+1TS5sjTtth4=;
        b=fnbbwNmU7rBK+eDNfT5Q2EaTJe8Y+GrN2Xl8IUIU0/3ijzM+MeibxSa9cIODY9sw5b
         J9jVWftN6B3jhM/q9Q7mjTdZKCImRiO/BpwykvUqXU1+joEreU7xSh+Q7Cpu0p3Dsn5g
         Zjvxih+xAxi4w34QHe5PysysqeHTk+c0NFf0xZc5QLIInRN6M8pFu6oNUepiPVDmtc59
         o217fXl594Jdbrqzfn/Hn9Hu9NGWfssRZrg7JGFntwraSCA5ThIRBzXV8aZojsu7zOUH
         nFPXo6cxnb9bFVnDo8AvUbs1425mSfCvTAXten/j3bm3L/yDtvV/GvyiP4iBUh82lv9S
         DWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lSiSPFe8iX4s/Cskxwb02KRknvY9DHD+1TS5sjTtth4=;
        b=hYhnLlILuvZcRd5dyThrFlL4J7Ja5OuJOl9QKPhdFzrpGSzovyfMK6MYo09+9RtqLl
         BaWkssG+aMIu8RstCmC2UUyTC3TZ4u7O6/qVIl0ktfpC9HCpKDwEAhl5Fbu+gj4C96If
         eWypBOWFapwJ7KRg8Q7bodtV/BcU9wwpGKgHO6sG9pDBAebBtwlRXYlzYMxKCnP9afZS
         eUoNW+nbqOwxW9jZaR6ORmaIlv25zoFZKXhsyE/4aSSXE77p7tMqvYpaG0QKw7afn85T
         /NJi4/bgu5KXJA9H/CPi/JspnEMY9iyCNeX9OCIRdeeDt/ozfZmHwz1O0QVVEwLyzcon
         duaw==
X-Gm-Message-State: AOAM531Wds9dwW2O5GxRAR1bJvjxfxw9E6yWJ/IfUEHsfiUyeHHAKo2O
        DWhpacIHid7d/u1RUCr2gLG5u5Y6m07xNTV79wRZ5JKoMBg=
X-Google-Smtp-Source: ABdhPJwBXWIugiCEDwQdJHl1jccJGbZEQk8eCYLijo1mE1EyAZf0j/6iUpvJs3E0uhFUyzDYTPaIEz7CchaXauEvo3o=
X-Received: by 2002:ad4:5883:0:b0:432:b007:962b with SMTP id
 dz3-20020ad45883000000b00432b007962bmr18357839qvb.55.1646188387369; Tue, 01
 Mar 2022 18:33:07 -0800 (PST)
MIME-Version: 1.0
References: <20220302114312.077aa81b@canb.auug.org.au>
In-Reply-To: <20220302114312.077aa81b@canb.auug.org.au>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 2 Mar 2022 05:32:56 +0300
Message-ID: <CAA8EJpojNFKB2u6KrfotYUyRfqXjKbwQfdaz1dJ7N=2M7cQA_w@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the drm-msm tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <seanpaul@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2022 at 03:43, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> In commit
>
>   8661f450626f ("dt-bindings: display/msm: add missing brace in dpu-qcm2290.yaml")
>
> Fixes tag
>
>   Fixes: 164f69d9d45a ("dt-bindings: msm: disp: add yaml schemas for

It seems the Fixes tag got split by my mail client.
Rob, any chance to fix that?

>
> has these problem(s):
>
>   - Subject has leading but no trailing parentheses
>   - Subject has leading but no trailing quotes
>
> Please do not split Fixes tags over moe than one line or truncate them.
>
> --
> Cheers,
> Stephen Rothwell



-- 
With best wishes
Dmitry
