Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CB6C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 May 2022 20:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377948AbiEDUVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 May 2022 16:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356979AbiEDUVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 16:21:39 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF96F45792
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 13:18:02 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-2f7c424c66cso28363377b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 13:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OQdnNmzv4usFcCEslqJZULlg/FXfYALoeT9o7toWf+k=;
        b=qxZZQ6AsGHlKFFmOKUtmMByudpi1JNcM2xDw70w505LXnF7lLC/fAGH//lR/VZSrlR
         bzYODkJGL2C4z48gkOhr1/f+95RehMweBA2jJko7pnpROeEw4lFeekw/gjN1Sr37kxgi
         VOMlKjWfiWZVgzx71URL6y09ubNYGY2jqAqF8+kHrivs8kT+ROvGvq/omyFx6GiYzqnh
         2HFIhB+NVMjgQxOjfu7xbPQLIRCzspV8NJf8VjKSPTDxgkMvVCPk7/5bkBeytyd4UZ3g
         nvxpwS5oICYNm4lV3uFPcMoYAXHHXPd6xQUHQRffNQmcC4ERg/4fgc/qsJtYGU/9DGZP
         TTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OQdnNmzv4usFcCEslqJZULlg/FXfYALoeT9o7toWf+k=;
        b=T5zub0m8uJmAQAo+ssw7bK8lTOsaXHzSLRAFOIdNFXqyWJXd66amZe9DE8+oq5kIJ6
         Ep12LV0sTA451cLVdNsi1BogPmy2zdlsHLAlvvkdK9Yjdb1wdcGkjox6FAGQgcPu6fIA
         a3EDNzoBo5s0UP1wKx9+0c9BEv7cIYvPyF3Ekg/vtaM6DtvYTY9DqT9tDp78ZhEPD7VU
         EExI3Fs1vK77Ru2/NaCEfZxw987SLwjzr/5lQsay5bnkV0VB8hbFl9fzBnChncGle2Kr
         UboAKP8LE5ppKkAoaND/pt3fmMCQIpX4nte2NBD9wgNeKTaJE/PJxrTJzWbQXJQyFyAp
         HLrQ==
X-Gm-Message-State: AOAM530bAlNSi4RiaRA0l01OitEJrtKTnK65IbsERMKvV5rGWRh8IXTb
        hSgvoLqjD+3cTLXr8mIOBLZxBxtDc4qJk29UvUZ4sQ==
X-Google-Smtp-Source: ABdhPJyFwC10hGfB50VlWpxYYTkP/wq9NopFODyumnAGFAWmCLhvv/zUfhxhlo8Okdy8beVJXyf/MQoiY2U1PO5ibCw=
X-Received: by 2002:a81:a93:0:b0:2f4:d65a:d44e with SMTP id
 141-20020a810a93000000b002f4d65ad44emr20076337ywk.243.1651695481261; Wed, 04
 May 2022 13:18:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220429203644.2868448-1-samitolvanen@google.com>
 <YnKnLyyXPJl5Llc0@FVFF77S0Q05N> <CABCJKudT9r=r0an4BwNp0-E1wC94wLWiHvUX4_vA8tDkQ=uHKQ@mail.gmail.com>
In-Reply-To: <CABCJKudT9r=r0an4BwNp0-E1wC94wLWiHvUX4_vA8tDkQ=uHKQ@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 4 May 2022 13:17:25 -0700
Message-ID: <CABCJKuc-6daZd8N6hQV6i_TtCtVpfzxJ2UW6xwxC2vxTmJ2deg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/21] KCFI support
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 4, 2022 at 9:41 AM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> Hi Mark,
>
> On Wed, May 4, 2022 at 9:18 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > I wanted to give this a spin on arm64, but I'm seeing some very odd toolchain
> > behaviour. I'm not sure if I've done something wrong, or if I'm just hitting an
> > edge-case, but it looks like using -fsanitize=kcfi causes the toolchain to hit
> > out-of-memory errors and other issues which look like they could be memory
> > corruption.
>
> Thanks for the detailed bug report! It definitely looks like something
> is wrong with the recent switch from std::string to Twine in the Clang
> code. I didn't see this issue when compiling the arm64 kernel, but
> I'll take a closer look and see if I can reproduce it.

I was able to reproduce this by turning off assertions in Clang. It
seems to work fine with -DLLVM_ENABLE_ASSERTIONS=ON. I'll go fix.

Sami
