Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E12C433FE
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Feb 2022 22:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386156AbiBHW0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Feb 2022 17:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387059AbiBHVwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 16:52:34 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA79C0612BC
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 13:52:33 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id c8-20020a17090a674800b001b91184b732so769139pjm.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 13:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oF9APPRJ/ryYYnUi5ZT4UJq5EKiXr72r0aUV7VfBKnI=;
        b=CpZTJJSQOLRjm4uqijf0Vsx5zxsoH6bnXQ8emDn9PUZt7U8wPv8N9YiD2y+OL+tDRl
         z2aCOzoKH9xyvthF44cnZDv2wKNpT1Q8xlA9/ZwcHkV3wj9yyd7bINISY2QpBme+gopl
         Xcrldm+HRy7AsOln2s/ra7CbL8FnGWPnQK0j2TuDTBG8dDLP3cYiopDpCbUJTVDf5Oqu
         QWUO6jhEnPfmC6N+z2ulz9yLUHSw7uNtodDSJENqk1JJVFka5q2YuTruDQaDfVx1VB1P
         PyvnF+8KJDvdzv02kZm60+ppbvZLrk9iWtHecQBH/fqvTYvvC5xmEn0GcrMgwHPLvnnP
         gUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oF9APPRJ/ryYYnUi5ZT4UJq5EKiXr72r0aUV7VfBKnI=;
        b=EhnozuuJ+UFOBxiKUcedS9Tc6Tk4hm1s1Q8E+RwFkE6Vzo29tju5dWK2r1YfKbPTXp
         OkwhGrbVIXdq0WurKMOc4MqAMf8Wup+iUr4bMyPsvjeN6vqNjfvylRMGBv6hHwRoaikF
         GYeg1xzaOSz2u+7+HZ2nuiEFMQXDvAGMIeJ29ohgSb/5r6ToKOPkqdVTgKW3Rb7dyATz
         oKCkklEJzi6fu3Cd+0Ggz+kTCU77mkfSjcr0GjUu8lUJxHpfK1YoBwJrkiiYZ1HD8fCq
         gu4kVplm1NeHDfaMSK/EZcTf/wqqfa8lNgPAhtlBNOru9jmbUFlbIgMq4peOo5cupmh/
         MNHA==
X-Gm-Message-State: AOAM5300DYiyLBi1LtK+gnYVjEdUPxaIDTukXjhk0IybIr7gMgKemz/m
        dN6w9RCJ0z4oFCNiFzgFT25NT+q0b+9bj0wCYdlI8Q==
X-Google-Smtp-Source: ABdhPJxKFoHcaxpXmt0vWEcKSbtTjxYXfUsMh/LAezwwBKC3wR/Rmjt+4C82kGDT45tMq9QeBrQh9n1Lp+ubO0UwRqM=
X-Received: by 2002:a17:902:e950:: with SMTP id b16mr6557875pll.12.1644357152864;
 Tue, 08 Feb 2022 13:52:32 -0800 (PST)
MIME-Version: 1.0
References: <20220208040122.695258-1-davidgow@google.com> <20220208040122.695258-3-davidgow@google.com>
In-Reply-To: <20220208040122.695258-3-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 8 Feb 2022 16:52:21 -0500
Message-ID: <CAFd5g44WdqfwJXa2PtyBj=NaXoReAgD2rHHOeHmmW=dPvjKABA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] list: test: Add a test for list_entry_is_head()
To:     David Gow <davidgow@google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Latypov <dlatypov@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 7, 2022 at 11:02 PM David Gow <davidgow@google.com> wrote:
>
> The list_entry_is_head() macro was added[1] after the list KUnit tests,
> so wasn't tested. Add a new KUnit test to complete the set.
>
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e130816164e244b692921de49771eeb28205152d
>
> Signed-off-by: David Gow <davidgow@google.com>

Acked-by: Brendan Higgins <brendanhiggins@google.com>
