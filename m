Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF4BC433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Jul 2022 20:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbiGFUi4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Jul 2022 16:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233932AbiGFUiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 16:38:52 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA7A1A82E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 13:38:50 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id sb34so28983861ejc.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 13:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vZwr/3vScMTpIxRMv4WjBuRiSizQBnezajqPVx3a7e0=;
        b=Si4QPqbtDaLn6pEEQtLRwxF4fYosbpF3ECvovEmamZp6mRc+rAEE4GEuQ1GA75QJNL
         nT5vIiBeCYuWROYx7uLVrwrygeWtrzI4KqiAnNecy3vj45ZwRrP44UCSDGRJalFr35+v
         XGT4GZ5JqGMYJimhJwHqNQ2Hb+k3JYeZ+eifljoPOqgoPE8y/++uz/BePLXB2KueIs+r
         0kjqLOLNielZc+j0wai/ds7sORTK/n1ErXJZjzv1m/tPaFdA/noEhrGjQlWnOPGA+Kjr
         AMe9D/cmbU6GzFJ9kIeTDxrT/59ynOFSiotyLbC3mHfTujW4dRJK1o6Nb49Y/B9ETLha
         GO5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vZwr/3vScMTpIxRMv4WjBuRiSizQBnezajqPVx3a7e0=;
        b=waUaomSxTHs7kzQgne3moAjn5a3UMSFrR+g8pPFm5f+mYd3qul/Z0JDdciEELUxVZK
         ZhfHqi67Je2cE8GiUwxlolu69v1OwWN5y2BuD7T8rMoHFJTP2aOB0SAmoBg4Y1GoTKCU
         u98xLdwvzSHES7vjFfTbn3oCjSaDdhujWgMP7tD5YAYnBhqo/4hJEpB0BnhSTlKL7zEd
         WTrDRwwyRu/TO3JKzgweShz2aPEnzgPpX1GauhO3w0+9anB2jO8BcKwBybTH/jvmve6G
         XuJ9Yuv9ooCuJMO1EIoxWrQaBTTJYB1C5sTFFyjTdQe0UYk5A5o/Y5+q9Mc7aHK7tIjQ
         dQoQ==
X-Gm-Message-State: AJIora/ezqGvF9gd55Bzux9mUdPqM4n8cJgB685C4HSOigVxKEUkiMM/
        5HTeqGTC+F+WpGwp6jq/pYCixPQEFEAK7shkmFtRQQ==
X-Google-Smtp-Source: AGRyM1vxTeQHfdIzYEDhVghCJRnsbHpY4JGNvAe08IGkmOJUZpH5AMO7hQ2aFcT2bjUbbSyKueyvirg7NJR8Stdijos=
X-Received: by 2002:a17:906:5d04:b0:722:f46c:b891 with SMTP id
 g4-20020a1709065d0400b00722f46cb891mr42210274ejt.4.1657139929289; Wed, 06 Jul
 2022 13:38:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220627221446.82157-1-dlatypov@google.com> <20220627221446.82157-3-dlatypov@google.com>
In-Reply-To: <20220627221446.82157-3-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 6 Jul 2022 16:38:38 -0400
Message-ID: <CAFd5g45hnC81WHyOmU3Jd2Ov3-KZOZSSOfjPsptqkTfiK73MQA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] kunit: add coverage_uml.config to enable GCOV on UML
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 6:15 PM 'Daniel Latypov' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> Now that kunit.py's --kunitconfig is repeatable, let's create a file to
> hold the various options needed to enable coverage under UML.
>
> This can be used like so:
> $ ./tools/testing/kunit/kunit.py run \
>   --kunitconfig=tools/testing/kunit/configs/all_tests_uml.config \
>   --kunitconfig=tools/testing/kunit/configs/coverage_uml.config \
>   --make_options=CC=/usr/bin/gcc-6
>
> which on my system is enough to get coverage working [1].
>
> This is still a clunky command, but far better than before.
>
> [1] at the time of this commit, I get:
>   Overall coverage rate:
>     lines......: 11.6% (34112 of 295033 lines)
>     functions..: 15.3% (3721 of 24368 functions)
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
