Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D5FC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 21:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241026AbiDNVrA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 17:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241674AbiDNVqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 17:46:55 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C33DFAF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 14:44:27 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id n17so2727999ljc.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 14:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Hek4RZqzkIk1fdxlTyB0ChG7pMVQZDu+dlMopCeePEo=;
        b=mfZO6Euo7V0PTNbRIBdS8rHzWPkrMjWungRKEm/EWMdshAYbl6OHK+Q+oPKksm4zAr
         42bsM3pCnbTosBLDqqtdK1k1WES2zmeCD4L6T17yxnxvL2XsniikYEHK+wzfpEAs315M
         bl/q3TjtcIV1JuGB3oOLIQjXrIXrwhpUkAzv77hLiX4pfwDucJL9lh9tT7mT04aYTRkz
         KAVzLeJWeufsyVax51rF5xA3P9K6LdCsNykULIBw7qixblLTLHDqWcpgnvurFAsXU/Rr
         2J3BixMUCybcirG7yfymuqj3xrB1s+kEd8sLYwuoghriAe4IZaCdEbO9YyU8ZVAcHYGi
         phhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Hek4RZqzkIk1fdxlTyB0ChG7pMVQZDu+dlMopCeePEo=;
        b=uqCm4WY/voEP0TSv2M6uWGszJurqIostGp+NBCDFIzFmdpsAOO6g3p+ZJ7QqUev+Np
         UcWyEV4Ha+EygsTbxt3PmB5apqCkorDtrIrJvnxbBRW2ou/kDXngHsbtgXyiuy2OUZ0q
         oEXnDnVyFlpRyKruC7xUnueUcSLzadKPd3iQvpMj1rARz+RXpl5Xad8fsIghpPAWoQwP
         U/1s5V2/ksY4TUQEQiglGjX/1uElFDqc3L2MOR0ps7rmbM2TXdJuMdatKvnHpZ6TvGQY
         tyawyHz3AKrbi9aFTDD4+rTgOk6RZOs1ew87MJPwk9hHb4WB3OdAVf4uUSqilGnlTvcp
         WARQ==
X-Gm-Message-State: AOAM533bw+apHEymro9aBprldx1V/FcCpLAIEsDyd8OW1S1xiGi93RUi
        OzbafdkGOj6bHuS9EYvk1lkClFN+9Y/AwkfrGOkvvQ==
X-Google-Smtp-Source: ABdhPJzC1+ZRz24uKBYTn5bE4zz34jaaQE1S4J9EGwA53RxyKlVHjVQxyet1IHf3CWLS/GmzvKrjDaE5u6EqH6mYJK0=
X-Received: by 2002:a05:651c:1185:b0:24d:a008:46f0 with SMTP id
 w5-20020a05651c118500b0024da00846f0mr1842748ljo.408.1649972665591; Thu, 14
 Apr 2022 14:44:25 -0700 (PDT)
MIME-Version: 1.0
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 14 Apr 2022 14:44:13 -0700
Message-ID: <CAKwvOdmumch3vnv_qL7m+h1szDgbFZj-ATrufvKKR8i-8jdkAQ@mail.gmail.com>
Subject: kernel.org binaries and sysroots
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     "Jose E. Marchesi" <jemarch@gnu.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Saleem Abdulrasool <compnerd@compnerd.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,
Jose and I are currently in the planning process to put together a
Kernel+Toolchain microconference track at Linux Plumbers Conference
this year (Sept 12-14) in Dublin, Ireland.

I was curious if you (or others) would find it worthwhile to carve out
time to discuss further kernel.org binaries (and potentially even
sysroots) at such a Kernel+Toolchain MC?
-- 
Thanks,
~Nick Desaulniers
