Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465FAC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Mar 2022 23:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241574AbiCWXyX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Mar 2022 19:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbiCWXyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 19:54:18 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117D3403EB
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 16:52:48 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a8so5945097ejc.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 16:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j9PW9Nmnmr8RhfFTGsfhk5R8Ok1BoFEzWy/OLdaXZC8=;
        b=rkRQcr0d4T7zR/olQuh3T4SdIaLIAkHjZGpFRFEb708iY/NkXbWAL8EcHV49uIe4ld
         seQzgeMdW6imJGSyWfIa3pZv7elk2l3u6sipIZVVcSVd1mCfmVUHz4c5TE1yhqQZSeuX
         BafityQ00e8cWUUJYFcWsFVmI3i/rlfE1lfxEknZ+KtzVZpze3YprOlNI0kULaxgfp9m
         UQ0+Ad53FCIwNNmymP0IByTH1X+L1XW1OBnmbi7uCXlfgy4oOPXqEPX8jRbWCfB6q4vi
         vGUV8EWGPkS/OgbHP5Cife+cgyR4Ms1DKEWDSORi1/ueTOQnhyaaNGgy7DNtWq4z2cx0
         eJ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j9PW9Nmnmr8RhfFTGsfhk5R8Ok1BoFEzWy/OLdaXZC8=;
        b=00s0ZFhqpNDoW09AJrTj8kCiOwPcDtlLRkvV8wMF5AIm3P1fbnP3BwM+uiUNNZieAl
         qnaXqVWcZJcFBD0rUWmtzhmH9999iepsRYKm+7KSqTDlMS8FNrNVhYPzh2Z5rNW1d0i/
         j4y3byC61qLIYZ1R4E/S6qxOBgkLNwnUfzQMMIk64Ycz+/NAEDSoIqp/yNVZFEiPD8LW
         KsMpFDluIm07wA9FHS0svmU27aTs6OGh4FPeKscVx1ujv8DAbmMfsCYpAp5hoichGyV4
         0mJumVneIX7PPUbrw3M18pLHTdOTwjCfPqKb47FHV2v8JFv6AdodJzU86EYAmSooNsi6
         PmcQ==
X-Gm-Message-State: AOAM531/qxpy30tM6Gv1Rhg1I0AJ4QmxtMi7H0/dlOLvhHkMKhOqSBty
        5RJb/LB9kGW2RzhhnGHOH3JEWyOoXTrcZ4gtlT2leg==
X-Google-Smtp-Source: ABdhPJyPYDcIfFcE3a+3ekD9mUX6WYtGpKh6FSzIJcg5D0H3fkbHAyxgBOC6MCU+xA/BmEC9TO2X25SAfOx3KdqGxwE=
X-Received: by 2002:a17:907:c018:b0:6df:e31b:d912 with SMTP id
 ss24-20020a170907c01800b006dfe31bd912mr2861056ejc.196.1648079566471; Wed, 23
 Mar 2022 16:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220316024432.1454366-1-dlatypov@google.com>
In-Reply-To: <20220316024432.1454366-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 23 Mar 2022 19:52:35 -0400
Message-ID: <CAFd5g44hMjdy9u-m-StRe8UyJPdKkft3i5yn8ciuVHxU3KSSLQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: split resource API from test.h into new resource.h
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 10:44 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> Background:
> Currently, a reader looking at kunit/test.h will find the file is quite
> long, and the first meaty comment is a doc comment about struct
> kunit_resource.
>
> Most users will not ever use the KUnit resource API directly.
> They'll use kunit_kmalloc() and friends, or decide it's simpler to do
> cleanups via labels (it often can be) instead of figuring out how to use
> the API.
>
> It's also logically separate from everything else in test.h.
> Removing it from the file doesn't cause any compilation errors (since
> struct kunit has `struct list_head resources` to store them).
>
> This commit:
> Let's move it into a kunit/resource.h file and give it a separate page
> in the docs, kunit/api/resource.rst.
>
> We include resource.h at the bottom of test.h since
> * don't want to force existing users to add a new include if they use the API
> * it accesses `lock` inside `struct kunit` in a inline func
>   * so we can't just forward declare, and the alternatives require
>     uninlining the func, adding hepers to lock/unlock, or other more
>     invasive changes.
>
> Now the first big comment in test.h is about kunit_case, which is a lot
> more relevant to what a new user wants to know.
>
> A side effect of this is git blame won't properly track history by
> default, users need to run
> $ git blame -L ,1 -C17 include/kunit/resource.h
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Aside from the discussion below,

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
