Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640E8C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Mar 2022 23:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiCKXsn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Mar 2022 18:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiCKXsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 18:48:40 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD8CCC6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 15:47:36 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id g17so17715846lfh.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 15:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wVfBYCR//sUPC/N8rtB6DbRqDvT5IMG4uBLF1VOm8zo=;
        b=cAbTBBPlJJ/7AzXk1OoklY8uNM71JSDbohwoInQlXciQI1dum0jpSWlLJFKfk5exao
         ApQPRfQ4M+fpaGM/Co1A3oeDWW1PNVf3JueYnuneNx/vHML5rn1q8wFyjetAh6loowGS
         6bJ2n5r5DcGI5IORwQ9dH4vsK72CesWtTPuyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wVfBYCR//sUPC/N8rtB6DbRqDvT5IMG4uBLF1VOm8zo=;
        b=rBwhY6UIgsjox/j/Ilo5aL2tRdrNzvnctJN6Frs990c/4SSQALcSWUb0MaGxczl6yI
         ZeVKFxxbmYLY7indsD0SlGGyj8DmT/OurwOUiaGp1u4yTkBjO1qjm6qL7T2iyf49cxWq
         X4S9Hr5Jh7GC/vaWbJZzCKltLVfJplD6jmEEgXeQ/iZNEpMPCrnMGveLC6vWfb56HRZJ
         A631LgrFspRYOrO4KfZsNqA5Fl0iMqHhtC2ApgjXdkU6JioO/drj5v/MNFZTmEfTmg3G
         tJlkfxd4DipkhbGlTaLGAEfag52kQvgcIUh8zwA+R1LkjsACFMy8mhrkGly0t5ZIBzBC
         ouAQ==
X-Gm-Message-State: AOAM530/xKArJso4zrs1jY5kIXsfp2ifFb8dp4+DiWf1QrD4WfX3KhnE
        7OIpOA6el3nSS53Nc57GTQOJOhFRmpBylV34PCo=
X-Google-Smtp-Source: ABdhPJwtMvyxvJjU2oNf6l2fqKGCe4J1SiSDZoDXEZ7sMYt+6i5Cmi8dTZmewI8W3qYhkoe7KyeMXg==
X-Received: by 2002:a05:6512:3f05:b0:443:bf88:aeba with SMTP id y5-20020a0565123f0500b00443bf88aebamr7314336lfa.561.1647042454543;
        Fri, 11 Mar 2022 15:47:34 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id v1-20020a2e6101000000b002480c4f33d5sm1423115ljb.132.2022.03.11.15.47.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 15:47:34 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id l12so14104598ljh.12
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 15:47:33 -0800 (PST)
X-Received: by 2002:a2e:924d:0:b0:246:370c:5618 with SMTP id
 v13-20020a2e924d000000b00246370c5618mr7279855ljg.358.1647042453752; Fri, 11
 Mar 2022 15:47:33 -0800 (PST)
MIME-Version: 1.0
References: <20220311013238.3387227-1-pobrn@protonmail.com>
 <20220311013238.3387227-2-pobrn@protonmail.com> <CAHk-=wjkqz42CNjDgWA9U3uNWa9GriqaCqqKciqm0sZUYjfLQg@mail.gmail.com>
 <CAHk-=wjF4d_v5t=ht_vCOHxNDoPvsBuK-2jiEBus-__oPZuPFQ@mail.gmail.com>
 <wKlkWvCGvBrBjshT6gHT23JY9kWImhFPmTKfZWtN5Bkv_OtIFHTy7thr5SAEL6sYDthMDth-rvFETX-gCZPPCb9t2bO1zilj0Q-OTTSbe00=@protonmail.com>
 <CAHk-=wg6PtRx9nBHVnrQkQkczGjXjO0E-oHXPPgPK_H+Nm=Czg@mail.gmail.com>
 <1D4riYxukWActDG6uXJOjvSq0GvTWaO4KZGVfqmX5RG_HGGjzgBb3srCUNRZqyPOzzNzVIrKRw0ktupkVs0DWQGTiZ1cSuWEcu5z3O1Pk4Y=@protonmail.com>
 <CAHk-=wioAxtdJJejq08N3J3t=Qe47Tnii4H0fiYdgDwc8fpZHg@mail.gmail.com>
In-Reply-To: <CAHk-=wioAxtdJJejq08N3J3t=Qe47Tnii4H0fiYdgDwc8fpZHg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 11 Mar 2022 15:47:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=whTbE6noPBJhYyU4DcGqi07kreatv86fcOfNX8KKbfo4Q@mail.gmail.com>
Message-ID: <CAHk-=whTbE6noPBJhYyU4DcGqi07kreatv86fcOfNX8KKbfo4Q@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/2] list: add type-safer list_head wrapper
To:     =?UTF-8?B?QmFybmFiw6FzIFDFkWN6ZQ==?= <pobrn@protonmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Xiaomeng Tong <xiam0nd.tong@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 3:45 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Yeah, not with the limitation that it only works on global list heads. [..]

"global" is the wrong word. Obviously it works on static list heads in
file - or even function - scope etc too. But you get what I'm saying..

            Linus
