Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD95C0502A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Aug 2022 20:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbiH3USi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Aug 2022 16:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbiH3US2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 16:18:28 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91365286C3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 13:18:24 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id p7so5942630lfu.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 13:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=1yeP3DjVWaMGF9lHlaP/DrKMq/Tp9AtHGNc7ptmf5YA=;
        b=CVPzEkz5uPI8rDre+RUzmevOwuldj7MWQUhT749lZ0N2Tv8G+sg/fIPVM+Zs6FKpWa
         drrtDv3XsftxYHApfXVOwWowWUlQj3eVEY3Q6fepbpIKIV07GtgLdZgKcb6TRRL6auBu
         Rq9Gy61LL2U9VHkNyUjdNl160fz/KcwQY2Siw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=1yeP3DjVWaMGF9lHlaP/DrKMq/Tp9AtHGNc7ptmf5YA=;
        b=QVMKluL2DMJkfo1sq/yUZ/aTY05G2wOcIQ+nCMxS54G9Yh9kY1d6qwWw7AnP1kb6ZC
         AajcgBSSrKJFl4AmMCRdLJQ1kW8ChUW73SKuaOAUju8mHGyJrL8Mcn8n27m2axJkGGfY
         Y9FStNgm9gIYlVHFRC5F2S5bbBV+/sMrQz/qJwDThRLX9MXQyW2D8N4gIPqJjIn4AfmK
         z/AsZFm7DDOAqn0gOcKWzsxABEPxtJyMh0eqVOE4XdNLeumb/YaYp9yRWywq6ZO3ebO6
         NSW1MKGtqk2bVs2V2AH56M5dTc49xrm5frLE1162dZAFE0LG0TQ8yb2YiRblfkG5mAie
         tm3A==
X-Gm-Message-State: ACgBeo1M0LTAVJpzcq6wjRH9DGoRitGTj5u6polFQcAisjE/j2AYhApB
        M0fJG3lRHHTJ0XeeCqh2Ve6ivX4BmxTZnQ==
X-Google-Smtp-Source: AA6agR7TpR9bu7YNulTD94Bi03voOoPkabf8AG9/Et8pIwfW9dVKVB3zfa+8sWCwO5ASbg4suBLUSQ==
X-Received: by 2002:a05:6512:22d4:b0:494:839a:9449 with SMTP id g20-20020a05651222d400b00494839a9449mr562368lfu.10.1661890702693;
        Tue, 30 Aug 2022 13:18:22 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id be43-20020a056512252b00b004946e727118sm715875lfb.88.2022.08.30.13.18.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 13:18:21 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id q16so12546250ljp.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 13:18:21 -0700 (PDT)
X-Received: by 2002:a05:651c:241:b0:25e:65bd:3a8a with SMTP id
 x1-20020a05651c024100b0025e65bd3a8amr7863518ljn.206.1661890700872; Tue, 30
 Aug 2022 13:18:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220830123231.1.I98d30623f13b785ca77094d0c0fd4339550553b6@changeid>
 <CAD=FV=XO++XMrdZmupY8ED97W6AaU=H=sB2PN=6EpRxOOo4Afw@mail.gmail.com>
In-Reply-To: <CAD=FV=XO++XMrdZmupY8ED97W6AaU=H=sB2PN=6EpRxOOo4Afw@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 30 Aug 2022 13:18:09 -0700
X-Gmail-Original-Message-ID: <CA+ASDXO_iqH8pPmPPH2=3RWVVDKa2XYLNEp4P=1r+b4=VsxNHw@mail.gmail.com>
Message-ID: <CA+ASDXO_iqH8pPmPPH2=3RWVVDKa2XYLNEp4P=1r+b4=VsxNHw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Set RK3399-Gru PCLK_EDP to 24 MHz
To:     Doug Anderson <dianders@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, zain wang <wzz@rock-chips.com>,
        Lin Huang <hl@rock-chips.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 12:51 PM Doug Anderson <dianders@chromium.org> wrote:
> nit: Sinze zain wang's SoB is first then I think either the patch
> needs to be "From" zain wang or you need some different tagging, like
> Co-Developed-by or something.

Urgh, I think I did a conflicting combination of --reedit-message= and
--reset-author when cherry-picking / rewriting. Fixed for v2.

> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Thanks!
