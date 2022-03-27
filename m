Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613B3C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Mar 2022 23:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235504AbiC0XJT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Mar 2022 19:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiC0XJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 19:09:18 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1200BDEAF
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 16:07:39 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id y38so20524786ybi.8
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 16:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ve5+XZdwip+wfJ4zW83es5FP+je84qvCmA8uoY+nFLs=;
        b=U7PQrj7BlEBIpfqmMR8TfU+MOKxh3kIGvThZ45dmPpytK+1bkRmD/iuObLyklhxlT2
         FG5vAILis0+hh0PeEyFI27qkcE33C1ysq5W6UlMUEv8bwsgBADY406aM4jCRhHuzQwvZ
         rfLG4jC3Xl4ugO3PSn18wKQ2FuvSOTyeZb7h0TiKqf7DYA48Ow08vF0xmTzlnVh4ix/w
         0+4pm+GDQOg34sGRkCe1C30T9wJzePDXxF00iRWQ/4DLf18QAH57XcB21/uqJyiY/aw/
         m1vOccxyiGQEGFJEcKITiqBDHq1H/G9cYgC21pks78eGltS3VcrCHDI78JDh7Mk3UZ2J
         8W9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ve5+XZdwip+wfJ4zW83es5FP+je84qvCmA8uoY+nFLs=;
        b=PowdG1EAo8KhvvfVlMde8FGds/plc/l4MAUv1/kVJ0TN2gPm6XuKcphq/0GNWw/g5D
         jWC6Fg8ZdjqvqLgb7zPmjpTBAR65uqJ63alRRB/u80H7fhXjgdk1j2PDKDg61QLIyhyx
         usiLFsbSYd8E5sBF9X+/7TFkMA5viBaVmUlPCUIWoyCoAMVnx9CcWxreEHmtaNTu0ygM
         Hrm6PgtymIDNj5h/dWB3YdFMcdJut7+A7xWy68GhdE32M5+cEtEPf289j100cmneETcg
         BnI7hcczpwzW48RmBEvOpcmbv7bMXHliIRDWfQoOo1C+XXkhtbYZab5MVwex89JT4DBT
         OIWQ==
X-Gm-Message-State: AOAM533PfmRUpa+ru8BvlIM9g/uCvxZdLGmwS4dFO9FfOzN0yglOnkqy
        y08cIQAoX+0gy0N6UmfEBapq+nA0PYBJV7gdtkWduL8vz5eU6Q==
X-Google-Smtp-Source: ABdhPJyYdGF7SbqGEL+ETG0K/sHAhVQ0ncmoxpfN+n6jIOZ/nEU4xm6uwZxHYNtHVmCEdtNxAygQYxsyW2X45AkixBU=
X-Received: by 2002:a25:d088:0:b0:633:b902:2d29 with SMTP id
 h130-20020a25d088000000b00633b9022d29mr19969569ybg.626.1648422458225; Sun, 27
 Mar 2022 16:07:38 -0700 (PDT)
MIME-Version: 1.0
References: <1647927649-9907-1-git-send-email-haibo.chen@nxp.com>
 <CAHp75VdZ9RVuMrgWXOWqCrmvHBtkz+S=dxXhR44Ri3p6Pj5LMA@mail.gmail.com> <AM0PR04MB4001E8E8DA1DF5355EB96A2B90179@AM0PR04MB4001.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB4001E8E8DA1DF5355EB96A2B90179@AM0PR04MB4001.eurprd04.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 28 Mar 2022 01:07:27 +0200
Message-ID: <CACRpkda5szS32JkMFaTjw+zm+Oye+8QCv1A0B2UL6keuYPKS4w@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: Allow setting gpio device id via device tree alias
To:     Bough Chen <haibo.chen@nxp.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 11:16 AM Bough Chen <haibo.chen@nxp.com> wrote:

> For users, usually, they will open /dev/gpiochipx to handle gpio related option.

That makes sense, it is intuitive in a way.

> By the way, how can user get the labels and device names of GPIO chips?

The way to get metadata for any /dev/* device such as topology on
buses is through sysfs.

It is also possible to get labels for all gpiochips by iterating over them.

The most user-friendly thing to do is however to make use of libgpiod
and associated example tools such as gpiodetect:
https://git.kernel.org/pub/scm/libs/libgpiod/libgpiod.git/about/

Yours,
Linus Walleij
