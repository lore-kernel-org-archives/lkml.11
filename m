Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4705C433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Feb 2022 16:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234009AbiBVQ1v (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Feb 2022 11:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234003AbiBVQ1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:27:48 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8B9AC92D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:27:20 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-2d6d0cb5da4so125357317b3.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ORYINw67pQ5ZoOWHnhKhKbeE417mgacXszCqGXghifw=;
        b=ZCt6TATiFHlYTc4SrTZQDV0dmODhoa/PcYUzaYZQ/ErkbsLoCq8wH8KsBjXtItT8cS
         N8SANx/p0FDUp4stmJJ6X5vy+sc4d0MoWVvYqNKrZSPCDtTdfl7uNEPonKk1w2mb3hzk
         ppng5/yLWk6vADRiH9gAlQb/IonUd/c5sifCkL34G040hUwt/v39rYBorFJZp3edrfCa
         w0Tai028iJDsxKPrFr0YEFDqTKvwWy3XcJIrA2SSYQ8+CJyPWmNguGCDAJdo6bxzYFXq
         aUMF9qDcBhmjcEw9jKhUe+KdZCVXb3g+dwY3RVhZiRnIuMiq/+veOV3u6w+wo3Ivxk9b
         MPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ORYINw67pQ5ZoOWHnhKhKbeE417mgacXszCqGXghifw=;
        b=As6SA+1AIHFkGuqIcf6y9f/Fn7q50Vn0RhlNBIkjYcFpMhRXQy8UZPfx6acbQwSlFN
         Lx39ItpRLmQcgP6sqOtZ9HJzPmS3gjkOQt8kgTFzBDiBxCuFFuTmXLXiQr7qGZWvqfFv
         Ao5FSVxYSvRI4OO8bWDbvYVd9tqGGOOB1UTKONoxVXTreA4JPDBYTzy+UdlWXiIxGXTC
         s+6VSK7XTcS5zDUAUFRVIFw/RoN9qehdemEunGiNssI6yZyCMMCiHdSonrmlt8gKeCY1
         TrMMcUTECQyjaxL7fi85XnxcEHA/7YWLKThzAhaoQsKpEdLB6PDJ5gACRczTH+/yLvCQ
         utPA==
X-Gm-Message-State: AOAM5320tzssaiD4r+oXcUOwG/Cae1obxPFfUa3pVuZ35A+bv7OXxut6
        cOKZkz8ut5ahHDdNO465KGY1VIGTjlg7NSiunqfQpw==
X-Google-Smtp-Source: ABdhPJwPwPnelkp+i0QAJ4nyGB9oFEYLPVLrlCn0wrUtvfmdCopNBZdTZ8Wt8KBysg2sSDF7fTxQNI5EOo2AnHqkorQ=
X-Received: by 2002:a81:6a0a:0:b0:2d0:c144:4be4 with SMTP id
 f10-20020a816a0a000000b002d0c1444be4mr24759229ywc.332.1645547238650; Tue, 22
 Feb 2022 08:27:18 -0800 (PST)
MIME-Version: 1.0
References: <20220221084911.895146879@linuxfoundation.org> <20220221084912.825972694@linuxfoundation.org>
 <20220222153528.GA27262@amd>
In-Reply-To: <20220222153528.GA27262@amd>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 22 Feb 2022 08:27:07 -0800
Message-ID: <CANn89iLOiaan+CG94+6-RsMWH5pPLJ6snfAGQ3UJfRBLijTbsQ@mail.gmail.com>
Subject: Re: [PATCH 4.19 29/58] bonding: fix data-races around agg_select_timer
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-stable <stable@vger.kernel.org>,
        syzbot <syzkaller@googlegroups.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 7:35 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> > syzbot reported that two threads might write over agg_select_timer
> > at the same time. Make agg_select_timer atomic to fix the races.
>
> Ok, but:
>
> > --- a/drivers/net/bonding/bond_3ad.c
> > +++ b/drivers/net/bonding/bond_3ad.c
> > @@ -249,7 +249,7 @@ static inline int __check_agg_selection_
> >       if (bond == NULL)
> >               return 0;
> >
> > -     return BOND_AD_INFO(bond).agg_select_timer ? 1 : 0;
> > +     return atomic_read(&BOND_AD_INFO(bond).agg_select_timer) ? 1 : 0;
> >  }
>
> This could probably use !!.

Probably... I chose to not change code style in a bug fix.

>
> > +static bool bond_agg_timer_advance(struct bonding *bond)
> > +{
> > +     int val, nval;
> > +
> > +     while (1) {
> > +             val = atomic_read(&BOND_AD_INFO(bond).agg_select_timer);
> > +             if (!val)
> > +                     return false;
> > +             nval = val - 1;
> > +             if (atomic_cmpxchg(&BOND_AD_INFO(bond).agg_select_timer,
> > +                                val, nval) == val)
> > +                     break;
> > +     }
> > +     return nval == 0;
> > +}
>
> This should really be atomic_dec_if_positive, no?

SGTM, please send a patch, thank you.
