Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51B8C43334
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jun 2022 07:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353811AbiFVHqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jun 2022 03:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiFVHqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 03:46:43 -0400
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FF136E25
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 00:46:43 -0700 (PDT)
Received: by mail-qv1-f47.google.com with SMTP id 59so1290439qvb.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 00:46:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dmGPFZPTP5s26NzZgE/CmdswraC7MuQTQKrQzx6Alt0=;
        b=qYz8dw2MDKWewIJlPv73htqcT/nBgQWXhh6HNSyhUaJste/v+rGURh6ZzMHrIaZfXI
         eog0ahZI71gHtEriEWumkS5rv5Oyj/sEGWBwncAJGCNv+3P8TqZuy7kGH6t7OexQTYax
         D1l/97jHKn5txz0FYtS4KH2QF6nh4DKtE3cpuBBccqjL+AcSq7dW++MtlC6t3BMPu+cM
         kuH63GwC4xy2nElkEMrsKMLpCS9m5+CINwDq0HmT2XpXqD2Cju5x+FxEasdohOtSyJLA
         7g65/whZ55sADb29a1YH/xS4bfB8IeBheDoJNuPJWZ40RWHvQIcOet2FDLdKy4G9R5bc
         2zEg==
X-Gm-Message-State: AJIora95B2I0rgZil9QXeIKUDT4QKA+vkKqwGafhDkGEQauIif1VUpLb
        GjPHwZJ2QoXzAJZm1nJGT9Ln1OG4MwARhA==
X-Google-Smtp-Source: AGRyM1twNnQ997S9aPwcJNSG4DL1HZyg5iSTcNNM8MZWsJBwfoH3ygFJDEeoU6S0d+PDDoe1Wp8w5A==
X-Received: by 2002:a05:622a:1803:b0:304:ef17:7532 with SMTP id t3-20020a05622a180300b00304ef177532mr1755868qtc.110.1655884002227;
        Wed, 22 Jun 2022 00:46:42 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id w6-20020ac87e86000000b003164efd0a5fsm371364qtj.41.2022.06.22.00.46.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 00:46:41 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id e4so16086159ybq.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 00:46:41 -0700 (PDT)
X-Received: by 2002:a05:6902:120e:b0:634:6f29:6b84 with SMTP id
 s14-20020a056902120e00b006346f296b84mr2322150ybu.604.1655884001424; Wed, 22
 Jun 2022 00:46:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220622073553.64991-1-yuanjilin@cdjrlc.com>
In-Reply-To: <20220622073553.64991-1-yuanjilin@cdjrlc.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 22 Jun 2022 09:46:30 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUjsSwMwKjuKQ+h-ki_SwUThNJksALXK5cNoOikY0M-Fw@mail.gmail.com>
Message-ID: <CAMuHMdUjsSwMwKjuKQ+h-ki_SwUThNJksALXK5cNoOikY0M-Fw@mail.gmail.com>
Subject: Re: [PATCH] m68k:coldfire:Fix typos in comments
To:     yuanjilin@cdjrlc.com
Cc:     Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 9:36 AM Jilin Yuan <yuanjilin@cdjrlc.com> wrote:
> The "the" should be replaced by "of" instead.
>
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
