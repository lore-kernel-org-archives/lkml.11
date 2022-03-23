Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2850AC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Mar 2022 23:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346599AbiCWX6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Mar 2022 19:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240367AbiCWX6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 19:58:09 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD906E369
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 16:56:38 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id h1so3751812edj.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 16:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sr7J4vfXVHgXl/lrrjqeau5g6gjXQTlIBcP0OGTYE7A=;
        b=ofKf+l9lFhG9+K+rNIAmI2pVWAmDdvO4SuuOzCqfEAZh19RvYXvwX9dN95tGecz9zp
         cP8pKxJYxc+10Y5e867EQHrFkZoI0W/lkKNCZ22jgq5+fk7hymMoDNSvkSgDFiNd4Qun
         8EnP08Pyj0kFbpC9eeT56GLMozN6uPUtGMvI0Cux46JSg1m1N5N4aVl0JllB9T2V9bUi
         H4iUnV2Qh6X3qWJPn6VnVkmZyy3N85cKj5vluNr0HZvBS+O7hCdhHE2ezLM52r86H3hS
         I+CeIidoIprZIiKiPll0gmrJet47VYgoUbYlAnMqJEdRTMRE/sYUfMVKo2UlHfPHZrMb
         pviA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sr7J4vfXVHgXl/lrrjqeau5g6gjXQTlIBcP0OGTYE7A=;
        b=E26ao+mDLKXtMVHI9KPvTN2vfSI6bIrAJUzQUk4gG5ppOND2xlEBBfxtdCO0ux3S1o
         oKncFJwxZmFgBl5y/IEi+MChl2PgJ3AOzmDAupmVgFyB2k6gvzQbYFaLNP1GHai2WHBD
         f0NYxMZIKnA0gr1tuDZGvmPfOvWbTE/f0C3aM5zsCGdmHE0yIY63EqUrW78ZIJKFH8Rt
         RKKyj1Y2JSOA12tzGFaYU5++a/fxXkvnR2+stGQgkcelgL4NWo8rFS3/qBJ0UtLzJaXj
         buDa6O8uZMcYgJ03uLh3QdyJ0Ijecp7v4MO/kcOVdvc9XhzZ6g94ItUXSDJC6h4Clv09
         JK6Q==
X-Gm-Message-State: AOAM532HzD3tNodFTqjMFo11OSFQMXqi+YSqWpwzntN8tMBbFOuwf/RM
        VBIXQZbsC+16kxVQ30IH1eWzV+iM4JzD9fgUHnpeiw==
X-Google-Smtp-Source: ABdhPJyNvKik3+MBbQKpWReI26T9y3k0RGMXxOUvfjslYhOAJGNGwznYbZ1Rv7IrggHj0u9f9Sncg8BmrR7L9rtlmWQ=
X-Received: by 2002:a05:6402:1cc1:b0:413:2b12:fc49 with SMTP id
 ds1-20020a0564021cc100b004132b12fc49mr3463086edb.118.1648079797217; Wed, 23
 Mar 2022 16:56:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220318064959.3298768-1-davidgow@google.com>
In-Reply-To: <20220318064959.3298768-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 23 Mar 2022 19:56:26 -0400
Message-ID: <CAFd5g45V6P9ATGQ3kqkuFLNDB=_01gws8Ldr1kH3j+r0aSZ-Og@mail.gmail.com>
Subject: Re: [PATCH] kunit: Make kunit_remove_resource() idempotent
To:     David Gow <davidgow@google.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 2:50 AM David Gow <davidgow@google.com> wrote:
>
> The kunit_remove_resource() function is used to unlink a resource from
> the list of resources in the test, making it no longer show up in
> kunit_find_resource().
>
> However, this could lead to a race condition if two threads called
> kunit_remove_resource() on the same resource at the same time: the
> resource would be removed from the list twice (causing a crash at the
> second list_del()), and the refcount for the resource would be
> decremented twice (instead of once, for the reference held by the
> resource list).
>
> Fix both problems, the first by using list_del_init(), and the second by
> checking if the resource has already been removed using list_empty(),
> and only decrementing its refcount if it has not.
>
> Also add a KUnit test for the kunit_remove_resource() function which
> tests this behaviour.
>
> Reported-by: Daniel Latypov <dlatypov@google.com>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
