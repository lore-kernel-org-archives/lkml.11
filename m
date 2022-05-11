Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469C8C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 May 2022 18:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346411AbiEKSjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 May 2022 14:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346402AbiEKSjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 14:39:18 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A78F22D62D
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 11:39:16 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9BFA91EC0535;
        Wed, 11 May 2022 20:39:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1652294351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=6dzFyppSmZn6zt5heGuDm0dKQ5cdEeD5FQNjKL9s0ew=;
        b=eohVfNTC5a4FhpqxxYH2HNi614lMl9DCVCoCie+4F7UgiCrkFP/1OQddkg7WQctGI71OAQ
        I4gEojz9hXx41fL2Fm/CdHzI618GsGRkgI22pDrv+I7yUgZdL6NIjuG4cQq1yV2mApycXv
        1gov8IS5ZZ9NaHWHVWY23ie0RbykaLE=
Date:   Wed, 11 May 2022 20:39:18 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] x86/vsyscall: Remove CONFIG_LEGACY_VSYSCALL_EMULATE
Message-ID: <YnwC1qOVmh6zOwrU@zn.tnic>
References: <898932fe61db6a9d61bc2458fa2f6049f1ca9f5c.1652290558.git.luto@kernel.org>
 <87o803dijt.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87o803dijt.fsf@oldenburg.str.redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 08:35:02PM +0200, Florian Weimer wrote:
> Regarding the mechanics, is it customary to remove the actual code (the
> EMULATE enum constant) in later commits?

It is still needed for

"Emulate mode is deprecated and can only be enabled using the kernel
command line."

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
