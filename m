Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E38C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 13:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356029AbiDLN3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 09:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357703AbiDLN3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 09:29:07 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2095BC0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 06:26:37 -0700 (PDT)
Received: from zn.tnic (p200300ea971b584e329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:584e:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A9B881EC04D6;
        Tue, 12 Apr 2022 15:26:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1649769991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kv9jJsZZOOjBPt8MqkxzQ1hiZv0aEzxc0WidMPbYFyg=;
        b=k4s0zrPUVsVhx0XLqef71gl/YkOyGtyFfbmaIQvwCVrgDIvaYSR5VRIeIiiJSFYMURARBE
        ooDr1s93VPb51x5nc8+8ME1LugiulOMRlQ7EHKx2sWWjO+pSf2xLTLj1IP/tLGJVehefM+
        JZiJOlXCwnQr185oUW23SHODNGmGQos=
Date:   Tue, 12 Apr 2022 15:26:31 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH V5 3/7] x86/entry: Move PUSH_AND_CLEAR_REGS out of
 error_entry()
Message-ID: <YlV+B8faRD2lDoO3@zn.tnic>
References: <20220412121541.4595-1-jiangshanlai@gmail.com>
 <20220412121541.4595-4-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220412121541.4595-4-jiangshanlai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 08:15:37PM +0800, Lai Jiangshan wrote:
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> 
> error_entry() doesn't handle the stack balanced.

What does that mean?

> It includes
> PUSH_AND_CLEAR_REGS which is commonly needed for all IDT entries and
> can't pop the regs before it returns.
> 
> Move PUSH_AND_CLEAR_REGS out of error_entry() and make error_entry()
> works on the stack normally.
> 
> After this, XENPV doesn't need error_entry() since PUSH_AND_CLEAR_REGS
> is moved out and error_entry() can be converted to C code in future
> since it doesn't fiddle the stack.

This is not a justification for this size increase:

   text    data     bss     dec     hex filename
16060616        128131358       36384888        180576862       ac3625e vmlinux.before
16065626        128131358       36380792        180577776       ac365f0 vmlinux.after

~5K text increase already with my tailored config.

You can have a asm_error_entry(), written in asm, which does the regs
pushing and which calls error_entry() - the latter being the C version.
And no need for the size increase.

For example.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
