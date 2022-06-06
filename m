Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E22CC433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jun 2022 22:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbiFFWSA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jun 2022 18:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbiFFWR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 18:17:57 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1346D387
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 15:17:55 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:59062)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nyL2o-004rGO-Ko; Mon, 06 Jun 2022 16:17:54 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:53764 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nyL2n-006zvT-Nh; Mon, 06 Jun 2022 16:17:54 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Brian Gerst <brgerst@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20220606203802.158958-1-brgerst@gmail.com>
Date:   Mon, 06 Jun 2022 17:17:47 -0500
In-Reply-To: <20220606203802.158958-1-brgerst@gmail.com> (Brian Gerst's
        message of "Mon, 6 Jun 2022 16:37:54 -0400")
Message-ID: <87ilpd1lo4.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nyL2n-006zvT-Nh;;;mid=<87ilpd1lo4.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX19k9RHjFh4Bj2VKT8cIZOyM6JG4gRwQuIw=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 0/8] x86 signal code cleanups
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst <brgerst@gmail.com> writes:

> The 32-bit signal code has significant differences from 64-bit, and
> those are duplicated for native and compat modes.  This patch series
> merges the 32-bit code into one file, and does some general cleanups
> in the x86 signal code.  There should be no functional changes.

At a quick skim I don't see anything scary in there.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

> Brian Gerst (8):
>   x86/signal: Remove sig parameter from frame setup functions
>   x86/signal: Remove sigset_t parameter from frame setup functions
>   signal/compat: Remove compat_sigset_t override
>   x86: Remove __USER32_DS
>   x86/signal: Merge get_sigframe()
>   x86/signal: Add ABI prefixes to frame setup functions
>   x86/signal/32: Merge native and compat 32-bit signal code
>   x86/signal/64: Move 64-bit signal code to its own file
>
>  arch/x86/entry/entry_64_compat.S              |   4 +-
>  arch/x86/ia32/Makefile                        |   2 -
>  arch/x86/include/asm/elf.h                    |   4 -
>  arch/x86/include/asm/fpu/signal.h             |   7 -
>  arch/x86/include/asm/segment.h                |   2 +-
>  arch/x86/include/asm/sighandling.h            |   9 +
>  arch/x86/include/asm/signal.h                 |   5 -
>  arch/x86/kernel/Makefile                      |   4 +-
>  arch/x86/kernel/signal.c                      | 654 +-----------------
>  .../ia32_signal.c => kernel/signal_32.c}      | 117 ++--
>  arch/x86/kernel/signal_64.c                   | 383 ++++++++++
>  arch/x86/xen/xen-asm.S                        |   8 +-
>  include/linux/compat.h                        |   2 -
>  include/linux/syscalls.h                      |   2 +
>  14 files changed, 493 insertions(+), 710 deletions(-)
>  rename arch/x86/{ia32/ia32_signal.c => kernel/signal_32.c} (82%)
>  create mode 100644 arch/x86/kernel/signal_64.c

Eric
