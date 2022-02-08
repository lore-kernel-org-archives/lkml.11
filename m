Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9B2C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Feb 2022 22:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358045AbiBHW2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Feb 2022 17:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387020AbiBHVqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 16:46:45 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EF4C0612B8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 13:46:44 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id 10so512305plj.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 13:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eN+hmNONJyG0na16U/kNOjqhgqoQ8Ez+z5PohZnpZkE=;
        b=LNQPpQeD8iyN++3r8W02WPfs6uZofuPIvByExxMAWF0qDNj4IzqjIBr/W4NTXrsVCZ
         kjpNceWCbdR5x2EpmL07tmFDmI0wGT7HTbOEds+oWrY3xOrZ2BTS8NJq87UZu8DyVOpy
         LxcQj/f1C0APcdVz+CzaIwdimXcBaKvXCQsif+vwRxBmjLIiKvoR65m8+jsQjmx2wGmR
         R1wbVEKbYlrVxRC/jFnmTnULNV9KkWHChtx4i0Ir45fiLL52uRY8LKiwJ64/Mo2I+mZj
         ba7ar8tKS6y9kqQ8NJdQYOBNQYHls9d6zsJoXQGvy71lMsuUIUKxtup00ETxuIq/ep9n
         /Fbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eN+hmNONJyG0na16U/kNOjqhgqoQ8Ez+z5PohZnpZkE=;
        b=V5pxKlWFdX1T7N8I7FrxynIF9zchjZAsBa/IJpBs8m7rxvleUcgE8v3QrN+ayaV8SM
         7fVnvq3snm3MQeKlSWnPGs7M59DiJnEFZBD2KKV/94QfH8mmJOJ3jxQuzN1sPkA8zHTk
         PCQ3t2du1AvynYaafITel8RCsjovOlslzFcNmemeJFotrNDBd4ZUf/J9X6F1z7kRy+lD
         Qse8t6tXMw5E+ClnRMLZFVv9tDXX6MfyyUVE3ZTvPw21i82ml+HZoaC1zraf2NLk6kqN
         ngAdTnWcwFRSkuF3mlCnt5HpEEWDdCDthOy5NH8P3ZGavpBZjcZbO2R8TbpNyyYQDLyw
         BGvw==
X-Gm-Message-State: AOAM533I+4Yi/FoFvma/fxC5ylE0kg/qZHZeRodDsb9UpEEqnkXb2v8S
        dIs0Um0kofOgsAx0cIctmso1lfaaVP203r/3fVhmg6jeEU941VaO
X-Google-Smtp-Source: ABdhPJzU8YEy66gam05lnihXH2xqumQUZnJEaa4p6ds3bkY2fyLPDZAWJ4qmz8U1JK3UJhmcPIm38CMIVYxZyGLqMFA=
X-Received: by 2002:a17:903:187:: with SMTP id z7mr6391730plg.123.1644356803467;
 Tue, 08 Feb 2022 13:46:43 -0800 (PST)
MIME-Version: 1.0
References: <20220208040122.695258-1-davidgow@google.com> <20220208040122.695258-2-davidgow@google.com>
In-Reply-To: <20220208040122.695258-2-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 8 Feb 2022 16:46:32 -0500
Message-ID: <CAFd5g47dbWswjdidj-sGJczsCBe3cDG32SO-WEsjmR8HsB6aXA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] list: test: Add a test for list_is_head()
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
> list_is_head() was added recently[1], and didn't have a KUnit test. The
> implementation is trivial, so it's not a particularly exciting test, but
> it'd be nice to get back to full coverage of the list functions.
>
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/linux/list.h?id=0425473037db40d9e322631f2d4dc6ef51f97e88
>
> Signed-off-by: David Gow <davidgow@google.com>

Acked-by: Brendan Higgins <brendanhiggins@google.com>
