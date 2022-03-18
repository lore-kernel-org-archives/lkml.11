Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1B4C433FE
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Mar 2022 19:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240360AbiCRT0b (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Mar 2022 15:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235549AbiCRT0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 15:26:30 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DFF30CAAF
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 12:25:08 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id p15so18883863ejc.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 12:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hXH9ELMuDY+iN+HFjZXoGFqlOaPPrjOGTbi3JNMxxVA=;
        b=AVhQunjEnglxMNGkZ1ERYHtyQHblgxV8GZOCiAQAeZLEeFQ2gTXP6yTA0fG2AKamls
         zRLXL+1ze6sD7aCthHCmdGBcTEBpeZHGP19fWFmWj3QRm4Ec8LapG9NigrYV8klby38u
         IPpvH0OOkM+dkHvOxrYmon+uvdEfwhxxt37o4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hXH9ELMuDY+iN+HFjZXoGFqlOaPPrjOGTbi3JNMxxVA=;
        b=4wOiaIcCA1/7W91yiZ24e9UVnQVW7yDbp1G3GcG6c7wAQzJTBouHbqd4XnRa7Of85z
         cFijfxus4bTFXeTDUCCKOFict2s3NbScvAbIb77EVrwCi0lmx6Rvl5eXEyj2AQ6uvsph
         3O6FIGmyZjyKynVLPP62l9x6Z1AsbZHkOtjYgvNLsyTHOsOzNdMluIaHsxytqQSPecAj
         /A77vEolKtIiPqVMoAmcwbin1fYRKsmPejfrB1mBOWrZinrfrvZG2iqVLjDThsKYXGPX
         jCfTCboZkYdFjhGGHlqLSyO/kPweSDgLsUMglh4RIw4DLuGjJrqBxcIrOcMcMsTBvggc
         CrvA==
X-Gm-Message-State: AOAM531+RJW02wEjF+GZtEzTSGBLdG+BpgmwClZrx6twAhf4XsqAERxK
        ASdJUdCo6dPAioOnAtf2tc1GALm6QNsc6I8wclDB+A==
X-Google-Smtp-Source: ABdhPJz+V9DZGjtY86DMYeyi3wTfGJ9WSF8zTZpI/KQBMaQZ5GADOS5tu4yWcHopXE3+Co3KTkyZHEqdfLmv5lcqISs=
X-Received: by 2002:a17:906:7948:b0:6da:64ed:178e with SMTP id
 l8-20020a170906794800b006da64ed178emr10705575ejo.523.1647631506866; Fri, 18
 Mar 2022 12:25:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220318171405.2728855-1-cmllamas@google.com>
In-Reply-To: <20220318171405.2728855-1-cmllamas@google.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 18 Mar 2022 20:24:55 +0100
Message-ID: <CAJfpegsT6BO5P122wrKbni3qFkyHuq_0Qq4ibr05_SOa7gfvcw@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix integer type usage in uapi header
To:     Carlos Llamas <cmllamas@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alessio Balsini <balsini@android.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        kernel-team <kernel-team@android.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Mar 2022 at 18:14, Carlos Llamas <cmllamas@google.com> wrote:
>
> Kernel uapi headers are supposed to use __[us]{8,16,32,64} defined by
> <linux/types.h> instead of 'uint32_t' and similar. This patch changes
> all the definitions in this header to use the correct type. Previous
> discussion of this topic can be found here:
>
>   https://lkml.org/lkml/2019/6/5/18

This is effectively a revert of these two commits:

4c82456eeb4d ("fuse: fix type definitions in uapi header")
7e98d53086d1 ("Synchronize fuse header with one used in library")

And so we've gone full circle and back to having to modify the header
to be usable in the cross platform library...

And also made lots of churn for what reason exactly?

Thanks,
Miklos
