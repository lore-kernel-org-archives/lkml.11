Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69119C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Jul 2022 21:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbiGFV1t (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Jul 2022 17:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbiGFV1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 17:27:47 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0011A066
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 14:27:46 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id r6so9415725edd.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 14:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Tj6PrPpaIEyuZSYsWcQ3kHXjsoTyUFljIfOsMOPkeb8=;
        b=VoD67/g4wcx3ZqegWOLmTAPDNt0vCmTDOcKAsTovNDDLJjX4sGIEd4rLXbuMG8f8QS
         qowxwiIXI2h5+IojbOy8tiCU+ZtQ9dICal1A2bUZ3Bw2wfdgZ2aJ/zb5YeyYH+XQsaec
         sGS88c6/TMTBdDlLKG74qcAO+9YMgIFzvoDUBUAewDYvsY+LsSbH3iyGIKUKWu+dz8nz
         7rVjpxPjTLL2KrhY13VTptSFcD/ZqlF/zKHM27tr4N3PvaohXXkF8aV+fTXB35aRJwUA
         s+35DpzUTxebCisylEB0YvVW92ZYhDpLFspne3/P3fMj5JZkss62OkfAUjDUu4ydG5Ge
         BYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Tj6PrPpaIEyuZSYsWcQ3kHXjsoTyUFljIfOsMOPkeb8=;
        b=m3JtBid3a8YqDQx5tTbOcsM7RFIQNI1AYX1bRLI4lSYapL9XEZP1oO37TzfJdH1+Ev
         eKIIzwxTo8ClcGSZRGLMuotK5ATq8yP76mYG8AJ9+FashqhiTBQUa67wZKJ95WsEACvP
         WjiAnGwvSDPUStsym8tKtMR9feTRdEJo63ULvzRNp0rgOLrwNlzfymMFZ79OI4PpHxt4
         tYeUExOsADSG5y6EpRZDmXnvYJrdWRuUTfV0WwJ8pS9gvkicoPwimbqgPftw1zt1y6s+
         Q2x4Vwn7at8wmZAvtOOcLqShTiYM0vH0aJ8NNEeVGHAecaeMC0V4hXEKvd9Bz0auk0jJ
         y3rw==
X-Gm-Message-State: AJIora9AwnhFXn0zBnTm4VprZBfGO+4xNpDzwPnBY1Z9tQ0tZ22NRgrb
        jIgmb6bqkvjccOEygVsI5RbQ/96xkWm0mfkJ688i4g==
X-Google-Smtp-Source: AGRyM1sOb0wafw4RknMdORC5uXRTW7YYPSH4t7G0U2alwcVcosx4pOuQh/thudmYfiMbUNGC2GBmABjafV48GA10lX8=
X-Received: by 2002:a05:6402:40c3:b0:439:6b72:483e with SMTP id
 z3-20020a05640240c300b004396b72483emr44400888edb.154.1657142865333; Wed, 06
 Jul 2022 14:27:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220628235812.2356160-1-davidgow@google.com>
In-Reply-To: <20220628235812.2356160-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 6 Jul 2022 17:27:33 -0400
Message-ID: <CAFd5g45A1akz+4rLLWT1Eugu2XnPKzKExN1hYrDEdaW4Cp6YAw@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: tool: Enable virtio/PCI by default on UML
To:     David Gow <davidgow@google.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 7:58 PM David Gow <davidgow@google.com> wrote:
>
> There are several tests which depend on PCI, and hence need a bunch of
> extra options to run under UML. This makes it awkward to give
> configuration instructions (whether in documentation, or as part of a
> .kunitconfig file), as two separate, incompatible sets of config options
> are required for UML and "most other architectures".
>
> For non-UML architectures, it's possible to add default kconfig options
> via the qemu_config python files, but there's no equivalent for UML. Add
> a new tools/testing/kunit/configs/arch_uml.config file containing extra
> kconfig options to use on UML.
>
> Tested-by: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>
> Reviewed-by: Daniel Latypov <dlatypov@google.com>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
