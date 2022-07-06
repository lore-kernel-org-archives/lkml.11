Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0BACCA47C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Jul 2022 20:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbiGFUWf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Jul 2022 16:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiGFUWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 16:22:34 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D9F20F77
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 13:22:33 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id q6so28929407eji.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 13:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s/tKQNx7+nrPdH0yxzOZpF+/pY4bKPXut4ezANEyBGU=;
        b=oMOR51YGtPRJu9Q618/bSPmTNM5Kc8blSenFvdaztyvAeDeRRgmQqg32+u66QqI1hQ
         u/Svp9qcKsF7uxGLBv8+rfPpgqTW4lAhrg99nwwrefEfCm4zxEgyMf5m4l0dSUovqsDq
         BpDYuZr5FNGFCKsHvYz8qq4a8zYEiM+G6wVcc1YxsYPP+iGOnFo1y2zofhTZwERrGT7Q
         1EowSTKxLPrkeT4815mrstyDFTrmzDMB8WqUYhVisDiIOHfh5RBNq3xnCcIf6ZWx/GMp
         9SqYWYq7UV5GHAX+QquxVXWhfc0AttthcTH/vhBgZ2ujlsa/QXICbiJG8FOUqCMMK2qt
         qWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s/tKQNx7+nrPdH0yxzOZpF+/pY4bKPXut4ezANEyBGU=;
        b=gYZw7SurUo3C0QqeVrm2Qkb+OqWBJjWBXqaCKWUbT//Cy/TfZfKVpJDdSIqkHLm7ng
         8dOjxCYXpOHwF2JHt5gWa/c8BNmp2OYg7+GZ5NyoAIaN/9pgbwy2P/ThatXf5Q9+AXXM
         o7qFzLPOfjfVjMLHG9W/22qjPY/WQS0gp09bB7pYAVlPsBEwIU7NFSMdKUsvqZQ+//wH
         Kq8sp3iU0BbCM6QCij48kADf/MEyJLjw4K0hewIumSGzQmrS28W99ubmlek+bIA1QYDQ
         j/qWRgh867MXR83CUYEFwvuAc7OgHm1uCE4SUnZ3c/4O48kLsVZs3jjgzmjsJidoAHen
         gpMQ==
X-Gm-Message-State: AJIora9gzRzUxGoG+YK/rEU+RQQlCrB2F331qwKFJciaJmf2sMq5Lihe
        STdqLkigV/0wM33uKYdqZoMap7THXxTKZpAUFs/d1m4RUq/IDGYw
X-Google-Smtp-Source: AGRyM1uLPe2jm00lXplPCQ5WhZMfM1wnXI+YNyu+WftgYpoP9HK2pylmt+XGiT91HpbsZdtGFcE0BaK//qEDAc8kc1w=
X-Received: by 2002:a17:906:cc96:b0:728:baf0:ba03 with SMTP id
 oq22-20020a170906cc9600b00728baf0ba03mr40255410ejb.52.1657138951883; Wed, 06
 Jul 2022 13:22:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220627221446.82157-1-dlatypov@google.com>
In-Reply-To: <20220627221446.82157-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 6 Jul 2022 16:22:20 -0400
Message-ID: <CAFd5g453WqsP49HVpD6zT3181xFhwbXFmodPPZwQriWcbnjZXQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] kunit: tool: refactor internal kconfig handling,
 allow overriding
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 6:14 PM 'Daniel Latypov' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> Currently, you cannot ovewrwrite what's in your kunitconfig via
> --kconfig_add.
> Nor can you override something in a qemu_config via either means.
>
> This patch makes it so we have this level of priority
> * --kconfig_add
> * kunitconfig file (the default or the one from --kunitconfig)
> * qemu_config
>
> The rationale for this order is that the more "dynamic" sources of
> kconfig options should take priority.
>
> --kconfig_add is obviously the most dynamic.
> And for kunitconfig, users probably tweak the file manually or specify
> --kunitconfig more often than they delve into qemu_config python files.
>
> And internally, we convert the kconfigs from a python list into a set or
> dict fairly often. We should just use a dict internally.
> We exposed the set transform in the past since we didn't define __eq__,
> so also take the chance to shore up the kunit_kconfig.Kconfig interface.
>
> Example
> =======
>
> Let's consider the unrealistic example where someone would want to
> disable CONFIG_KUNIT.
> I.e. they run
> $ ./tools/testing/kunit/kunit.py config --kconfig_add=CONFIG_KUNIT=n
>
> Before
> ------
> We'd write the following
> > # CONFIG_KUNIT is not set
> > CONFIG_KUNIT_ALL_TESTS=y
> > CONFIG_KUNIT_TEST=y
> > CONFIG_KUNIT=y
> > CONFIG_KUNIT_EXAMPLE_TEST=y
>
> And we'd error out with
> > ERROR:root:Not all Kconfig options selected in kunitconfig were in the generated .config.
> > This is probably due to unsatisfied dependencies.
> > Missing: # CONFIG_KUNIT is not set
>
> After
> -----
> We'd write the following
> > # CONFIG_KUNIT is not set
> > CONFIG_KUNIT_TEST=y
> > CONFIG_KUNIT_ALL_TESTS=y
> > CONFIG_KUNIT_EXAMPLE_TEST=y
>
> And we'd error out with
> > ERROR:root:Not all Kconfig options selected in kunitconfig were in the generated .config.
> > This is probably due to unsatisfied dependencies.
> > Missing: CONFIG_KUNIT_EXAMPLE_TEST=y, CONFIG_KUNIT_TEST=y, CONFIG_KUNIT_ALL_TESTS=y
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
