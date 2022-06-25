Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD324C43334
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jun 2022 17:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbiFYR0M (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jun 2022 13:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbiFYR0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 13:26:11 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176D813CDC
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 10:26:09 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id s20-20020a056830439400b0060c3e43b548so4256363otv.7
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 10:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qdOBIdyq2W/XPrbuZUOS3HZJhZlnWjio9PK1s5ldH9w=;
        b=hZQq/Xzg9/2t0QmYfD8eMd0ERp/kboN8Hrh/uFMKSsFkqUeGOdhQ+igDNE6eJdOmco
         P9xNfHOUqyIESA/tO88I91Z32GnfGZtlejdUcw0AIu0arbKJNpXuK+FBaOwnkn5dyYB/
         KZZ43SiuwyDICkH7ESSA/X+dsq84i4/h4zEdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qdOBIdyq2W/XPrbuZUOS3HZJhZlnWjio9PK1s5ldH9w=;
        b=Y1ZP6SmlkpvvrPukhn/Q2aDQlzbUTCgdQirJi6ahawkjRBcgVDRyqmmZssyVLYmBtk
         Z7MYbVATlM6euuNpOwz1sbrlba9WJ995MFzxYkVD+HL1aVG7URs/tHClq3LYnihYm3hl
         YkgCMjDyQIbUCo8VYW+sfdswOd/zrCx9EiI42D8Gn3VE1F/hsPkCNQJxhtRZ+vbGYgnM
         gElpI+5DUkukPFvBqVAEz2BvJSit3mJC1Yr/37AYoVOswDLUeB2KEhov8UYF8J+hhmqb
         smv7twVHM0UJ7SLbGjwX9Zv2OgRWrbTi4uZvMT6lZcAt9vbAywt77KCGh9vg8FMpDsud
         uYYw==
X-Gm-Message-State: AJIora9kqmKzNjzeZH7R/Aut1QG2+0rGyDi4Hq/l0NZl2yj5Kciow3yU
        v3IIzX5lyQDyupQWShVruzUQCjSMLNWrcU5b5SUJ8w==
X-Google-Smtp-Source: AGRyM1v90/YxbmcOktrcWS9DxeWQq808SQa98paCZc/w/xSNEY7prmP71nEBVIMEduTLyuJ+K7GzD2U7EYl6DmFCMRo=
X-Received: by 2002:a9d:178:0:b0:616:a150:dbae with SMTP id
 111-20020a9d0178000000b00616a150dbaemr2407570otu.321.1656177968486; Sat, 25
 Jun 2022 10:26:08 -0700 (PDT)
MIME-Version: 1.0
References: <85a6nq45uh.fsf@linux.intel.com> <20220620094907.4101274-1-maciej.kwapulinski@linux.intel.com>
In-Reply-To: <20220620094907.4101274-1-maciej.kwapulinski@linux.intel.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Sat, 25 Jun 2022 19:25:57 +0200
Message-ID: <CAKMK7uFvU3fvx4D2UGdJypc=GGq42zM_9HKgXUM2cu0zPk-WOQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] Driver of Intel(R) Gaussian & Neural Accelerator
To:     maciej.kwapulinski@linux.intel.com
Cc:     gregkh@linuxfoundation.org, andy.shevchenko@gmail.com,
        arnd@arndb.de, corbet@lwn.net, derek.kiernan@xilinx.com,
        dragan.cvetic@xilinx.com, guy.zadicario@intel.com,
        linus.walleij@linaro.org, olof@lixom.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jun 2022 at 11:51, <maciej.kwapulinski@linux.intel.com> wrote:
> On Wed, 16 Jun 2021 09:38:14 +0200, Maciej Kwapulinski wrote:
> > after consulting, we will try to share api and some kernel code
> > between the two drivers.
>
> We prepared a prototype work based on Daniel Vetter=E2=80=99s invitation =
to
> evaluate DRM framework as prospective fit.
>
> Early results look quite promising. Effective leverage of DRM framework f=
or
> non GPU driver has been achieved. GNA driver source code turned out to ha=
ve
> been simplified by offloading some areas (device management + memory
> regions management).
>
> As a result, GNA driver source code size has been reduced by 15% (420
> lines). DRM Framework complexity has not been an issue so far.

Nice.

> Plan for next step is to publish code to dri-devel ML.
> Please share your thoughts.

Sounds like solid progress and looking forward for some patches!

Cheers, Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
