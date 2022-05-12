Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCFFC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 12 May 2022 13:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354298AbiELNV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 May 2022 09:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354192AbiELNV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 09:21:26 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BD13DDD1
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 06:21:26 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-ed9ac77cbbso6606643fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 06:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o1LkdWLl5bERB7RO9RpYQ/us9kzwvuP0AILwTfB/8W4=;
        b=V1n/chSwX/yC24Pb7iPWi90T+RcN5kcECtqlaG1lb2FQPhSjWGqyC8u1wLLBtlPBGQ
         cPmbAr+aoI8KHHy8rnBeCHl88BAf0PNQEHZ6RKwOqa/cs6eUhsZ22PLkytm8TvaV3EZ0
         GqG3x/DwoMEG/FmOy7Cq7xGIrRIA8u+0mFTSpS7kRlD/yas4kNL9gniA1YXtEI+IAFQX
         ac4x3PitUBuhA0TGej7bL8ti3Gwp/6BYgV/m+7HgP+q5xfUtF+pJp4MxCeZIlJF9z36F
         aLHpmFm0LV5yiGTWOYTEUXuL/1NlhQWm91KnC61/zjxGjS2y6xHTijiPUTZO4LIEGiWa
         Cv4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o1LkdWLl5bERB7RO9RpYQ/us9kzwvuP0AILwTfB/8W4=;
        b=I06ToZkeg31I9qlp6h0Mt3EEi/iuzQudUwkELeKubHb4C1ODjyx7u3/BDwX8aIvdD9
         KayXyZUPctqzzZPrZn+jQTQqRjvAQeghA+f1LmsoxIo5XcCC2yXdyeQh+umT4owMGnlm
         /2zN6fl8PPTtVBO1lLfe7PEZVuNqlvXq1GJN0TDUWgCmGOLxrVAdA3gzYMuCFVHuD9eK
         asvFBzyQFFfTC3XL5E5qUZCdVTVcVF9Ebb12ASkJkrsyt3NbxX4TFHWhkGCZdZ6zM3y+
         G17Ah2fXZDvH5vbX3KGCCriwSZnjm7+8OU78YbrBzqWcWZxjhHFuqp0kKODqidQvnVH+
         wz1w==
X-Gm-Message-State: AOAM530zQwXVj+8WZwWMe+VW8hTFIuBBHhIW/TrDTRxujSwqos1BhkhW
        QzourAXneFiGCwow4KiKHtsqfHnG+FkQh0mgw70a0Q==
X-Google-Smtp-Source: ABdhPJwwmEGtUQearzvM5CoarRF5IQke11aUPGfWHgUZFWZGWDLSi4YMil+hfBnKvXUHDizXhPtCMeu7zduTNUZAPdw=
X-Received: by 2002:a05:6870:d254:b0:db:12b5:da3 with SMTP id
 h20-20020a056870d25400b000db12b50da3mr5492856oac.211.1652361685131; Thu, 12
 May 2022 06:21:25 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000ab6df705b453993a@google.com> <00000000000035befb05d6b91185@google.com>
In-Reply-To: <00000000000035befb05d6b91185@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 12 May 2022 15:21:14 +0200
Message-ID: <CACT4Y+bi-h7PGWqM=JyjvaTHcyzkg9nndUTVCyV-rADPYgHspA@mail.gmail.com>
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in
 bitfill_aligned (2)
To:     syzbot <syzbot+a4edd73d589b0b7efbeb@syzkaller.appspotmail.com>
Cc:     b.zolnierkie@samsung.com, bugs-a21@moonlit-rail.com,
        dri-devel@lists.freedesktop.org, javierm@redhat.com,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        maxime@cerno.tech, ngraniel@cocobongo.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Jan 2022 at 15:07, syzbot
<syzbot+a4edd73d589b0b7efbeb@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 0499f419b76f94ede08304aad5851144813ac55c
> Author: Javier Martinez Canillas <javierm@redhat.com>
> Date:   Mon Jan 10 09:56:25 2022 +0000
>
>     video: vga16fb: Only probe for EGA and VGA 16 color graphic cards
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1752f5c0700000
> start commit:   2a987e65025e Merge tag 'perf-tools-fixes-for-v5.16-2021-12..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7d5e878e3399b6cc
> dashboard link: https://syzkaller.appspot.com/bug?extid=a4edd73d589b0b7efbeb
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16671badb00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=122beabdb00000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: video: vga16fb: Only probe for EGA and VGA 16 color graphic cards

Based on commit subject looks legit:

#syz fix: video: vga16fb: Only probe for EGA and VGA 16 color graphic cards
