Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BC3C43334
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jun 2022 13:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347103AbiFONYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jun 2022 09:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245511AbiFONYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 09:24:10 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E753EAA8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 06:24:09 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id p13so20529971ybm.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 06:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UJ8iaI1pTv/YM131C86Mnpd2Cs7gpkRb4SNOR9/hNuU=;
        b=WWCVGdRbgpyX4JC60E1knSS/uwhU4ze16f8ZReamCR9o1Dj27V6VmZMuQI0hMSj+0y
         eDBfWai5XlZ5g9HKJQGi9zFmX1Lcf0EnLacnZJ6TWl0+rAOvpYZ5XDVPq9TIYXjNe+gD
         R++DrE91aVAzvH96TpvA5xZsdxzx5ipVAqsl/TlyBQZAkwgGYHerQaBqkkjpNKvGVKmS
         0oKtDdUJrgqGw6Cv5T2Umy7PFz9gFsCxJKLWpKwJ1jwxkYMgK5ScDDRTp0axuRfKkNzh
         ken5dnpzo4+0PznZJYM50eS8aRlVxZZKF00zFbrTkTa+r5LcHNPX9BM8eM2M0I0vZj6I
         gEkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UJ8iaI1pTv/YM131C86Mnpd2Cs7gpkRb4SNOR9/hNuU=;
        b=3BlFrgnFCBJaSkGMIQewLNlHi3z7AUqG8FVedOul/KMF2AV9ldg7zErAU6olsMydhs
         Foftl/RfNSGa9DJv79nk+WNotToKyur4jPlD5Vk5I0I6owDca5ung+Sygmt9J6GXDEki
         9uEqLDtAZA4JPrYLx9s+BY9kZoQR8BdvKmkPwwaYEcdpMj965Nh/VSI+/nlC69t9yqDK
         52mpeo9gE1Dtq4ms+gu1zHSqTZLpb19ICMGiD00bt1/pjtadUQscwtahT/j11Ojapm3m
         AyHJzJIBQbxd0PSr+M3xKJ329UmiXKdHWNCJNGEn2p24jrxkoyDKS6NxmFfpA5Bu2GTD
         grww==
X-Gm-Message-State: AJIora9bhzPPCsRM0AnOQBm7jiptfxkhqF25lGgHIJChiZC+j59YzqMm
        21VZkM6sRky9diMtar2KVyVOVB3BBivzZynn7l0nMA==
X-Google-Smtp-Source: AGRyM1t5vbN1VRN0wQ0bZrJ9w/qnK3EiTQYoQv3YAhndL7v5GPOVjr/01mLr9EMdHOiqE1S1jfQPtZw4XGNv/p3Uo5Y=
X-Received: by 2002:a25:8387:0:b0:664:7589:27b9 with SMTP id
 t7-20020a258387000000b00664758927b9mr10564795ybk.291.1655299449036; Wed, 15
 Jun 2022 06:24:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220530123425.689459-1-fparent@baylibre.com>
In-Reply-To: <20220530123425.689459-1-fparent@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 15 Jun 2022 15:23:57 +0200
Message-ID: <CACRpkdYZJUWb4TBJiZVK4SNeA2Njn6341FuDjdYsn-0_yCeRKg@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: mediatek: common: add quirk for broken
 set/clr modes
To:     Fabien Parent <fparent@baylibre.com>
Cc:     Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 2:35 PM Fabien Parent <fparent@baylibre.com> wrote:

> On MT8365, the SET/CLR of the mode is broken and some pin modes won't
> be set correctly. Add a quirk for such SoCs, so that instead of using
> the SET/CLR register use the main R/W register
> to read/update/write the modes.
>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>

What is the state of this patch set? I see changes are requested by
Angelo, are they being addressed?

Yours,
Linus Walleij
