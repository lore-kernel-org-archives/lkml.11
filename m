Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2B9C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  2 May 2022 11:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384692AbiEBLWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 May 2022 07:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbiEBLWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 07:22:30 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236B1BC17
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 04:19:01 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id g20so16219634edw.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 04:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HkHb9zDzaQCh7icuTIrBW1dLzBtZj3gG9lMpTgSrSE4=;
        b=yqitAepL/r7UgctBxOUq2kCCbQqEQvIwdOiY8s3pSmTs6ORlW41oYP2FWA7dfxvzb+
         jL/viL3ecqJ26Fuc6oLYfD8+WhGMwM/ABX2edufGwRlrUfG2cQUWxUrsRwzcvzzVXcDk
         sIw9Sv9yjknXSHSnPYnAgnzoI6OuKqGCCkb0hzYI7P+VMZH5o0GvJcJ0lPOhJx6Hz3GA
         Aw+KSSOe917yRmBHbzDjfhYkFueOBCZhqYxLZwvtnUu0V05e2ZxqULfphKrbYjChXjU3
         W3NOqmCKvb/iGzBOOBfag2KPQ/9p95eMAogvsIJhL5WfaAmou9TRL5ZfaCaZowDMvODr
         tHXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HkHb9zDzaQCh7icuTIrBW1dLzBtZj3gG9lMpTgSrSE4=;
        b=wor+w33hM/t3SZ1RsOY1hsMcUk05N5hEMD6laBDcG59+3hh1Pg7C0pZ5uigi5/ej+O
         23coBN9FHzIvoMTUd8CkQ0lPK88L/WLYNjTCb8kIqdLUgbiiMxS/GstWJpGeXyMPI0SE
         qeeepbITc33bAt0jmA4JDXrFX9D+cKlgiRW/IwPTjcQHT+pPTTsMKYKFNtgF+bm1Qjex
         juv59wGx3Kr0gma5hM+eArgRruh2917oy5dBNZc+6Lb+wQd1yy4LoibeW7ouc7I2cIAZ
         wgP27ZVeGl/qzsdnsUePsfjTb6+rcyaJbHaOcZO+4UH5QuYjEtThfbDfGm3DKQxfPV6+
         bK/Q==
X-Gm-Message-State: AOAM530UDrcrHTA3LvICwEXNWKw2qxoagz648amkELTk9VjxIR5JA76a
        mbs6OlhPSrUXTJTWcKY/ZOCTRMp+7Gd2IKq86azXiQ==
X-Google-Smtp-Source: ABdhPJwBrdywMt5x3Ze2ZxcFXXgrCbDZxAOQm3OTuht5rGWTVnQ9/gIhZUySEPXpta7fcDmFxIYbg84nCTDMxM6xgCk=
X-Received: by 2002:aa7:c49a:0:b0:425:d526:98ad with SMTP id
 m26-20020aa7c49a000000b00425d52698admr12673123edq.352.1651490339736; Mon, 02
 May 2022 04:18:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220427144620.9105-1-pmalgujar@marvell.com> <20220427144620.9105-2-pmalgujar@marvell.com>
In-Reply-To: <20220427144620.9105-2-pmalgujar@marvell.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 2 May 2022 13:18:49 +0200
Message-ID: <CAMRc=Mf91eMF7D6CRtA8-HQ7pdtP343WUGhLG4qti_9zJF4ELQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] gpio: thunderx: avoid potential deadlock
To:     Piyush Malgujar <pmalgujar@marvell.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Richter <rric@kernel.org>, cchavva@marvell.com,
        wsadowski@marvell.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 4:46 PM Piyush Malgujar <pmalgujar@marvell.com> wrote:
>
> Using irqsave/irqrestore locking variants to avoid any deadlock.
>

I see you'll be resending this anyway so would you mind providing an
example of a deadlock that is possible with no-irqsave variants?
Thanks.

Bart

> Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
> ---
