Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BB2C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Mar 2022 22:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237766AbiCNWwr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Mar 2022 18:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiCNWwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 18:52:44 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF8F2A24A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 15:51:33 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id g26so33789096ybj.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 15:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NJxEzNz8cDXmPNIb7ZO4iOruYsITSdWvcyHQhgfB8NY=;
        b=xGM9HiqFHFAkuzy+dCxelH0gCUDPizOrQoz0XLmkGL0xS6ehTB2eAYnhBQ0Xq+j0l7
         bHMZTTQyBeGGjAnssGiuYWOv0dAcqu2tuFMg245KqD5DJB30oD/q8y8S+MMjnqBGDD3P
         f3BfrpZyVLDkVzIgNFP+q4TRQP3Ln5woKuBCyM8Ugz/Dzyqe278OT6El7na6N3z8BqBE
         zykae5aV4zWRmcaKfctlh4QQvB3RDSJIIcs01D57P23/WsSTP7K3piXxlttHxKRVlhEx
         GcJUFOv1ia3svnDUsJa+HRjsgONcZIipwiFUNlNPcpHeHI6BhUOkXH68Oe/CXGI1/1zA
         4DNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NJxEzNz8cDXmPNIb7ZO4iOruYsITSdWvcyHQhgfB8NY=;
        b=N7HWWIbloXmCDKuUANm4oJJgdZolyDGKmWmnuXpXq0XUNlF0iKf0wJTOtV2kOVkK0a
         DASB+ycjU08BTDnI4uuEB8fwmUquAPb3T+kGonMAAugG8qJ8HUsTvrd+ZStaN5mQx1+A
         uVGIdnt5YB/OsNN+lACshcxUAOT4uFRpKV4hzy3+WSW0USwDxa1ajkVCj0R47jkSdlAb
         xu0y6zquAHJK8E/M2tEm43DFSGOisSuqe6sr7D9pHfNpTrtsw0BgQBCDOM2rcHWc87xN
         g1u+F2n1R3aobLTdZrae9oqkknTHOqnKqhFPMwVsDI2kPrr1GfUNAcB03Zrbdfr0+WDV
         ZcUQ==
X-Gm-Message-State: AOAM533smvum6sRvGL33Rl3rcokPr4uJE8zOEGCULY55CguOmqBFOLum
        qnN+xd01YNa4fcCf0qb8WBhIy250zWgI9c5h5seb1p3+dqc=
X-Google-Smtp-Source: ABdhPJy0zMmFXCU0ZVfgsHKlOzLIjuG8pWsSWhnpvIosRmZ2aLCd9Cw9K5SJ0e0keok2B0Lk93tyJcRNiVsznEHZJcE=
X-Received: by 2002:a25:4e82:0:b0:633:68d7:b864 with SMTP id
 c124-20020a254e82000000b0063368d7b864mr2893134ybb.514.1647298293040; Mon, 14
 Mar 2022 15:51:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220311125518.31064-1-yuehaibing@huawei.com>
In-Reply-To: <20220311125518.31064-1-yuehaibing@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 14 Mar 2022 23:51:22 +0100
Message-ID: <CACRpkdbZ5gWOhCM6YA3E9BUx67P4Z3OQ0+QJ8gEJp9=6RgGbKA@mail.gmail.com>
Subject: Re: [PATCH -next] mfd: db8500-prcmu: Remove unused inline function
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     lee.jones@linaro.org, lukas.bulwahn@gmail.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 1:55 PM YueHaibing <yuehaibing@huawei.com> wrote:

> commit b0e846248de5 ("mfd: db8500-prcmu: Remove dead code for a non-existing config")
> left behind this, remove it.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
