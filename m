Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F7AC43334
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jul 2022 23:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiGMXCL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jul 2022 19:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiGMXCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 19:02:08 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD17F2B1AD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 16:02:06 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id r3so344776ybr.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 16:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7OSuSJ52wcTOUMRocdLRtm5methg8M/tEQfwjrfRjyU=;
        b=EX0eIDTDv6Op2NFyQjnDuL3ygkxwpxc10ZsVRZ9ZEnjSS6oiGUeLDkvI1GSJwQt9Ch
         KPAhOHA0QidwpyzycO4aCctC/tsY2FchXz8+5pM/yMBZjW8fQlx4utnOpkeGfwz4OkXi
         raDunL8HcgKouLi8O/KOdqAMJZpKWT/cgMkEeQmZlfNyZ+rr9hBfcS4NLKzjkNW2WDcQ
         +UH4Gbx75sWaNPaH5WRQUkyZ8qWVipA8wMUwZU9rFL29p3LxFIeyLQM6XFojw1/LZIEg
         ed1XNXEmtuC5zb0JmErjZWEAtz92nWbpJh//plAe1ba+irJa35poeGnhpFc5N0LE1Lkc
         z5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7OSuSJ52wcTOUMRocdLRtm5methg8M/tEQfwjrfRjyU=;
        b=h6OHwJZOqQm8f0o+81Y2SMgOha5Rd+JmLnUNQEhYNfHGtuxVVMkdfYOZYTLucbFG7r
         Y6eKTk0CM4I7sS/SyBcoS1yg1SfoH+Ieg+PsIGtzoV5AKAWWwr/RhUV5UeJrM5JJ3utT
         M1Ka2G3PNPTpVH7HXQBsDX+fK9CRPVTdz60g6CicxEGFX8h+EwCVyh9uHVFDIaFCNa7I
         MaqszCFDQuRNpOWZFbTZ+ctHjaY2Di+uOKe3UiXIqimijpZwRq+zku/wmmQijea89jrZ
         kfOuQRaqLaoSg8tOVFvCMnlTz7dOiHMJlaaOvrBcGU9IXQdzJeXZNO8GpTYB5QvXWbkH
         RGUQ==
X-Gm-Message-State: AJIora/CZd9KdJ+GFKo4ta2f8sEL6o2C7KtkjW+DdCX27v97HDyXHAzc
        ps+IWLmRJU4XpcuzOb1EES0fIzQb+n/9bOg25QKKEQ==
X-Google-Smtp-Source: AGRyM1vEw5SGw7ikM1WmdO80Q3n6WgdPVzJZoC2+wiPT5SqXIkmr/awSwAQRRWZk2+6iU7YkSj92hhvZOAIU8oU5Fdc=
X-Received: by 2002:a25:8b02:0:b0:66e:239a:8f69 with SMTP id
 i2-20020a258b02000000b0066e239a8f69mr6060934ybl.4.1657753325788; Wed, 13 Jul
 2022 16:02:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220713214246.2545204-1-jevburton.kernel@gmail.com>
 <CAKH8qBtkgsQ9snhno3aYnhyc8vG2a0xhgg_sCb4KFhcQt+gfqA@mail.gmail.com> <Ys9IBYKqlTzkf3jA@google.com>
In-Reply-To: <Ys9IBYKqlTzkf3jA@google.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 13 Jul 2022 16:01:55 -0700
Message-ID: <CAKH8qBs7FHAT9ZW+xAfJ=3gr8ZhZ7fMQO6K2Cmw8FuKGa7+GPQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Add bpf_map__set_name()
To:     Joe Burton <jevburton@google.com>
Cc:     Joe Burton <jevburton.kernel@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 3:32 PM Joe Burton <jevburton@google.com> wrote:
>
> > Asked you internally, but not sure I follow. Can you share more on why
> > the following won't fix it for us:
> >
> > https://lore.kernel.org/bpf/OSZP286MB1725CEA1C95C5CB8E7CCC53FB8869@OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM/
> >
> > ?
> >
> > The idea seems to be to get the supplied map name (from the obj)
> > instead of using pin name? So why is it not enough?
>
> You're correct, this approach also resolves the issue. No need for this
> new API.

SG! New helper might still be useful, but I'm not sure how safe that
is, given how much we use the name internally in libbpf
(name/pin_path). So it might be safer to use Anquan's approach for
now.

Andrii, any concerns with [1] ? Should we pull that in?

[1] https://lore.kernel.org/bpf/OSZP286MB1725CEA1C95C5CB8E7CCC53FB8869@OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM/
