Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86968C19F2D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Aug 2022 18:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238231AbiHCScQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Aug 2022 14:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiHCScO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 14:32:14 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796B85A2CF
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 11:32:13 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id r4so14826066edi.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 11:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZXfRi2mrIZZJ4KT+IlnXdFrbfLahWQ9yKxKFGGib4WU=;
        b=vJpjJnv819lAmb+wvmRcOd8vOeY1RIek0+vV+Gvx04J52TG/kQshlpRjluOXzezWi8
         KsSRCBaBh91P9wcB9L4OqcYXySGjKAiTUU0MwekqbLpXpIiu/ikZaEU797i4da4Mu/WB
         MfWjXUZLSff3XLo49IyYW3v5TmtFEFBfX5Iz63fY8JvnacQbmrPZtp9wiQUa1BfeRvor
         zx8zLjlpbfINh/gd8LoJGXEAkRHmyRva3QwXYaOk9bsakjtT2Cl0Zr7RcUlF1HyQXEWz
         gALAqQ2cgwzfCrF3oRakUrh4qMF1NZ+vJKXLThiF/ZM0gOKqvbSAKJT1Z466VKdSG2h2
         fklg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZXfRi2mrIZZJ4KT+IlnXdFrbfLahWQ9yKxKFGGib4WU=;
        b=3uVyYnNXLSWA/gZ5XWweBxhROJ3dBHSnpaCiVU6aaRAMuJVrN+hXrLfKiPSo5Q2KOj
         03FtIt6RxGhtf+ffDh8iQ9THroTHIwDEQI7NOdQJLsik79MsiaPA/bX17slIF1mKNsiH
         Hp6Iy0WmiYjfxOZKmynnPFJugLNhKScFTeeO2UamQPI1VYmekefO4rGSwlvPrKFPlOYS
         DzBPiyQcZ16DiBykVuMXl5TMpicp11TMM55yCTvC7Vjorib29t0Z7qZrmy+XWfex2TZq
         9ZLAThfP0BocyZhWP2M4KIGD8TkJGnRi0wo2/Kc5cPLoYEeGE+tFzNfT4LbD/SnIfL0r
         v9AQ==
X-Gm-Message-State: AJIora/I+XmcnHKSDKB2WuZhFnWA6YHV3krsHtIOdLyRTGHDTyaHTzrB
        J6aqXhJjQf+POJxxeR4w6nEGs2Mkfl+SOWuDd0o5eQ==
X-Google-Smtp-Source: AGRyM1t1FAn79Uu5qj6TGgqMXM+EElLhXe+jDnN9s2bDbKN0iwuzIaboCHGHmWpqhGheaaxbcHfZn4zes/4QxnrfeAw=
X-Received: by 2002:a05:6402:371a:b0:43a:ece9:ab8e with SMTP id
 ek26-20020a056402371a00b0043aece9ab8emr26744736edb.126.1659551532069; Wed, 03
 Aug 2022 11:32:12 -0700 (PDT)
MIME-Version: 1.0
References: <1658829764-124936-1-git-send-email-john.garry@huawei.com>
In-Reply-To: <1658829764-124936-1-git-send-email-john.garry@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Aug 2022 20:32:01 +0200
Message-ID: <CACRpkdb5Af+7xb+QaSqAq9tkSwth58P9j2qZUdcRkDh62kbbcA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: Make PINCTRL_SM8450 depend on PINCTRL_MSM
To:     John Garry <john.garry@huawei.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, olof@lixom.net, soc@kernel.org,
        arnd@arndb.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 12:08 PM John Garry <john.garry@huawei.com> wrote:

> All the many other configs depend on config PINCTRL_MSM, yet for config
> PINCTRL_SM8450 we select config PINCTRL_MSM. Make config PINCTRL_SM8450
> depend on PINCTRL_MSM to be consistent with the rest.
>
> Signed-off-by: John Garry <john.garry@huawei.com>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>

Patch applied. Seems self-evident 2 me, if Bjorn gets upset he
can beat me up for it later.

Yours,
Linus Walleij
