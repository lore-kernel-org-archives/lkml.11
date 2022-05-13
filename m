Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5527BC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 13 May 2022 17:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382771AbiEMRMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 May 2022 13:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382339AbiEMRMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 13:12:43 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EA049F11
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 10:12:42 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4C3101EC071C;
        Fri, 13 May 2022 19:12:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1652461957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=anRexSde4N3xzuM4Gc8q5syTIt1lzd8N4liRy6D1N/E=;
        b=P/4fmKKWDTBSM+0OtvF/AiA7odlqnnvgLvGfXqFjEWhXvFDtVMOtSx+2oaRGTK4DDc8H6O
        NS5adJpNFiIrTvbhsk/bClbQqMWMkyA7eLWp/7Q/ePtcrRGTMTsUdpuD4dCB9syPqHAAd0
        DB4wWamblKdNE6SweJnUo5vR4A6Tza0=
Date:   Fri, 13 May 2022 19:12:38 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <oliver.sang@intel.com>,
        Eric Biggers <ebiggers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [x86/uaccess] 9c5743dff4:
 WARNING:at_arch/x86/mm/extable.c:#ex_handler_fprestore
Message-ID: <Yn6Rhv+VhZlVpOjt@zn.tnic>
References: <20220513085455.GB21013@xsang-OptiPlex-9020>
 <CAHk-=wjDE7tWc5k81P41AKw9b13ehrTX8XawgnP-wa6fA57kuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjDE7tWc5k81P41AKw9b13ehrTX8XawgnP-wa6fA57kuA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 09:52:08AM -0700, Linus Torvalds wrote:
> On Fri, May 13, 2022 at 1:55 AM kernel test robot <oliver.sang@intel.com> wrote:
> >
> > FYI, we noticed the following commit (built with gcc-11): commit
> > 9c5743dff415 ("x86/uaccess: fix code generation in put_user()")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

Err, is this seriously a report for a 5.9-something kernel?

[  266.828722][    T1] CPU: 0 PID: 1 Comm: init Not tainted 5.9.0-13419-g9c5743dff415 #1

> >
> > in testcase: boot
> >
> > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> >
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):

Can you reproduce the same with the latest Linus master or tip/master or
something current...?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
