Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616C9C433FE
	for <linux-kernel@archiver.kernel.org>; Thu,  5 May 2022 16:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382104AbiEEQz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 May 2022 12:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiEEQz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 12:55:56 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03914AE0C
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 09:52:16 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-2f7b815ac06so55389077b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 09:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rfQ3wFLudSyAVcYhy/IDVjHP+wEQPyVpR9aHM7jrE7Y=;
        b=sw3JZLlEUvxXIbfiDbppduUwHQVv6t31IHX3OJUdmm5PWZiRUlPNBf9uXc7UUhU9kj
         n8wK3fbAWAbgSJ1ONS7xcHkFXO/ISm/HxkLEnSdYQ0ALSOw/4dXaZtfNOy/h0ta55j1l
         /wlHmLGGFrORYBuO21cB+SuthyaGjBCAt9vfgldo8hBl1LHw30uomfMRdy1RkOQuBXV1
         pFUdSC9vpKmlpearNwbAp4MJ1G2cekiVhy4x2tt3zSPBLRRLDI2Y2y4f6DF5D41aVVcR
         cv0xveIl05fCjWu/Ur8j+9hYaccDQM7tZgXJDkt9xpl4Lc60ZQGUmW3llEBLobh41X12
         oKGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rfQ3wFLudSyAVcYhy/IDVjHP+wEQPyVpR9aHM7jrE7Y=;
        b=1G7N2q1TBj8yl2xt1N/eEwWgH62cq96tbLWiSUeAp38NKuIEgmDxTSwDDfLa6j+wB3
         FzkE80hycxiidlsOVrhTQNo1oNO3hJmOUorWt45li8uroxJnKjzGvq7fjHuiKa0MQCZ7
         UYDOpeCMTqcsq04ET2X//l+xgmPkVzBfk+wIWGRF/Dyni1rCGa6ty+d2aZseLNtb7vOc
         hucqq8iBx/EnaxyI1ov3uz/8MlE80Vsxl9VRTKMuO8sGlfZPRPK31O+e1ZCbIs+AzQJJ
         +RqENcqEEHBjc9x7PbQyH86oSCEHRCLOpmT8ObTasliY1q5+ZpCsKl78uF1sfXRBm6qs
         +cSg==
X-Gm-Message-State: AOAM530n37l/6vUzEV/cQHkoUlUKDUZmf0/58VbRNQpQZeR2SkTq+KNF
        3Pelnn3iLiyGsH7qA5p9BukorEhE1eD7hY3C+uT4AQ==
X-Google-Smtp-Source: ABdhPJxqdsh6bV7V24MiWF4uRoLFGHvOE5bi1VIjMq8PKIRH504kLGElnVgYclES0yuQ69mZYQ1KYQ8QktHfyMj1P3E=
X-Received: by 2002:a81:1108:0:b0:2f7:bf11:3fb9 with SMTP id
 8-20020a811108000000b002f7bf113fb9mr25421990ywr.305.1651769535660; Thu, 05
 May 2022 09:52:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220429203644.2868448-1-samitolvanen@google.com>
 <20220429203644.2868448-11-samitolvanen@google.com> <YnP7j+miotxYM6fu@FVFF77S0Q05N.cambridge.arm.com>
In-Reply-To: <YnP7j+miotxYM6fu@FVFF77S0Q05N.cambridge.arm.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Thu, 5 May 2022 09:51:39 -0700
Message-ID: <CABCJKue6c0FMpKXysdoT0Lc+RBqGFhp52iM03tttWwRv7CZr5w@mail.gmail.com>
Subject: Re: [RFC PATCH 10/21] treewide: Drop function_nocfi
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

On Thu, May 5, 2022 at 9:30 AM Mark Rutland <mark.rutland@arm.com> wrote:
> I also believe that in most cases we can drop the __nocfi annotation on callers
> now that we can mark the called assembly function with SYM_TYPED_FUNC_START().

Good point, thanks for pointing that out. I'll add these to the next
version of the series.

> There' a latent bug here with the existing CFI scheme, since
> `kpti_install_ng_mappings` isn't marked with __nocfi, and should explode when
> calling `idmap_kpti_install_ng_mappings` via the idmap.

The CONFIG_UNMAP_KERNEL_AT_EL0 version of kpti_install_ng_mappings is
marked __nocfi

> There' a latent bug here with the existing CFI scheme, since
> `machine_kexec` isn't marked with __nocfi, and should explode when calling
> `cpu_soft_restart` via the idmap.

But it's indeed missing from this one.

Sami
