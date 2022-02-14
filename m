Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D91C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Feb 2022 13:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352670AbiBNNGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Feb 2022 08:06:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbiBNNGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 08:06:11 -0500
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16264EA3D;
        Mon, 14 Feb 2022 05:06:03 -0800 (PST)
Received: by mail-vs1-f44.google.com with SMTP id t22so18700657vsa.4;
        Mon, 14 Feb 2022 05:06:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9c4MC5Xtn2gF/8NoLdQrBf3/Seq/IL9VP4ML3k/mjKo=;
        b=6TI0wjSPhCVrxJsathLiQHlozLYagNJb0BrFkChvbOw+D5l9Q6uLSqmCtONregg+qT
         NMIRQJl74zHqd359TvTg5OLHh90CqagiihGvgSJv94Bx85eFdjft9SPbszPt47lhlt+I
         +SO1wMl0uZ308C+9oKLxQ38Sy6FFlNjcsPBWaPCSJ5345egXAsGsUFi6q7HAjxByiusn
         w0t5rOZLW7/aYmkEVRm5xeEPY7B7nnQgfzFquqQPjmsuXZAGLoXUnxcRj23yuyVXwSex
         0dK/uuTAFm+VXerPu3UfiFVuzXlHdAy2ncxsxF4Gu3+8VKjEWrq4RiDKZzftQNPtnJP9
         up+w==
X-Gm-Message-State: AOAM530B+cuWbWm8mz666k/8iz4KuFfTpd54VyaFGL0Q0ouchxm2kkRA
        L5LMjemSG1zhjlnBNKyycmy6eeoXZDy7vw==
X-Google-Smtp-Source: ABdhPJxVPw6Vwm4lpfA37lOzvBv8x3SYzHDyaX3IRJu78Vy+eB0auvuQa6SjE+6cMD4a4ImxCJc63Q==
X-Received: by 2002:a67:ea08:: with SMTP id g8mr3580517vso.19.1644843962944;
        Mon, 14 Feb 2022 05:06:02 -0800 (PST)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id m3sm2327094vso.0.2022.02.14.05.06.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 05:06:02 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id w4so149511vsq.1;
        Mon, 14 Feb 2022 05:06:02 -0800 (PST)
X-Received: by 2002:a05:6102:440d:: with SMTP id df13mr1245927vsb.5.1644843962404;
 Mon, 14 Feb 2022 05:06:02 -0800 (PST)
MIME-Version: 1.0
References: <6c08e98f-c7bb-9d95-5032-69022e43e39b@omp.ru>
In-Reply-To: <6c08e98f-c7bb-9d95-5032-69022e43e39b@omp.ru>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 14 Feb 2022 14:05:51 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXfieYjQCFgGJA79BtzTF2UD-9zx7V+g=pqVbqsjqOJeQ@mail.gmail.com>
Message-ID: <CAMuHMdXfieYjQCFgGJA79BtzTF2UD-9zx7V+g=pqVbqsjqOJeQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: specify IRC channel for Renesas ARM64 port
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey,

On Thu, Feb 10, 2022 at 7:00 PM Sergey Shtylyov <s.shtylyov@omp.ru> wrote:
> The Renesas ARM ports do have their own IRC channel #renesas-soc (initially
> created on Freenode, then moved to Liberta.Chat).  Hopefully, adding it to
> this file will attract more people... :-)
>
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

Thanks for your patch!

> --- renesas-devel.orig/MAINTAINERS
> +++ renesas-devel/MAINTAINERS
> @@ -2525,6 +2525,7 @@ ARM/RENESAS ARM64 ARCHITECTURE
>  M:     Geert Uytterhoeven <geert+renesas@glider.be>
>  M:     Magnus Damm <magnus.damm@gmail.com>
>  L:     linux-renesas-soc@vger.kernel.org
> +C:     irc://irc.libera.chat/renesas-soc

Should be inserted between Q and T below...

>  S:     Supported
>  Q:     http://patchwork.kernel.org/project/linux-renesas-soc/list/
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel.git next

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.18, with the above fixed.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
