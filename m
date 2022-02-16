Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9935C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Feb 2022 18:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237891AbiBPSxR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Feb 2022 13:53:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237866AbiBPSxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 13:53:13 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B1616041E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 10:53:01 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E80DC1EC0529;
        Wed, 16 Feb 2022 19:52:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1645037576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Tv2WpngyBiNluh/VuV6xl+yPEIiPp/meijatzd5qsZ0=;
        b=UuzZBvIGMXFHEr16Oh7C9uy60PmWEGkUg4CtM97vw5J7oF+OiwvkEyOritaYHm0SnyBmhv
        7pJlRz8hVe0kEz3vTxMe0kUTb1xsyGFZvGBgxnKZUj5+b+5WVjGzrx4V3rjXBVnwrSGQVP
        BLMTmMU39TAzWVUOonk4lEGfkNWB8NI=
Date:   Wed, 16 Feb 2022 19:52:58 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Jue Wang <juew@google.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH] x86/mce: Add workaround for SKX/CLX/CPX spurious machine
 checks
Message-ID: <Yg1ICgHfMYxwHyig@zn.tnic>
References: <CAPcxDJ7nriZEJHF6dMPR7tQ+dGuueyRjw1NC+4CbjxiAT_S+ZA@mail.gmail.com>
 <20220208150945.266978-1-juew@google.com>
 <Ygwka++3eipjQzB2@zn.tnic>
 <YgwnqTc8FGG3orcE@agluck-desk3.sc.intel.com>
 <YgzRsfWOmqkNiNI7@zn.tnic>
 <CAPcxDJ4=iknzYbN=b2oQxvJyODkQ_MWEj1wkKEuGwf4HQ3aPZA@mail.gmail.com>
 <Yg08Uhg0fZ9xZuP2@zn.tnic>
 <9f402331d25c47b69349c8171bbd49c1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9f402331d25c47b69349c8171bbd49c1@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 06:41:58PM +0000, Luck, Tony wrote:
> > Well, we could try to decode the instructions around rIP when the #MC
> > is raised and see what caused the MCE and perhaps pick apart which insn
> > caused it, is it accessing behind the buffer boundaries, etc.
> 
> Is this a case of "perfect is the enemy of good enough"?

Well, you guys sounded like this happens left and right...

> It is a rare scenario (only a pain point for Jue because Google has
> billions and billions of cores running this code). You need:
>
> 1) An uncorrected error
> 2) That error must be in first cache line of a page
> 3) Kernel must execute page_copy from the page immediately before that page
> 
> 	When all three happen, kernel crashes because we don't
> 	have a recover path from kernel page_copy

You should've lead with that - this is basically one of those "under a
complex set of conditions" things.

Anything against me adding them to the commit message?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
