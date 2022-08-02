Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8250AC00144
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Aug 2022 03:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbiHBDlt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Aug 2022 23:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbiHBDlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 23:41:47 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E40643B;
        Mon,  1 Aug 2022 20:41:45 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id c185so9833510iof.7;
        Mon, 01 Aug 2022 20:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vf0uIFPv/spUcxtdGqe9aPlHeyG7G8WlKPKI+UXXp4I=;
        b=EHJlzzQ8CTcijPGOE3L0ZpmDdufpuOWy8owNYHiE4h9bMyX2jQdCmag0A/+lQidE9F
         TtBplVedljYPII7wS6YkphVz4rEj6DNw5La1htLeArdU953rcHodYK/8BvJsiew5ciJg
         tQbj9XKwk+hLh1YXRJGnXWRf4bK9oANr6kNbS6OdOgxTr3PGumR4n0SaQOIAYlfKGpzZ
         16/U7O2EgSAk8GaGcS0T9G1PtOMGCwb1vauJWtsJuz28/kFiNoAnvDtaWMRkixVfj4bl
         e4iOEnbEY4eKMbMR2ZVCoUSy3Z/QYkcEUr1TdxbBLqo753tTfP2v+mIRKc9ph+rbHLGz
         KBzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vf0uIFPv/spUcxtdGqe9aPlHeyG7G8WlKPKI+UXXp4I=;
        b=4qh3clBJrlXrL2AcQKqacKpBUU+HAKdYGwmRJoggrIEZqEZvtcktUZJvWEy/WxvGYU
         rBnSJDB8Szx0Rt2d7sFIPqm540Qs0zzuUvcKbUCmrWi1FP9qjctx8qj5ywux55djxBJA
         9r1MR6/vy+KK6nFdzI8ZjjE280KE2gtHt0aga4x2tAymwp+/0QigrjenuX+fhKTQSE+q
         KPA1xvFMrm0mE18X+VINsTTHUsCz7au9Z1ssB5l6BDCsGVQn4vFVHOlrILBtFJV4n0O9
         mNNEXZf2DiRdJ7i9xR1q6Ofi3JAB8WG/mDKgyG+t7XktbxoaD+30FxFqXSiQ7g0up/Xa
         YAsA==
X-Gm-Message-State: ACgBeo3Kfb0mD83zRfDctAW1YuwGS/KjlDFL3qAZYS7Wo0pvAz1h34ry
        ygKs0qV08DJr7ATuyqbzj3kD2iCCQ9TSwovLVhg=
X-Google-Smtp-Source: AA6agR5Mmb6Q6uqW2YjCvwFWE02cfDuOv4RKT6drufqQ8IS//DGpRZDyPUdh2D4eOY38KMDDsoER9ZgKF6jrzJDEpWM=
X-Received: by 2002:a6b:e511:0:b0:67f:9ef6:5779 with SMTP id
 y17-20020a6be511000000b0067f9ef65779mr2767924ioc.177.1659411705038; Mon, 01
 Aug 2022 20:41:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220802015052.10452-1-ojeda@kernel.org> <20220802015052.10452-30-ojeda@kernel.org>
 <YuiLM6ca8Ih0WiS3@boqun-archlinux>
In-Reply-To: <YuiLM6ca8Ih0WiS3@boqun-archlinux>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 2 Aug 2022 05:41:33 +0200
Message-ID: <CANiq72nOXZ5smgzJBW=ZTZEYJkRA1n-mUeNTpofrDh6UUozORw@mail.gmail.com>
Subject: Re: [PATCH v8 29/31] MAINTAINERS: Rust
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 2, 2022 at 4:27 AM Boqun Feng <boqun.feng@gmail.com> wrote:
>
> May I join the party and become a reviewer?
>
> R: Boqun Feng <boqun.feng@gmail.com>

Of course! Thanks!

> Also given their activities on GitHub, I'd like to encourge Bj=C3=B6rn Ro=
y
> Baron and Gary Guo to become reviewers as well. Of course, they need
> to be aware of the possible upcoming email volume and sign up themselves
> ;-)
>
> More eyes (especially from Rust language experts) are helpful ;-)

Indeed, they would be most welcome to join :)

Cheers,
Miguel
