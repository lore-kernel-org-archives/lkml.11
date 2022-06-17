Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A61FCCA479
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jun 2022 08:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380949AbiFQI3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jun 2022 04:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234590AbiFQI3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 04:29:16 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B577622526
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 01:29:15 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-317803b61e5so10388467b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 01:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NvDM6ePOB9255+QdACBJ4Cuqc1YOqX9BqNlnS6cgqOM=;
        b=drT2VwI/KZewVo8KT9/kXdTMbfdvv+NSGSELVGv4eiapATLknTm+j85k43io+ibKTF
         JEmJIcVb/sQlJiPCNzOJ9mVT9mlCp60slBUKsP5Efp1s0GHuqXq2V+9Jsr75NZuEtU68
         Wp23cWN398Y+eUq5UTdvu1FVjoeGZNF1qd5hnW/zhP+AI4HqG4wMED1j3CA5hTRdwfqY
         ozrKK4bKivojAC7rBcvH20NaRrHiljUkGUiHEBspGkYSbRHfJYDgQ70/aVXO4uE/OrMF
         2OY5lkXETqjvhi3wMs208J7cpdqp3mJfUSJ8Ga6/5PIltL3Xnhx4KI6xxpmV2Odk6W4c
         qubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NvDM6ePOB9255+QdACBJ4Cuqc1YOqX9BqNlnS6cgqOM=;
        b=GSu8uPPPvOToUnsR7lAUG6hGfATAgcORPMhyK5Z9iy0U0LLXuhhLhEn4IxGMvSxKfE
         YLvFlZwMTzdVwT5M2+s10otScTazyDoJVb3laDiicqb51zuFy4r4Hc2Nt1xEx1TXRDww
         9scya1mfAQpHXhSmZla0ks6rsfWHpLJly4rx/aKyQl2lkFYzftMW77rom/GX2EpllntD
         JkywO2snK+nFEyMw2l85G316yvZecKMjVefKS/HTwwEXbKiG2NkOn0boGYzGnnrOqBdH
         OATX3NVQVkVUQEVQPL4rf5Ray5O/GQFu+38Ftc+6CKJsRNtBsHfkrQhpUk+4lRYRQ2GV
         F5Jg==
X-Gm-Message-State: AJIora81W8rCb7lEBtkAFu2IjTgKyM/qFuxUnu0wTxdwkAFNPl4dDVxo
        nnYuFu7RHw23JdM975l0ki6dd588JKxzL5jwntSxvQ==
X-Google-Smtp-Source: AGRyM1sXLogUpwJPjF1dzAojDC/KQZrNZsdk08Hdr7n8V4gMaf4+MazYkz+tgTepMChNzJTrpNtYtPlHQWaBnkTF1Ac=
X-Received: by 2002:a0d:e8c8:0:b0:317:6df2:304e with SMTP id
 r191-20020a0de8c8000000b003176df2304emr7783879ywe.118.1655454555028; Fri, 17
 Jun 2022 01:29:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220616013747.126051-1-frank@zago.net> <20220616013747.126051-3-frank@zago.net>
In-Reply-To: <20220616013747.126051-3-frank@zago.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 17 Jun 2022 10:29:03 +0200
Message-ID: <CACRpkdZ-X_3vqcyRUH5-KM=mkGF3C87fMMPGxVWmVyYHtCCS0g@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] gpio: ch341: add GPIO MFD cell driver for the CH341
To:     frank zago <frank@zago.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Wolfram Sang <wsa@kernel.org>, Johan Hovold <johan@kernel.org>,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 3:38 AM frank zago <frank@zago.net> wrote:

> The GPIO interface offers 16 GPIOs. 6 are read/write, and 10 are
> read-only.
>
> Signed-off-by: frank zago <frank@zago.net>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Please preserve my ACK on subsequent postings, USB changes does
not concern me, I trust Johan to review those for you.

Yours,
Linus Walleij
