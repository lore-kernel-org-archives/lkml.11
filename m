Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA88CC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Mar 2022 02:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235598AbiCVCri (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Mar 2022 22:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235577AbiCVCrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 22:47:37 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81AB1BE80
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 19:46:10 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id bn33so22293033ljb.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 19:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dITYxImMre4m5PN82mo0sCzas+UoEJc6AOZpn6FSwxQ=;
        b=IL1wvzqx+4Lo1FOTH8olL4GS/wlIhvER2KuNoDOv3LJtDseEqabMTtePVLjrZpVBet
         op/Zi0NlqCCC40yye4rRV6uRxhWlxxZHbpGqjodgKIw8Vxay6zIL19ynspcgj2AKrD8S
         eBFsLkRO49G0oNgu602vzcKlSS94BZU94Oi08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dITYxImMre4m5PN82mo0sCzas+UoEJc6AOZpn6FSwxQ=;
        b=DitKkQi3dxp0cGB+G/d96voZ5lNb1J/NQvLruuOOwPQHgpyjF0gaUOtxUelDz12jbg
         QqLzA5MApqvSGk0TwmAPNIiD5IOL+uOEp17Zg+uFXodUY/a+umUwkDsWX1Z5mAC/zPQZ
         lVTY0dlDAtFzTgpHJ0+iMO6Ufl9IyMP7UFpas9xT84HBBlxql9vQYTPTNaYGMdhEt6ki
         sRgPOnmbyfVrMsg5xklVrdC8Kit+T5PqvGYA8KhDpA5Fq8DtFVfW+s16IHJIYxhg4G5m
         Hdx0yLrOPZB6jEm7FmNh/sTqHDbECOPq+Els5cWCXms90efDCUnd6SGi6acNz35kWhDg
         7IYw==
X-Gm-Message-State: AOAM530m/rybnVqVckBuxxxJMnqDHGnYfQAkFsPcW2eL+CZE7d24b1X4
        aDkclUpE9VNOvphIdRyfPh0HWwpS8fjz3YJuhMk=
X-Google-Smtp-Source: ABdhPJx48jk1PBoGJdTONz23EcoPNX6qCkYHkLr1rzRbJFatP4u3CTYCkqemYiVcGgpAtAj9pgDMag==
X-Received: by 2002:a05:651c:d0:b0:249:85ad:537 with SMTP id 16-20020a05651c00d000b0024985ad0537mr5551219ljr.289.1647917168818;
        Mon, 21 Mar 2022 19:46:08 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id f11-20020a0565123b0b00b0044a2809c621sm594320lfv.29.2022.03.21.19.46.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 19:46:08 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id q14so9000022ljc.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 19:46:07 -0700 (PDT)
X-Received: by 2002:a05:651c:1213:b0:247:e2d9:cdda with SMTP id
 i19-20020a05651c121300b00247e2d9cddamr17734349lja.443.1647917167490; Mon, 21
 Mar 2022 19:46:07 -0700 (PDT)
MIME-Version: 1.0
References: <202203210806.78B1156916@keescook>
In-Reply-To: <202203210806.78B1156916@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Mar 2022 19:45:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=whtmuyBzuHULNWcP3==ixcb8yCb-QVEokZeDJESG_TEbA@mail.gmail.com>
Message-ID: <CAHk-=whtmuyBzuHULNWcP3==ixcb8yCb-QVEokZeDJESG_TEbA@mail.gmail.com>
Subject: Re: [GIT PULL] seccomp update for v5.18-rc1
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 8:07 AM Kees Cook <keescook@chromium.org> wrote:
>
> Please pull this tiny seccomp update for v5.18-rc1.

Well, that *really* didn't work at all.

  In file included from samples/seccomp/dropper.c:29:
  usr/include/linux/ptrace.h:50: warning: "PTRACE_GETREGSET" redefined
     50 | #define PTRACE_GETREGSET        0x4204
        |
   In file included from samples/seccomp/dropper.c:24:
  /usr/include/sys/ptrace.h:153: note: this is the location of the
previous definition
    153 | #define PTRACE_GETREGSET PTRACE_GETREGSET
        |
  [...]

.. and a lot of similar warnings.

Yeah, that sample code is horrible, and mixes kernel headers with
regular user-space headers.

It did that before too, it just does it much more now, and simply
doesn't work. I'm sure this probably only happens on some distros, but
that's what you get when you play those kinds of broken games.

Pulled and immediately unpulled. That sample probably needs to just be removed.

                     Linus
