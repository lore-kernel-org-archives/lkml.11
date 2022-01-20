Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A65C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jan 2022 12:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242345AbiATM3J (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jan 2022 07:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233774AbiATM3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 07:29:02 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC55DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 04:29:01 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id v124-20020a4a5a82000000b002e303ad3241so2252160ooa.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 04:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H6QsODldDl5vUgs0b13/9aR4jGe2tT2snE0u6JkjQn0=;
        b=bRYyD/20jPnVHwXJmaGTX2YCs+KqgLPib7Z/rbv0dldagVrFIPz+H41ONzcGaNucFo
         OQyzpSyQaLbKHpT/DKw0GYF4hbcmllmux8krdcoQ4lQf5jJasFMrlaSfcjz+nG8gtzLg
         hkPJqVsKb7hNA4diqJOApKL9/Uk1JtR7+zKzcKQbnzhii5ZFILXhHvFjHtZyHum17ljo
         iAzlFpRJccy6CeEre/amrfejwXnKnQR/fFqnGUYBNs8t0HQaqybTmmut/01DG2ue6q49
         fmWDwdNewwcebVTlhHZ/wNU8yfi80s+/+CKX+M3jl8DiGVIAlRD5OOS5u4yhlVxkTk+F
         TWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H6QsODldDl5vUgs0b13/9aR4jGe2tT2snE0u6JkjQn0=;
        b=EUcAs6UMaxP+w3xbCBlTjFoSM+LjHQ0bgnvPwijzWRPWnFDzvgNGxu/Qg+edt/yrRc
         swp6ehD4oVgXe2VCV1dXkwNR5J9K6U9qjfxtJfM3KydYgx1ZT/OYcC+/JzWCE7RFh7EO
         k//0qoaUMftC4BZmFvjSuqf9Na0hC8gXxML6eFZvifPpXdXFPKPyo39GvL42Bgtl99kg
         OcQqfnx4eAIgzhPmD/toS7u6OvBigrYsktudQ6CDJ97U/ToG8/e1ZvyUDdeHbR1sM4Mm
         CAuarZiB4KNPjxdmIJHT9H+Aq0JQOn6baGQ++Mrv9I5ELh60Z0G2xj4CFGYJnSM5+EWK
         nJgA==
X-Gm-Message-State: AOAM533Q9Nv9shFCe3sz6U/VfAmRqibMyo6UsgAr3RNE5O7FkGkHWENE
        Ufl8Gqs1U/KRPQc/qfj1oFexF9FOoOmiQtDYVvoMMiOEjJjquQ==
X-Google-Smtp-Source: ABdhPJwq+Q1G+48YsvpIZjULWllI1ZZq8IxUCv3NoC6RCpfoN12YDpvhjJHY2y/Fk/0gKRLrY7mIKHTWU2iTepMCcEw=
X-Received: by 2002:a4a:b4cb:: with SMTP id g11mr25861335ooo.46.1642681741170;
 Thu, 20 Jan 2022 04:29:01 -0800 (PST)
MIME-Version: 1.0
References: <20220116192611.19224-1-makvihas@gmail.com> <20220118150728.GJ1951@kadam>
In-Reply-To: <20220118150728.GJ1951@kadam>
From:   Vihas Mak <makvihas@gmail.com>
Date:   Thu, 20 Jan 2022 17:58:50 +0530
Message-ID: <CAH1kMwThGSp7v5BuPvRiY44i6TvLbK2an0iqGw-_r3RZYOADzQ@mail.gmail.com>
Subject: Re: [PATCH] staging: r8188eu: handle rtw_init_netdev_name() failure appropriately
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Larry.Finger@lwfinger.net, Phillip Potter <phil@philpotter.co.uk>,
        Greg KH <gregkh@linuxfoundation.org>, martin@kaiser.cx,
        straube.linux@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> This doesn't really fix the bug.  Better to re-write the error handling.
>> See my error handling guide here:

Thanks Dan for the guide. Will submit a v2 soon.

On Tue, Jan 18, 2022 at 8:37 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Mon, Jan 17, 2022 at 12:56:11AM +0530, Vihas Mak wrote:
> > rtw_init_netdev_name() calls dev_alloc_name() which allocates the name
> > for the device as per the given name format.
> > It returns a negative err code if the format is invalid. Currently the
> > name format is specified by the module parameter "ifname".
> > Warn the user if "ifname" is invalid.
> >
> > Signed-off-by: Vihas Mak <makvihas@gmail.com>
> > ---
>
> This doesn't really fix the bug.  Better to re-write the error handling.
> See my error handling guide here:
>
> https://lore.kernel.org/all/20210831084735.GL12231@kadam/
>
> regards,
> dan carpenter
>


-- 
Thanks,
Vihas
