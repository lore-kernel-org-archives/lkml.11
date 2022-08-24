Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B95C32796
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Aug 2022 18:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240008AbiHXSHf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Aug 2022 14:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240373AbiHXSHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 14:07:33 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B386BCC1;
        Wed, 24 Aug 2022 11:07:33 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id o13so5084111ilt.3;
        Wed, 24 Aug 2022 11:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=n6VLsvWXIz4UjtHlsmuUC9VbAunQhpMZsf7gkqqQZ2Y=;
        b=faDH/HocgmiiUZY09EKlXYCW1XuMalpCM2E3GILA4rvtRzE8DS5T7K0CD6GHLX9ayy
         ayLhx6PEn1Bho8YSpGR6NiXGoYu0DzMS8gHaXWAEvfB7rMzBCpxtT6bLUKW9T806sFRp
         eln1H6Xt6A2Am9jEIPcTdR8/E0TkDvPZIWdUT8Uvb3fDFQvokCnQNplgIegXgRFkF1f5
         wc1af73fVLrdAfoxo7GWRz8+/3XmHiXw/1diHj8FGQp1lJI+cU1CCtzbCrzP80m4DfFk
         yxwVJTmChD8B8Phyv47IFU//4RHqu7UZubLSZ3jjk2O38eT67cqV28GjB7Qecgzzifaz
         r2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=n6VLsvWXIz4UjtHlsmuUC9VbAunQhpMZsf7gkqqQZ2Y=;
        b=COxHnxoS7aPqnZn7SvoyvK1QcJPQe68UoKGK8Tq50slUqB/aTrKDomOaKLgw1le55d
         PHgcitOPFB7NZ3ZZ0TY5BqX14/jL3VcgAhntCB4EhUdKV9LMBkkXBBlaNXVQJqLDdjZa
         UWaTUjFhyGhWs6zcOjWmVmcu8Va50akvontkrmPmtSQ+LS4EzT66QouuKa+MteeL511G
         gOrxm67yTkqnQzL9o75OVj3ZC4Ze2whsaoarJzLvEonmhU6uXZAlfiAXiRzE7LhzoEUf
         BX9zQFmh5EVOB7OsMGwaWIb9ISHyJ80eJefdGNRUWDFGBE1jP6xwGEI7/HV/GdNcyROE
         YvNA==
X-Gm-Message-State: ACgBeo08X6c8S/7ubMoIboBENgG6P21AToPJyaFZO0+7jgFjDgma0RjF
        gMDXwwNj7C/io0LEPATEu+3KTrnVvC86r4qEDNqblA5USLE=
X-Google-Smtp-Source: AA6agR7RlBHQbobnbPFqBFroqbpCV4A75VEHEvpnsT0oRzEEXEX0TD4FmvwEHuVA+Kl3BAWYsdsyC3JLx0a4XAZ1ods=
X-Received: by 2002:a05:6e02:20c1:b0:2e9:f747:ad54 with SMTP id
 1-20020a056e0220c100b002e9f747ad54mr141644ilq.144.1661364452449; Wed, 24 Aug
 2022 11:07:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220823182758.13401-1-khalid.masum.92@gmail.com>
 <20220823182758.13401-2-khalid.masum.92@gmail.com> <YwU2vp0FSR5dS/FX@rowland.harvard.edu>
 <CAABMjtH7q2evZ4R7FGC8m3a716ec9+e8+KdmrvnqB4_r6rF2Jg@mail.gmail.com> <YwY3yHB/Ia+cPa1L@rowland.harvard.edu>
In-Reply-To: <YwY3yHB/Ia+cPa1L@rowland.harvard.edu>
From:   Khalid Masum <khalid.masum.92@gmail.com>
Date:   Thu, 25 Aug 2022 00:07:21 +0600
Message-ID: <CAABMjtE96E78YgVe3Psba-5G+ELTXWFgGuUWWeb-o06iJHOi6w@mail.gmail.com>
Subject: Re: [PATCH 1/2] usb: ehci: Prevent possible modulo by zero
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The usb_maxpacket() routine does a two-step computation.  First, it
> looks up the endpoint number in the pipe to get a usb_host_endpoint
> pointer, and then it uses the pointer to get the maxpacket value.
> Coverity complained that the lookup in the first step can fail, and that
> is in fact true: If there is an interface or configuration change before
> usb_maxpacket() is called, the endpoint number table can change and the
> lookup may fail.
>
> But it turns out the first step isn't needed here at all, since the
> endpoint pointer is already stored in the URB (by the code in

That makes sense. Thanks for explaining.
> usb_submit_urb() that I pointed out earlier).  So an appropriate way to
> fix the problem is to carry out just the second step:
>
> -       maxpacket = usb_maxpacket(urb->dev, urb->pipe);
> +       maxpacket = usb_endpoint_maxp(&urb->ep->desc);
>
> This holds for both of your patches.

Got you.
>
> Alan Stern

-- Khalid Masum
