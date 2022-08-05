Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CDFC00140
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Aug 2022 14:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240957AbiHEO14 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Aug 2022 10:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238458AbiHEO1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 10:27:54 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2675528718
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 07:27:52 -0700 (PDT)
Received: from zn.tnic (p200300ea971b986e329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:986e:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8FD721EC04E4;
        Fri,  5 Aug 2022 16:27:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1659709666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ECr7IjNcewMTtl4rJhJ+gDNquePCsr57H61O6zhbSgA=;
        b=DnB3TGi5laEcx99MrvrLgWfsoJEOm6gndXW8fAMyFDXsVIdsFo/wTbodBIT2J8Aq1HDcHq
        RAX3v4dbzhQKi6MvJtxhEjgFil39UBq0DD5T9vE3kbRwelMPULrjC+Kr4s/UrOMZfGZbAu
        NDmsCvmu0wQKZvTKgv3XZsNHRpoeVHk=
Date:   Fri, 5 Aug 2022 16:27:40 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Rik van Riel <riel@surriel.com>
Cc:     Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v3] x86,mm: print likely CPU at segfault time
Message-ID: <Yu0o3J2T5QwKtoan@zn.tnic>
References: <20220805101644.2e674553@imladris.surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220805101644.2e674553@imladris.surriel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 10:16:44AM -0400, Rik van Riel wrote:
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index fad8faa29d04..c7a5bbf40367 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -769,6 +769,8 @@ show_signal_msg(struct pt_regs *regs, unsigned long error_code,
>  		unsigned long address, struct task_struct *tsk)
>  {
>  	const char *loglvl = task_pid_nr(tsk) > 1 ? KERN_INFO : KERN_EMERG;
> +	/* This is a racy snapshot, but it's better than nothing. */
> +	int cpu = raw_smp_processor_id();

Please read this in exc_page_fault() and hand it down to helpers.

Alternatively, I'm being told there's a patchset in the works which
will allow for any exception handler to pass in additional information
downwards through an extended pt_regs. Then, saving the CPU number on
which the handler is running would work generically everywhere.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
