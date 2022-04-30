Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF79BC433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Apr 2022 07:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382332AbiD3HwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Apr 2022 03:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382327AbiD3HwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 03:52:03 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA14212ACE
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 00:48:42 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id g20so11365020edw.6
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 00:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mZrRXivk2wHB6aP0PlOgj0l6NkbmTRIad+kjRkIeDR4=;
        b=okvLxUXU58ImUVPXvh6rNI6m4QzadLdDcLGXEGPUyv9KGiS2NPKYVe946bsjLYLXwv
         YRFTyVmLfH/YWVpfSLJK4i5y+WFUwqBvXi763VpFWdkSmcP9fozdztpG1pzrha91qisc
         mWE3DAhtx7dhBykXPoQj8qymxGRx1b6nrOZIsDI268dIx+JscS9dy7hMEPkqdRqKl6LA
         qyYV0Xl7k98kWbe2UhrKXN9VGuF6bAVp4vrgCKhkwo5wzZOODYVyK/4Bb7QjjGj54Uj6
         lu2AXLaKYRgnxKTaGfTszgLPOJcTjslJv+lTdPjocdIutm0pH6d1jg9vevfBxJ0d0QZO
         WRRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mZrRXivk2wHB6aP0PlOgj0l6NkbmTRIad+kjRkIeDR4=;
        b=1fTlVPl0a0O1MisDh9e87bj0WeSLgODQO+Dndc/tdilflq7GkKh1UjN/7SShScB8Tj
         0DRg6AZxrtmZozvrQyp+VJdC2miVpyDWqRsihkPFZTqeyADIGToEZ4RhARl52pqMjgUq
         BFaEPj26QOf7IHmtUFnpxrq5MUeMPR6ANHnBL/KFo/dDRou4XZvDFwQlF8EHxenidP8R
         yJmlateK90ngKclQCv5nGBIlGlpj7a2gqC/XhhkxXRzoxTf1FUlcAYTqGu+SnZn9zsi3
         K4HQWWdPzTOnuDWWxvnwf3hjFvVrc2qPbMs2sySd+YKedJOfs1gjdu8JYxVT3wd2pFYB
         UYgA==
X-Gm-Message-State: AOAM532msStTHWqD9oH99TOFbbEmYLAmqe9Cd3qLnoIjdx1Tjt1GPiGm
        lfHOwnYl2r1J+rhlWQ6hZFfZeOfrbYFJreXrytft2f+EPNw32w==
X-Google-Smtp-Source: ABdhPJwzeGHd2jm7gKak2ZQJ0e3UgigF3oGOwiQx6dA4Uc7lXFEf4b3PX+pR+6UCSCa/AaSigzQeaiDH5BqcKzALdNk=
X-Received: by 2002:a05:6402:1e8b:b0:41c:59f6:2c26 with SMTP id
 f11-20020a0564021e8b00b0041c59f62c26mr3397468edf.156.1651304921031; Sat, 30
 Apr 2022 00:48:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220429181259.622060-1-dlatypov@google.com> <20220429181259.622060-4-dlatypov@google.com>
In-Reply-To: <20220429181259.622060-4-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Sat, 30 Apr 2022 03:48:29 -0400
Message-ID: <CAFd5g45UDN52rDPbz7UU+4C8sh7Q-UwC_BCdNKs7J8aeRBco8A@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] kunit: fix debugfs code to use enum kunit_status,
 not bool
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 2:13 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> Commit 6d2426b2f258 ("kunit: Support skipped tests") switched to using
> `enum kunit_status` to track the result of running a test/suite since we
> now have more than just pass/fail.
>
> This callsite wasn't updated, silently converting to enum to a bool and
> then back.
>
> Fixes: 6d2426b2f258 ("kunit: Support skipped tests")
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
