Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD21C433FE
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Mar 2022 16:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240753AbiC1QD1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Mar 2022 12:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238088AbiC1QDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 12:03:24 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F186226ADF
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 09:01:43 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id b130so11159229pga.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 09:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8Gd1mrZiQOq3smqLlHqwKW871rQ12hCh1YJ0GNZOHYE=;
        b=TrjSxQqoq2V/zaVRUVmSd509ZbzvmP9G/rPfqEw958xRKal/oCddaFt9mZTwpiStt6
         T7i7jI0YEJ+bPWHPrOL6wm2UbnQsGp/BhD272MaNjuRcndS5qKCbDC9pKTu3Lhvkdjcy
         nVhO+/vDMFl+S+YlrJm74pvhlS92O00zdMHRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8Gd1mrZiQOq3smqLlHqwKW871rQ12hCh1YJ0GNZOHYE=;
        b=8CUhhivQgr+uUScMLUqYIkqEBMPomikk+qHgxPETLD4KMGMvn2x5RfxONQp3+L1fgE
         V59shLl5TptBTEkKgyNMcSrVNJN5e2f6JVsmEnRq00JT2k3VG1zNbFWe+nW++BShMFxR
         COc/99TNmFVJuylHJtcDWrtAd1kPwZamjg5usAiDYszwyWQc25IuS+0rIP1N4TZfGm9z
         H5HC6l3eLo3e06TOdIF5OKzZJfvbtBv9+iBfCqLq9L3IZwGk7nuAn93Vk+gSuw8O/Ccj
         6nJR/2Hu5Fdt2rtnCD/O+zMHdgPWkuuFjJtVv6+vBxecP2snyZT0iukT86ncGZTYChBA
         xaGA==
X-Gm-Message-State: AOAM5326/s6hX9IthjONZwBC6pDOcqdo5/8FjbPKyUloD35vS0gXanAr
        AWlqbtzmWqPmxhH3PGSpxfw2Z2F8A4fsLw==
X-Google-Smtp-Source: ABdhPJx/aE4mOpcNZ94+9DP9mvByqTVOtA3KKp0T0hyrjY1SWuvPY/xWOjcqMY/IdfDGO621C3bIVw==
X-Received: by 2002:a05:6a00:2402:b0:4e1:46ca:68bd with SMTP id z2-20020a056a00240200b004e146ca68bdmr23889175pfh.70.1648483303527;
        Mon, 28 Mar 2022 09:01:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 124-20020a621682000000b004f6a2e59a4dsm16262776pfw.121.2022.03.28.09.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 09:01:43 -0700 (PDT)
Date:   Mon, 28 Mar 2022 09:01:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        George Burgess IV <gbiv@google.com>,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [GIT PULL] FORTIFY_SOURCE updates for v5.18-rc1
Message-ID: <202203280854.C36F2EC@keescook>
References: <202203251443.9BBADFD98@keescook>
 <CAHk-=wjeGc-BjkDWTYkXzyQu-vf9EEujuT-6=U7Od0DvCUfb8w@mail.gmail.com>
 <CAHk-=wid1da7CONOA4ia++vKe5pCFda6gwdafjFP4HXJQcjcsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wid1da7CONOA4ia++vKe5pCFda6gwdafjFP4HXJQcjcsA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 26, 2022 at 12:40:18PM -0700, Linus Torvalds wrote:
> On Sat, Mar 26, 2022 at 12:29 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Because if all the compiler issues and warnings have been sorted out,
> > it sounds to me like the compile-time side could/should be done
> > unconditionally if there are no runtime downsides.

Yeah, I'd like to do this. The way the header files are currently split
up makes this slightly weird, and there have been issues with some
arch/compiler combinations, so it's not quite as cut-and-dried as I'd
like. I'll investigate what it could look like.

> .. or do the existing compiler warnings for the builtins already cover
> all cases, and the only reason the fortify-source code has
> compile-time warnings is that the option takes over the builtins?

This mostly depends on the compiler version, and they often overlap, but
the new FORTIFY logic tends to be more strict (where possible) and is more
consistent; I view the two diagnostic capabilities as complementary.

-- 
Kees Cook
