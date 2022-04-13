Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B218C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Apr 2022 08:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233895AbiDMIma (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Apr 2022 04:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234051AbiDMImO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 04:42:14 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D73D52E5A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 01:39:04 -0700 (PDT)
Received: from zn.tnic (p200300ea971b584e329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:584e:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5146E1EC0576;
        Wed, 13 Apr 2022 10:38:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1649839138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=xJtHo7qlVLj4R9BlhYdXBhPmuTz01FJYh4CZpGUEmNY=;
        b=Xb9Fpgbi7/UcNOfNvKbnSXWHMw8k00Rw1VCe5uNxj6PIZwc5hPzFEeNhxHFiw3Gh2vIBMb
        k/En5glzoNKR7iUI7LgJ1D6S9KdjfIwKBwCo3dzR69nHYipWftuDJkEpskB5IuN9mqcziw
        bmERw1mMnLp5kd2sSVM/GQINbnNcqdk=
Date:   Wed, 13 Apr 2022 10:39:01 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH V5 3/7] x86/entry: Move PUSH_AND_CLEAR_REGS out of
 error_entry()
Message-ID: <YlaMJehKIxXM/Aui@zn.tnic>
References: <20220412121541.4595-1-jiangshanlai@gmail.com>
 <20220412121541.4595-4-jiangshanlai@gmail.com>
 <YlV+B8faRD2lDoO3@zn.tnic>
 <CAJhGHyAsPZAeXUoOa5LJ5bxuMOWzg=cvYNYPVT9kpBM7Tsf3xA@mail.gmail.com>
 <YlWNIj198mKM3hMG@zn.tnic>
 <CAJhGHyC7KUj=s+w+isBewdL7iyUyEm4h++rWRoz2zBc0zAD2gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJhGHyC7KUj=s+w+isBewdL7iyUyEm4h++rWRoz2zBc0zAD2gw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 11:48:21AM +0800, Lai Jiangshan wrote:
> I meant the real .entry.text size is unchanged.  No matter what
> the complied .entry.text size is, 5.5k before the patch, or 8.2k
> after the patch, the size of .entry.text in the kernel is always 2M.

Yes, unless the bloat I'm talking about above continues and then it
becomes 4M. So we need to be careful.

> I will follow your instructions and add an extra ASM function.

Thx.

> And maybe add this to the changelog:
> 
> A function call is added for every interrupt or exception, but it

I think you need to read submitting-patches.rst again:

"Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
to do frotz", as if you are giving orders to the codebase to change
its behaviour."

In your case:

"Add a function call..."

> is a low-level asm function call and actually, only a "call" and a
> "ret" instructions are added.

CALL, RET - all x86 insns in caps.

> It will enable error_entry() to be

It will allow for sync_regs() to be converted to C...

> C code that can use inlined sync_regs() and save a C function call
> which will reduce more instructions in return.
> 
> I'm also waiting for reviews for other patches and I'm not going to
> send this new code too soon since I don't want to send a new revision
> with only this patch updated.

Again, submitting-patches.rst:

"After you have submitted your change, be patient and wait.  Reviewers are
busy people and may not get to your patch right away.

...

You should receive comments within a week or so; if that does not
happen, make sure that you have sent your patches to the right place.
Wait for a minimum of one week before resubmitting or pinging reviewers
- possibly longer during busy times like merge windows"

So you send, wait for feedback, incorporate it and resend after a week,
but not earlier.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
