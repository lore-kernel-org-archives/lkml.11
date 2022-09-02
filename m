Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF83BC54EE9
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Sep 2022 09:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbiIBJWe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Sep 2022 05:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235377AbiIBJWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 05:22:31 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A799AB432
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 02:22:30 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id w18so1242612qki.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 02:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=L9O5decV2/N6JOI8M13p/L7aDc3oKkUKc7b1+iVr6Ns=;
        b=n8pH9KVWUwdC05ORursrzQoLTB97iTUEuehPv0ggTG2QfBGg4nhiwfUPI/g+QGH3zT
         r9xBeHoditdJ7HHhnwz0AeDSPO8cfpprt8M7agSmx3x6JQS5ZWR1kvT3LsYcbVnvpvwm
         omAtNUkcO62GYE8XSPDGGD5cVtwdCjlLJ2fJD01v4N1jRJZv/Fxvo2StNLMikWN/6ods
         0H5mdHSLTjgbx77KBirRUlzPEWeDgPxO3CE1inI1PJ8QqlMTwyG+Kig104RY9g4hIx1w
         ju4WuFunjO25RTn99gp3+OZWHMLi58Zn5cjvS7v9Iw6GkeavE3qAUE4yDKd1VotFCsTp
         l2EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=L9O5decV2/N6JOI8M13p/L7aDc3oKkUKc7b1+iVr6Ns=;
        b=EDEKCqn0m4yps+OiFuB3tVfBY1Ynn+o0QI6OM7FKFzRA9le4QB4m2iqC9X2AdgML/c
         R+egSLw0kEgUdK8GjnN0YJARsH+q4Q3S85lJ8pT7H3XakqDuvb1lFqTMY333cQLKIert
         lRkhRofCyDNBinTNpN1ZmgR5uJsUr1cUH6Vl+4JCVwqQ+wxio4lI2kjUyg+OlhkMFDVT
         Q6u0fSeX+LHq+2yPLIJdhNvAKRsJzwopa6GVaJaFWnNrRmYoT8gMonGzNAWwDZ7i+WLh
         PZQU6N0gsqN/zvOlpVsK93n4LiiQ9Ci2RwHGnvZH2xKgznaFiID0ni/I389wEXhZEfyj
         d12A==
X-Gm-Message-State: ACgBeo1E344uuuGbsdSvd61mqCzTCJ/sekZmBaaRnUvqniRnrc1PxT9o
        6qp84iPZlVBU5n31aaJSKH09xcULNwzOdBQ5XBU=
X-Google-Smtp-Source: AA6agR5D3GHip/lU9Aj+WQapz0eupiIvUYun+mL3ehqHavPF9Osvco/OW9GJftX+j+YzjPj7xn78DqEhKYcPwbahytE=
X-Received: by 2002:a05:620a:410e:b0:6bc:5cdc:88ec with SMTP id
 j14-20020a05620a410e00b006bc5cdc88ecmr22866476qko.734.1662110549331; Fri, 02
 Sep 2022 02:22:29 -0700 (PDT)
MIME-Version: 1.0
References: <1662104841-55360-1-git-send-email-john.garry@huawei.com>
 <1662104841-55360-6-git-send-email-john.garry@huawei.com> <CAHp75VdfwGCUpZN3b1AD1kARc=FhyA4EDWDuZ8+1DKN3u73DeA@mail.gmail.com>
In-Reply-To: <CAHp75VdfwGCUpZN3b1AD1kARc=FhyA4EDWDuZ8+1DKN3u73DeA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 2 Sep 2022 12:21:53 +0300
Message-ID: <CAHp75VeE2OZHzwG-KbTHYks+G=sLfyx9Yy1W=RxORTtet-vDnQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] bus: hisi_lpc: Use platform_device_register_full()
To:     John Garry <john.garry@huawei.com>
Cc:     "xuwei (O)" <xuwei5@hisilicon.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linuxarm <linuxarm@huawei.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SoC Team <soc@kernel.org>,
        Yang Yingliang <yangyingliang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 2, 2022 at 12:18 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, Sep 2, 2022 at 11:10 AM John Garry <john.garry@huawei.com> wrote:
> >
> > The code to create the child platform device is essentially the same as
> > what platform_device_register_full() does, so change over to use
> > that same function to reduce duplication.
>
> Now statistics plays for you and not against.
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Too fast to give a tag, see below (keep tag if addressing it)

...

> > -       pdev = platform_device_alloc(cell->name, PLATFORM_DEVID_AUTO);
> > +       pdev = platform_device_register_full(cell->pdevinfo);

> >         if (!pdev)
> >                 return -ENOMEM;

As per kernel doc:
 * Returns &struct platform_device pointer on success, or ERR_PTR() on error.

-- 
With Best Regards,
Andy Shevchenko
