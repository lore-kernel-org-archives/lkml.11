Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB82C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 May 2022 23:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243465AbiEYXYV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 May 2022 19:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbiEYXYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 19:24:20 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC38A7765
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 16:24:18 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id i27so44510258ejd.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 16:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=izUkwPGGxBZu6bQbI1S3gbHIYHJd/Kx9MigGiHCcKQA=;
        b=D5mVvCtGLAYUINLafQ9DPym4MJXRyvQLXXWRjrx7n1C1uIfy36sHQGOdCF5ZndroFS
         ojwLK0DYMvLQiWqXThTIuQmhTToL+5gScEAtihj4NfqxoP3DZ16DKqcSvXm9o0uccQ4x
         DiJ6myHRPJJsJ/KmAp/PUbZBYGYej0SMRpdWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=izUkwPGGxBZu6bQbI1S3gbHIYHJd/Kx9MigGiHCcKQA=;
        b=S3QKMZ+S8acPzRJoCwDrLIvtqoTevhJIddlqOqODFg5uOZn69HkFhhOL8n5RPddYeF
         B3sKV7IHWskmgBauJ1+rZ11rZCIsQvXsVsdy8G6QQQL1nefL0dAi0p202XoKzXjqxYml
         qIb2DtUiWy+TbDSL4nZM+7XNB3FcmCbHveV2JZSGTsgR14jNUslM4hN7Sano0SJZ0QPp
         GAxFqJFKCehACfTKSsB3qqKmytdMdFKvuiLcrDo1d7R+dQ5Po1/ilagNzFYICskp9RYH
         lvRkcZv66enAxOw36YEHhpCDKlTrJgUQ+JTJ20iQth0obFpm7z4N4X/oJ0SlpVvA6+VC
         WlwQ==
X-Gm-Message-State: AOAM530IGtWcLgP+cQ86jLr+uZQV6wIQUr2/zxSySKJmycG/aEpYGeLh
        /4zc/5QrFqeMTWskxIC/Iuz7IltpeiLUob0f1Rc=
X-Google-Smtp-Source: ABdhPJyRZmPifQiRjmRd5mUgH60Bw7rq5pVCTlhADW6vXeKHkBmMEMTXRMx+7Wuq3/MZu09e3kDymg==
X-Received: by 2002:a17:906:590e:b0:6fe:9c69:c5ec with SMTP id h14-20020a170906590e00b006fe9c69c5ecmr28912900ejq.486.1653521057075;
        Wed, 25 May 2022 16:24:17 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id c28-20020a1709063f1c00b006f3ef214e63sm8610389ejj.201.2022.05.25.16.24.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 16:24:16 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id o9so117268wmd.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 16:24:16 -0700 (PDT)
X-Received: by 2002:a1c:7207:0:b0:397:66ee:9d71 with SMTP id
 n7-20020a1c7207000000b0039766ee9d71mr6432677wmc.8.1653521055778; Wed, 25 May
 2022 16:24:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tw62EZfAm0PbiOPmMrpfR98QMFTWGEQcA34G4ap4xxNkA@mail.gmail.com>
In-Reply-To: <CAPM=9tw62EZfAm0PbiOPmMrpfR98QMFTWGEQcA34G4ap4xxNkA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 25 May 2022 16:23:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgg86+1n550uM3gkhpRyauvWySnRwPHHP6Mm90FF5f7dw@mail.gmail.com>
Message-ID: <CAHk-=wgg86+1n550uM3gkhpRyauvWySnRwPHHP6Mm90FF5f7dw@mail.gmail.com>
Subject: Re: [git pull] drm for 5.19-rc1
To:     Dave Airlie <airlied@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 11:07 PM Dave Airlie <airlied@gmail.com> wrote:
>
> AMD has started some new GPU support [...]

Oh Christ. Which means another set of auto-generated monster headers. Lovely.

                  Linus
