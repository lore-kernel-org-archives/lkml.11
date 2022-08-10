Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BCEC25B07
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Aug 2022 04:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbiHJEHx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Aug 2022 00:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbiHJEHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 00:07:01 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6F380F53
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 21:06:39 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id 66so13959954vse.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 21:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=qZm1fXghi6IF6e55IsqmlhKKwI7Wy4DqK9Waf6yQfN4=;
        b=MmIWB4RRpjdnR6kMlp6sNc8gWwxl2vsFSpKPuHg0Qy84HCHNtgsoeLFA2cR6JH/cMn
         nfSGlpH+8ny8oIru9QhKwYUpTilYDSV2AO1+qJmXUrgMSCjAEAvLD1UI71I2CCDoZ4P8
         k+MB1H1UywZsz8afKbok7yD0xUV5uOwTW/X4S0Zm0Dv3WcOd6IYghA53gFdVxozGoqzi
         85CLZ0eBdy6yVwlAV19jT14a2iL5VaqxRyJLPr5OkHP8yEiQGG8pExYhnj0vvWzg4lP8
         vlar8cAwjTTa/WoVTt6iwkRRkhkM7PxJDpKW9l/+ENXFw0PfX5zvP8BeKv9Xn4cCXBff
         UXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=qZm1fXghi6IF6e55IsqmlhKKwI7Wy4DqK9Waf6yQfN4=;
        b=KYehJwISUY5SLm9mIpbUhDJ5w1M+OLpGOEKl/ScZOs7Xc+bfFFxto1Ic6wUaJpFDYG
         XXc/Jww5FLd4yP/i4tbw22BB5YzDSL1pHKdokJobyPZK8kJxAcC8hsLbL/riGBnpwtxY
         pL3ax5thZLV2mVwOp20xCQX8Pc53R00yPXVlOuhkdtWsS6HG1AoEbnmKmKxJOzqm8kfz
         HFpzauBp5PsUP/uhQ8KQ41fO3KvTuxtL7gzNhzULFTLGq8bVQqmWGmsylhDitTfG8WsT
         zrTeLUJOx+ZMppH9X6l9yieKV+xyA9J6Dn3XWj1f/Qg8e5F1eemBW9lnSajvqwVe/2KP
         euGA==
X-Gm-Message-State: ACgBeo14eE3noM270xhH+fu0DtQAKJSgRrbkX6hhgw1OqLdMeMr+A8Zf
        Ynt0RbT3/YUHJZv7NwSipTBROr9LorIE9iy7rV5F5Q==
X-Google-Smtp-Source: AA6agR7l31iYYX+0wz5ghid7W2fHSEC0jzZ6Cx3x+wJwm2DkdzIuVubF3tFEg7fRyssYs8FOxM0R/kGcduo8bZal5c4=
X-Received: by 2002:a67:d21b:0:b0:388:4e12:eff9 with SMTP id
 y27-20020a67d21b000000b003884e12eff9mr10881883vsi.35.1660104398135; Tue, 09
 Aug 2022 21:06:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1660068429.git.sander@svanheule.net> <30d8882efedea697da20c27563050008d1569b9e.1660068429.git.sander@svanheule.net>
In-Reply-To: <30d8882efedea697da20c27563050008d1569b9e.1660068429.git.sander@svanheule.net>
From:   David Gow <davidgow@google.com>
Date:   Wed, 10 Aug 2022 12:06:27 +0800
Message-ID: <CABVgOSmcKHH2zcCbT-jzekFP8RFov4V0AFBsGjU9kXSy9pJ9HQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] lib/test_cpumask: drop cpu_possible_mask full test
To:     Sander Vanheule <sander@svanheule.net>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 2:09 AM Sander Vanheule <sander@svanheule.net> wrot=
e:
>
> cpu_possible_mask is not necessarily completely filled.  That means
> running a check on cpumask_full() doesn't make sense, so drop the test.
>
> Fixes: c41e8866c28c ("lib/test: introduce cpumask KUnit test suite")
> Link: https://lore.kernel.org/lkml/346cb279-8e75-24b0-7d12-9803f2b41c73@r=
iseup.net/
> Reported-by: Ma=C3=ADra Canal <mairacanal@riseup.net>
> Signed-off-by: Sander Vanheule <sander@svanheule.net>
> Cc: David Gow <davidgow@google.com>
> ---

Looks good to me. It'd maybe be worth noting _why_  cpu_possible_mask
is not always filled (i.e., that the number of available CPUs might
not match the maximum number of CPUs the kernel is built to support),
but it's probably not worth doing a new version of the patch series
just for that.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>  lib/test_cpumask.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/lib/test_cpumask.c b/lib/test_cpumask.c
> index a31a1622f1f6..4ebf9f5805f3 100644
> --- a/lib/test_cpumask.c
> +++ b/lib/test_cpumask.c
> @@ -54,7 +54,6 @@ static cpumask_t mask_all;
>  static void test_cpumask_weight(struct kunit *test)
>  {
>         KUNIT_EXPECT_TRUE(test, cpumask_empty(&mask_empty));
> -       KUNIT_EXPECT_TRUE(test, cpumask_full(cpu_possible_mask));
>         KUNIT_EXPECT_TRUE(test, cpumask_full(&mask_all));
>
>         KUNIT_EXPECT_EQ(test, 0, cpumask_weight(&mask_empty));
> --
> 2.37.1
>
