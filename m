Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB08C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Jul 2022 19:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbiGFTEz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Jul 2022 15:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbiGFTEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 15:04:54 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0331C13D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 12:04:52 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id x10so13092113edd.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 12:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RpVINOwhIJDLPkWFfmecEMrBAY/JtV+X/OxUNnUb1uc=;
        b=YqFsues6nl+idg2S6qc4iVhmf+D30+s/ukTfMTVjPQ96tIcGIkgZ8ly8lSflVWVd4h
         afdOyHdGdN8eaOIo9hTrAEYRWjh4eddwvsx0Ai/Mw6xQ+LADSJkvq7oeE8eJDQ8CHPsP
         +UBRslkE67cTtWWcMM6o4Z8gbeIFAlsJovUJtqo9pC6iEGnnbYCOwoh2N1KaiyXsENv1
         Y8q4Quscme1itmmNbtf8bMg6QBhSYcv6Eqo5zKGiSyPeM7PA0LEy4IFmp7afGu3Uxc+M
         N3R93qll1Nl3ArTKf+SpcIjhxtZwjRq5UqyouV/tI7Iu0fQZzu1HBAJfGMhJc7Zyv6he
         E2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RpVINOwhIJDLPkWFfmecEMrBAY/JtV+X/OxUNnUb1uc=;
        b=LqpVu276rUBKkZdQYzEjpfvyqin5/nALyn/lH9RGQQM7mCppIPC81dXHyTzfxq7bC1
         WdkNv0h6rm8HJ/WpYGjaYUSR68rmjDwDGMZiDQcrwX0eIxgP9PuiQPLrK1LUA81QxktZ
         Nmsu8ZF4L0xV6+AsmTmoEyx52OPqYOMTN00kt2JjILzYDIKee845Welh3ZsOAAugO7Wj
         1vb7Ctm3DbnhwQfzh2AE2rYpq/dHmngV192vTcfv0pv2qcpQAMdmqZe6le1B0DylhFD6
         DMovZKikxiHVgYTFTFlpv+giWu2gSgyBuIYnzXJ8I6cbS0Uz4XWOPDiVA9l51RFuDEQk
         IhZA==
X-Gm-Message-State: AJIora8VfkooBHLV04AwujO8yvTcLwvX6/zRckeCTIW6rbqk8KJtYHAd
        8S4tn58MRQx0Fa70nvExtx+r6sDjo3chDaejMcJ4KA==
X-Google-Smtp-Source: AGRyM1s9YOu5OyncSBYZR1TC//xVZXRMvIF/mIhixYfTs/fiAZjvh3ZThKDdH4gwhZab3ML+9tJC1Q0u61TMhoLrfhs=
X-Received: by 2002:a05:6402:90a:b0:439:c144:24cd with SMTP id
 g10-20020a056402090a00b00439c14424cdmr33166874edz.209.1657134290842; Wed, 06
 Jul 2022 12:04:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220516194730.1546328-1-dlatypov@google.com> <20220516194730.1546328-2-dlatypov@google.com>
In-Reply-To: <20220516194730.1546328-2-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 6 Jul 2022 15:04:39 -0400
Message-ID: <CAFd5g44awYp3ZrPXXFxjs0KGUSb4h625Mrr7je1MT=absk17rg@mail.gmail.com>
Subject: Re: [PATCH 2/3] kunit: tool: redo how we construct and mock LinuxSourceTree
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 3:48 PM 'Daniel Latypov' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> Our main function currently has an optional `linux` argument which is
> used to by our unit tests to inject a mock.
> We currently have the same code copy-pasted several times to do
>   if not linux:
>     linux = MakeRealInstance(cli_args.foo, cli_args.bar, ...)
>
> But in python, dependency injection isn't necessary or idiomatic when we
> can just use mock.patch() to mock things out.
>
> This change
> 1. adds a helper to create a LinuxSourceTree from the cli_args
> 2. drops the `linux` parameter in favor of mocking the __init__ func.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
