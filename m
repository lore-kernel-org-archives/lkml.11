Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13304C00144
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Aug 2022 17:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbiHARkt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Aug 2022 13:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbiHARkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 13:40:47 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CE81AD8A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 10:40:46 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id b16so7210282edd.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 10:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vbpx09H/4ML4u2iqIVxYYiqngYD2A2VgzUmI+xUdR/g=;
        b=dGQn9HnPGK3V1zgMzL54wYJj48O6+9iWDlARc+RljqL77xZfEerkvBhksT+ve5EwpC
         M2uXbCMlaH2tZeawaZGAUY5wipiuA1s4tSZN8fbovQSH26yXFtaOn/PRxBu+n2J1G7Ps
         MO6Mw94atIhopWJpxYxghaE4v4V9IPXuXAH8HKNyjt7JbkNPNvyczcLycm9hcfP9ifff
         birOVIjltPVIXgLvWMliruGleakB5H7NGTStUH7QiSQygpVazbKSlBboi4CAiE+aoxiV
         GqI+jGedwMaZ0Q6Ou1GTe0oQop7PbOCj08AAcECuv/6IINrAMTRJ5qOivzI4ViLgQgCr
         Xicw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vbpx09H/4ML4u2iqIVxYYiqngYD2A2VgzUmI+xUdR/g=;
        b=6eKaOBjG6CxfR66nn0yNQ5vLKIgAdMAt1Fu1xurlW1qjRxjI/GLA7+gv585g48JgSA
         pMIxx62w/hWylJmel9+L8/uUWKAQKTSxpdoLuGss9EuiMoTUcM/pLOeRgbk6QfgQMJEv
         qMhtDGgtnyifSBVUaeZ/8FiItr/WbAqR4O9OsBozriql5Yi71APz/gXtzYLHgKS2teh7
         1KedBb4DVVMrTHkSnDaOa3M2uH+hrRHPcMs2iKRdllZIk1NhSsjOz+3cbCWKRad+ZhZR
         oOEAcMuosejmlj48NxEyAJ4aFMaYSw+8mI9Wbpujt+7S8Av/Xq+oJfnuFO4Im7yjLGZb
         ZUgQ==
X-Gm-Message-State: AJIora9P5t8C/T/AKNJ5CP6VQW/LXMuNBnLz/fasUIn8XEgpSmv2eLcS
        giRVQBZ05zVXusvw4rOEDSiii0pway8mF7v16QqS8g==
X-Google-Smtp-Source: AGRyM1tYs0gst0wzWllfhFmh/2YO6+2mD2drm8ixQ18bj+AqwYkkzGMnkkIZ+8d2QbxsaFh7RG2BPbFDTKBCvU+EAcU=
X-Received: by 2002:a05:6402:540c:b0:434:d965:f8a with SMTP id
 ev12-20020a056402540c00b00434d9650f8amr17246024edb.30.1659375644623; Mon, 01
 Aug 2022 10:40:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220720232332.2720091-1-justinstitt@google.com>
 <CAKwvOdnSjyOdCZZ9AegCyfns3bvH3fbtbVgdThO2+rJAE=1bag@mail.gmail.com>
 <YtlsY2A2ZWK97Y8O@dev-arch.thelio-3990X> <CAK7LNASi_yrPhf0wv+0nqRcNhhbwUn-PzHvuiV2W1EsTqd_D8Q@mail.gmail.com>
In-Reply-To: <CAK7LNASi_yrPhf0wv+0nqRcNhhbwUn-PzHvuiV2W1EsTqd_D8Q@mail.gmail.com>
From:   Justin Stitt <justinstitt@google.com>
Date:   Mon, 1 Aug 2022 10:40:29 -0700
Message-ID: <CAFhGd8r1_A67aVt_5tMz-1NC51JrCFG=8cDsmTMz1kOricWEOA@mail.gmail.com>
Subject: Re: [PATCH] Makefile.extrawarn: re-enable -Wformat for clang
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> OK, I think that will be good timing.
> Please ping me if I forget to pick it up.
>
Hey Masahiro, just pinging to see the state of this PR.

I think we are on pace to re-enable this warning.

I believe there exists only _two_ patches left still needing to go
through along with this patch:
1) https://lore.kernel.org/all/20220718050356.227647-1-hch@lst.de/
2) https://lore.kernel.org/all/YtnDltqEVeJQQkbW@dev-arch.thelio-3990X/
> Best Regards
> Masahiro Yamada

-Justin
