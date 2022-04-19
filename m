Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67297C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Apr 2022 21:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357611AbiDSV4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Apr 2022 17:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237570AbiDSV4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 17:56:34 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55EC3E0E1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 14:53:50 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-2f16645872fso86656917b3.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 14:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XMSaAwxjrjiNU3osIbQVVRSLlzO7/jouyNe34lSDVJw=;
        b=kAI9LaEhHQzB9C8LRXYvLx7AzwTC1CilCLFWUwNhegBjdSI8VYhgrRl31FAore9MBR
         LiPei2LuFfF1nxtcKoA0sB30YxgVacMITMOSyt913xPd2wxQDHwgM7sZiaYqMN012h+h
         jaOAKXIeDCd7KSe6iElTB+sOKWIfLBlgC9NG4C9fJjNNpGNqKfuWqEu7L7V/9lcVcXDH
         CcLelVAuzR4syJmPg8n7RtliwnJ8XrnCkoYG+6u7rlAkXKi+rzFVE5lIe7pr7vQv+0Yf
         IvYb7qb38BZvsas9+N9fo5pV2MvtcdJeHBMvpu+r01JEzoyrsj3l9xqeXjxM1ow15U3Q
         /o3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XMSaAwxjrjiNU3osIbQVVRSLlzO7/jouyNe34lSDVJw=;
        b=CUU/it1l1cZzujteU2SbyZWLeUWQgz3KN6oQpc13Y+uiDoOhUbxF4auFdmdRc8CNTh
         EGGIg/3t1yHjgXMqbJY54q/cu/QANEeQVcKGVzm7gkbADVgqjKh7/K0bJOQlHr51EE+9
         KNYbK8ADtZuXmh0kVHTHpGO/K0tofOkmcpbWV4YfkcSsHDCtdDOkOQLs6OJjEyzFZwu2
         QlOtbygPpxxS2tzAk0jW7MehgY5zESeK51saW9jF9aYN8HhVSDxzh6VDB/kFawE5Jn/U
         Nxs9PXtohZPl3PKzNqt6XIkHlc6PvMwBTcnWq7t3BTtiiYqBXzd3SlD9lWv+6WmoV4IA
         yssQ==
X-Gm-Message-State: AOAM5337l3jMo0EOvQAtvqqiancKHGzywvMXoE2uvSmop52WRpYZjnxH
        6iaI8l4tv/jBmbICCrRlkJdCiw7Z4utUgGtRLHfJDA==
X-Google-Smtp-Source: ABdhPJxLUQfrNE4OV5ZCsc+xOfrP2lvSC3nJxjsNYdmZ2zSGKKW1xN1z0ZGL1QAijqAvI8A4GYTYH2KxI6CSUWgAyAY=
X-Received: by 2002:a0d:ea46:0:b0:2ed:62f4:e23c with SMTP id
 t67-20020a0dea46000000b002ed62f4e23cmr17946391ywe.437.1650405230087; Tue, 19
 Apr 2022 14:53:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220415070710.220785-1-andrei.lalaev@emlid.com>
In-Reply-To: <20220415070710.220785-1-andrei.lalaev@emlid.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 19 Apr 2022 23:53:38 +0200
Message-ID: <CACRpkdYYA1CtSz_w8aioBC7FLgkEjO_Wk_XuL-LwLmpCouNfeQ@mail.gmail.com>
Subject: Re: [PATCH v2] gpiolib: of: fix bounds check for 'gpio-reserved-ranges'
To:     Andrei Lalaev <andrei.lalaev@emlid.com>
Cc:     brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 9:09 AM Andrei Lalaev <andrei.lalaev@emlid.com> wrote:

> Gpiolib interprets the elements of "gpio-reserved-ranges" as "start,size"
> because it clears "size" bits starting from the "start" bit in the according
> bitmap. So it has to use "greater" instead of "greater or equal" when performs
> bounds check to make sure that GPIOs are in the available range.
> Previous implementation skipped ranges that include the last GPIO in
> the range.
>
> Fixes: 726cb3ba4969 ("gpiolib: Support 'gpio-reserved-ranges' property")
> Signed-off-by: Andrei Lalaev <andrei.lalaev@emlid.com>

Nice patch!

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
