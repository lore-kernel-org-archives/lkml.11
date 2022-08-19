Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CBAC28B2B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Aug 2022 18:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350113AbiHSSOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Aug 2022 14:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349863AbiHSSNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 14:13:41 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AF7F598
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 11:06:31 -0700 (PDT)
Received: from zn.tnic (p200300ea971b9849329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:9849:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A40981EC05DE;
        Fri, 19 Aug 2022 20:06:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1660932385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yWTAxYR9KH75n49ElLnqIVZz2Mc7ASC4iPtAzIRcuTE=;
        b=ZvljxHZoFY+2yAfgt/CEkO8wkvT6j08KcO8s8T+d/N0mn37IFRC2UIj67KEjwykFpNEaEx
        01GZH7FMyQY9EDYzfzEoO5ns3utYEX3Zfjti1MldvdBFmbUYp8GpguIP83ZtnQVH1k/nti
        o4y3LY/YpWI5f2xAulSV9tfzjclrlGo=
Date:   Fri, 19 Aug 2022 20:06:21 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Zhihao Lin <zh.lin@mail.utoronto.ca>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Logging Behavior under arch/x86/kernel
Message-ID: <Yv/RHa3fCwVhDaIo@zn.tnic>
References: <YT3PR01MB87565C391CB407D2BB49BB3BA06D9@YT3PR01MB8756.CANPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YT3PR01MB87565C391CB407D2BB49BB3BA06D9@YT3PR01MB8756.CANPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Aug 18, 2022 at 03:08:44PM +0000, Zhihao Lin wrote:
> 2. At the end of wakeup_secondary_cpu_via_init, send_status is
> checked and given an error-level log message. However, according
> to the control flow analysis, it is unclear that which of
> safe_apic_wait_icr_idle (line 870 or line 918) is checked because
> the loop (which contains the third call) may or may not execute.

Well, does it matter which is checked?

AFAICT, it always checks the right one. :-)

> In this case, my tool alerts that this log statement doesn’t provide
> sufficient information for error diagnostic.

The pr_err() calls at the end of the function do catch the case when
either send_status or accept_status are != 0.

> pci_write_config_dword
> 
>   *   arch/x86/kernel/amd_nb.c

That has been probably overlooked during review. If we had to be
pedantic, we should check all those retvals. I guess not that
important...

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
