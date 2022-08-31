Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC2BECAAD3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Aug 2022 09:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiHaJOA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Aug 2022 05:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiHaJNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 05:13:45 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB54DC32D0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 02:13:43 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id q21so5209459uam.13
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 02:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=9lQlWzwRA7mmLZ83Bk5j1stsiIHWI9p/Pq3FJcBwBuE=;
        b=fy01CyFBMpw0CycUHXklvK8mD7aQoEsQfuyCWnhgVt/p61BrdR5wNgNGbAw/uhYt3S
         kYM5eCmUv9ajzwVEgnNEXsqrjZA8vtAYqpHg2NcP9vyRzs+06y4ysAEyaEwywfusvf3V
         PW0YLfSviT7Ww0V0OHqfnd/Bj0nzxntp2hYRXaA8x9Q95LD5/up7p7XXGV9ULqEuUL4s
         gKqn5dmVZZRZljxxbtWyCi9HgM79bsKyk09KdHvxslEuwgVeQab+leOTl7e/9Nbq4X8P
         Mj32PudWSutqHkmHIXhsKP/DWi9y8TWk5OscQe5uLUkeoj2DzZHnbcS/gWAhVLjVdUlC
         Tqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=9lQlWzwRA7mmLZ83Bk5j1stsiIHWI9p/Pq3FJcBwBuE=;
        b=kw0Q1apLxc+lCBP0OHMNRtcA69HjbZ87gdMcBsOOCpURAUGRKILugpDFxb/wbp3EHD
         Y+fGOghHWB2xIyZNMEfuxs+QkVRveUIsHa0EUpKgDYS0V8lQpzebcYUohmdGGbhLoHFu
         IRvqdWtmE1Bb2/MnyDt3vcbvakrnDbdjYEBoCHjCuOtB+YAPLQ5qtPSpOg7rrb8gcXKo
         CVX03v1jpgwh5f7u6XKICJbEFRmg+jV2IKlyp3JpWXRxMitvmrmUFi6miERTQN7JjqS5
         2/a8EmhKOYFt0NnFC3jHQCBJFiPAGjgN/iFl3xR9xqgrPIUW32GIZAEXqe0lrh+nUxvD
         VdHA==
X-Gm-Message-State: ACgBeo3e1pB0AqcH7MfoaGaxb0bn898UWtE5MNldD/MMJKDf0EE6+P5v
        4wwlIjAgcWWsgiOT+0r2GuE7TUDJ013pbiUKWodieZSW4xc=
X-Google-Smtp-Source: AA6agR6JxD3MIVnuuOhxXDtgKQr1RR3Y8OSBsF/SKvBmwmKpjpsVlJOMvAw1KoFQsHBRen/GMaC1ip/AA+5/0oi1XLA=
X-Received: by 2002:ab0:7214:0:b0:39f:2d13:2d5f with SMTP id
 u20-20020ab07214000000b0039f2d132d5fmr6624048uao.83.1661937222430; Wed, 31
 Aug 2022 02:13:42 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000d082f105e6f93705@google.com> <4020341.1661343794@warthog.procyon.org.uk>
In-Reply-To: <4020341.1661343794@warthog.procyon.org.uk>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Wed, 31 Aug 2022 11:13:31 +0200
Message-ID: <CANp29Y5AvokVpTWy9kEZofWfkoE8uUd+nJ2+pcKwndLQ2no3sg@mail.gmail.com>
Subject: Re: [syzbot] general protection fault in fscache_free_cookie
To:     David Howells <dhowells@redhat.com>
Cc:     syzbot <syzbot+5b129e8586277719bab3@syzkaller.appspotmail.com>,
        linux-cachefs-bounces@redhat.com, linux-cachefs-owner@redhat.com,
        linux-cachefs@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        "'Aleksandr Nogikh' via syzkaller-bugs" 
        <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

You can either write #syz fix: <new commit title> and use the title of
one of the commits that removed/rewrote that code.
Or just "#syz invalid" (without quotas) if there were no fixing
commits and the ones that introduced that faulty code were just
dropped.

Best Regards,
Aleksandr

On Wed, Aug 24, 2022 at 2:23 PM David Howells <dhowells@redhat.com> wrote:
>
> syzbot <syzbot+5b129e8586277719bab3@syzkaller.appspotmail.com> wrote:
>
> > This bug is marked as fixed by commit:
> > fscache: fix GPF in fscache_free_cookie
>
> The code that was buggy got entirely removed and rewritten, so the fix is
> obsolete.  How do I communicate that to syzbot?
>
> David
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/4020341.1661343794%40warthog.procyon.org.uk.
