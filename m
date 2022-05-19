Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464F4C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 19 May 2022 00:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbiESALN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 May 2022 20:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiESALK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 20:11:10 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18CF3465C
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 17:11:09 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id f9so6942710ejc.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 17:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vsD2gYKrmncZIFDAn8aAbR7fYyev8iCUSUiE3JDCdXU=;
        b=P0jtfwqAMPHT2xnb4oXs4LhGOxLbgS997dRSMqdpa8FJC5k/GFSAVU9Yc2/LmG/j8n
         rh/DxTEiJMcGLKUFwMTf05V0C5sDCGHBiVi0EUYUET3Nogln1aE30E8MC5f/LzjQLWPe
         FdrP0JqfJxp2uDiy6tmn3Xwvfzfk0HItC5DFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vsD2gYKrmncZIFDAn8aAbR7fYyev8iCUSUiE3JDCdXU=;
        b=gd63WqOCEu5/2aIdWi2XTWT+WdOSVJoaLQZayLgAhZjYBV8lh2uTB+6FjvAvbrKvOI
         q17PDS2fflq8zroVpYP4I0ZbcpYiRvKmJnYGbwNKvekAfQk/A8twcIYt7rxB2Jfytjfb
         Hlp3KKTzV8lPJlLD3ZbKopBYOiZ7uqqDPbaFmggNUmWho3BpnTkbEDcAsGdL6tFt5YHt
         iDI16U1mvkjs73iLOGhxulESBT98bIJCL4jpfx+kl7KiwlMgtHar/1Bf/hMb58u4/raE
         K3AUC3hZMMYJJZwCCOODySQagKs774rsnuJwf3FQhkXhmzGAjjIoLGLoVcMr15IfiFJ1
         duhQ==
X-Gm-Message-State: AOAM533iRuLhlSTUeR1ktU3MdN7qyCL/wDzB5hfvOyAoaWQSjbJU7/It
        qB4I9MY7UoS4aLuwB54KJiqpSFyUMIIj2lni
X-Google-Smtp-Source: ABdhPJw3ByHYUv8NbxTBAwpxcZb+DsmhYpkiOzQCfXo7XS+eOltSiZ9pPA1hHJ77hQnnwrpqTZgwqg==
X-Received: by 2002:a17:906:a219:b0:6e4:86a3:44ea with SMTP id r25-20020a170906a21900b006e486a344eamr1910587ejy.385.1652919068208;
        Wed, 18 May 2022 17:11:08 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id ml16-20020a170906cc1000b006f3ef214e23sm1485277ejb.137.2022.05.18.17.11.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 17:11:07 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id r30so4839476wra.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 17:11:07 -0700 (PDT)
X-Received: by 2002:adf:ec08:0:b0:20a:d39d:6ab6 with SMTP id
 x8-20020adfec08000000b0020ad39d6ab6mr1650614wrn.442.1652919066859; Wed, 18
 May 2022 17:11:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a3V3voFgDz+yQji9PpVNs=QOj8MEtdaFf1U3JrLSG6SmQ@mail.gmail.com>
In-Reply-To: <CAK8P3a3V3voFgDz+yQji9PpVNs=QOj8MEtdaFf1U3JrLSG6SmQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 May 2022 14:10:50 -1000
X-Gmail-Original-Message-ID: <CAHk-=whdu=QVt=_rviX-5-txb4haxNW-zTc8cFpjsjsemt72QA@mail.gmail.com>
Message-ID: <CAHk-=whdu=QVt=_rviX-5-txb4haxNW-zTc8cFpjsjsemt72QA@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: SoC fixes for v5.18, part 4
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 7:19 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> I'm sorry for the lack of a signed tag this time, I'm travelling at
> the moment and
> forgot to tag it first. The top commit in the branch is tagged with my
> usual key,
> and I can send the signed tag when I'm back on Saturday if you prefer to wait.

I've tried to encourage everybody to use signed tags, but for
kernel.org pulls it's not like it's a hard requirement, so no worries.

               Linus
