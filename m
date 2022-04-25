Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F211CC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Apr 2022 20:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245134AbiDYUQB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Apr 2022 16:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiDYUP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 16:15:56 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CCA104F16
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 13:12:51 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-d6e29fb3d7so17267105fac.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 13:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=4WsHbvMFtfCO4s6g5Z/Ba4D0j5zDJD/OJ+xdomCe93g=;
        b=hVNPteKE/AbRszScEp3f58YVOQPMhjkU/lwe3GRxf8FURBAz7mr/kqhv5rwGd/569q
         DfCG2jHhYTXKydBLGnL0gqjTREwgINkl+xqXsFBCzTaUh0buSs8+UD2QbjicOLYnJCJ/
         ruFc9xWlkwhPHeFUknrf0ycgg/fyOhbtZBjWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=4WsHbvMFtfCO4s6g5Z/Ba4D0j5zDJD/OJ+xdomCe93g=;
        b=Smd1hv9PA7lgJZ5M8YHlpv7SzH9itsekpg1YJViaWbTMHtzVgoaFaZ6/662OSmte+/
         vygUYpHGpqB35/vXcUS/OczOhFjDXxS59CLcTH1BBO0Uloxh959JVMT+2GxBZ7RPxjSh
         8u8F8htpneaD9OItVn8GInvtxScZZqNZN2XxZE4VBYCV4bX/KslF5wGsCvM3vnFdbjx/
         2Lug9P7mXKKvXimN88Av2XQucq9o8KDGQFzylMj1el9fFnvbnDdW+nvp1js5vUcsdvtC
         fCFX3gxBgGrufNLFvvOi+CDIcpghf4pchf5op96VJccErrIm9a3NzYVZ3du71iRX+9CE
         VIww==
X-Gm-Message-State: AOAM532X5dRfRh45eJQbB1UvTCq+nh0QavsMO80iKqz6GAgcJKiZo2o9
        4NY6EZ2q/scs2x1jVxVeWDyrPBxmdO17UxoaJh9V9w==
X-Google-Smtp-Source: ABdhPJwBcUHuuofxNADsFoXO6XpSPVQwW4abM1ZYARF/lutQMaCVG6TzIX/8R3w7WDwoFpbGX/Ty2z56yD6GIPb2kMI=
X-Received: by 2002:a05:6870:15ca:b0:e9:551:6d1c with SMTP id
 k10-20020a05687015ca00b000e905516d1cmr6307596oad.193.1650917570622; Mon, 25
 Apr 2022 13:12:50 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 25 Apr 2022 13:12:50 -0700
MIME-Version: 1.0
In-Reply-To: <YmYZt7WQC17aE1fS@google.com>
References: <20220413033334.1514008-1-swboyd@chromium.org> <20220413033334.1514008-2-swboyd@chromium.org>
 <YmYZt7WQC17aE1fS@google.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 25 Apr 2022 13:12:50 -0700
Message-ID: <CAE-0n51NugMRXEruDdgpNBkBBowQ6NdZBGUrHs5sEBecrmd=Ww@mail.gmail.com>
Subject: Re: [PATCH 1/2] Input: cros-ec-keyb: Only register keyboard if
 rows/columns exist
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-input@vger.kernel.org, chrome-platform@lists.linux.dev,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dmitry Torokhov (2022-04-24 20:47:03)
> >
> > +     /*
> > +      * No rows and columns? There isn't a matrix but maybe there are
> > +      * switches to register in cros_ec_keyb_register_bs() because this is a
> > +      * detachable device.
> > +      */
> > +     if (!device_property_read_bool(dev, "keypad,num-rows") &&
> > +         !device_property_read_bool(dev, "keypad,num-cols"))
>
> Why are we abusing device_property_read_bool() for properties that are
> not flags instead of using device_property_present()?
>

Because I wrote this using DT APIs first and wasn't aware that
device_property_present() was a thing. I'll resend it with that API
usage.
