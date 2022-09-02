Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D57C6FA81
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Sep 2022 05:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiIBFe4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Sep 2022 01:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234836AbiIBFew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 01:34:52 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302E2B7281
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 22:34:42 -0700 (PDT)
Received: from nazgul.tnic (dynamic-089-204-154-243.89.204.154.pool.telefonica.de [89.204.154.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AB9A51EC0666;
        Fri,  2 Sep 2022 07:34:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1662096877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=PY8GamaQGdAxNHbT0Ql8bAobnLY8aY6VMZJwbiIW+s4=;
        b=JlksdLwb0ASeE8eR+yB6tc3C7bN0SvYovWMpLyPVAscvg59Pg0IA7eON8XZWIGo75D8Z5H
        RUPIaDCXdm2EItN0zeaEsaZSwg/P/6YGprJvd9+Sr9ry3EuUAe92z/keCn9U/3420l3wJ2
        33KJshSqGC31XK6n4qdZIMgGHzSzeWc=
Date:   Fri, 2 Sep 2022 07:34:42 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, David Howells <dhowells@redhat.com>,
        Jan Beulich <JBeulich@suse.com>,
        Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        Joe Perches <joe@perches.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [PATCH v6 0/2] x86/asm/bitops: optimize ff{s,z} functions for
 constant expressions
Message-ID: <YxGV33HTiWQ39Bkp@nazgul.tnic>
References: <20220511160319.1045812-1-mailhol.vincent@wanadoo.fr>
 <20220831075742.295-1-mailhol.vincent@wanadoo.fr>
 <Yw8hJS9f6SofG4/6@yury-laptop>
 <YxArx4UGoSQXljQd@yury-laptop>
 <CAMZ6Rq+XVWGEEHr9t5dkXN0E36hkpMb5kNEZJmMFgtJxyQntsg@mail.gmail.com>
 <YxC+eShQLDor0B9D@yury-laptop>
 <CAKwvOd=xWEc9T=RQcZDuHNMtng+pODa2SXs9iOmPWdJ5coPBaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOd=xWEc9T=RQcZDuHNMtng+pODa2SXs9iOmPWdJ5coPBaA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 10:06:48AM -0700, Nick Desaulniers wrote:
> Unless Boris feels strong enough to nack the series, I think Yury
> accepting the series is the way to go.

arch/x86/ patches go through the tip tree unless there's a compelling
reason to carry them through another. I don't see one here.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
