Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2EFC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Mar 2022 20:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241478AbiCHUzS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Mar 2022 15:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbiCHUzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 15:55:15 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9945C3CFDC
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 12:54:18 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id w12so142972lfr.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 12:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MO3ZBNJePqQGyLPMQe8PRpnm9Bddgo+644GgiUPEy/M=;
        b=bHbT/b64rzz3SkFBCHfbQdq5oLHBwAkVr2qxv1DIAivupXQeBrvKZD8eYRfIp0aMYY
         78qesE9m8jzgMsaUzCWU+YA2uCcaE6L1WrQW+AtC1WUFiZp4zxo5bqZolsDx2WvD+ej3
         fF5c+vdqsw7bveac0dF7ugPyvDQuuUeefZtGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MO3ZBNJePqQGyLPMQe8PRpnm9Bddgo+644GgiUPEy/M=;
        b=bOm9iHLSH/lbzaoNL9dsc1kri2u/cwXjziFTP5YtIHuSkcpZEBWf9jx+I8i+hQOqNx
         R9zwJSrgfprys6kzvmLQrGsASV6ES4zvWJ7C4Sq3UjQn4WwP/0NcEU4VLSMso3kKhQrg
         p0cA4JH5fKTP1HJEQeoxwcb9dsCH9c9qUGVSmRwRnkyVO9zux582rUa8bC/zmXfLCo5s
         wOI9xzOd3/cMjDIOdUGsGK4qRZuSZrHNouj7jAD2gT8Krk/gdMfANWFnPWbXRKd5Smaq
         X3ibcyFfxKpSgSRxrPY9d7Uv2qbKleLny3sBLZTQW4kB16a7euj/H5/aSMq7nSfjGt13
         9nYg==
X-Gm-Message-State: AOAM530zboXGAsIvZ0ois7yxLpjxrEXFzt6qQFuKybVLZTFvaofAT8sx
        3fzOZZz825S8cYB5ZCjGY924Pf83t3PIuWrrtBo=
X-Google-Smtp-Source: ABdhPJy/hhvz5f/MuzyIjRtluKFiYLujVOYS2nzXXt9tuc2gvdlvUPR6gP0jXIWu82GwLwQbybuLlQ==
X-Received: by 2002:a05:6512:965:b0:447:8cd0:48b9 with SMTP id v5-20020a056512096500b004478cd048b9mr11977112lft.672.1646772856650;
        Tue, 08 Mar 2022 12:54:16 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id q27-20020a19431b000000b0044847642a6dsm438035lfa.299.2022.03.08.12.54.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 12:54:14 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id r7so181598lfc.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 12:54:14 -0800 (PST)
X-Received: by 2002:a05:6512:e8a:b0:443:7b8c:579a with SMTP id
 bi10-20020a0565120e8a00b004437b8c579amr12043565lfb.687.1646772854246; Tue, 08
 Mar 2022 12:54:14 -0800 (PST)
MIME-Version: 1.0
References: <20220308191820.18270-1-linkmauve@linkmauve.fr> <Yie+9J0hyA6k2KvD@dev-arch.thelio-3990X>
In-Reply-To: <Yie+9J0hyA6k2KvD@dev-arch.thelio-3990X>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Mar 2022 12:53:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj2fYmTaoyO70LJuDfaFGcbn72t9R-SQrVSYpypvKF7Kw@mail.gmail.com>
Message-ID: <CAHk-=wj2fYmTaoyO70LJuDfaFGcbn72t9R-SQrVSYpypvKF7Kw@mail.gmail.com>
Subject: Re: [PATCH] ARM: fix compilation error when BPF_SYSCALL is disabled
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 8, 2022 at 12:39 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Linus, would it be possible for you apply this directly?

Done.

              Linus
