Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18F3C433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Apr 2022 18:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245428AbiDCSsj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Apr 2022 14:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234612AbiDCSsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 14:48:36 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C473207A;
        Sun,  3 Apr 2022 11:46:39 -0700 (PDT)
Received: from zn.tnic (p2e55dff8.dip0.t-ipconnect.de [46.85.223.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E98FD1EC03C9;
        Sun,  3 Apr 2022 20:46:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1649011594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2HjVlEdlul+lX8f7wTuHDWSA2vrSz2EQiEfHXKjpjQA=;
        b=l59mXDjKhhUMPxGyiKT5DqGFArOaluj0rtOErU/Kmc6OR2Ykb0xgnSdo4Eyi1AISV5hs9z
        nw71ZvTedtXnzJMSILspBrlQg/TyemPcww0YQ225kU6gjbNS+er+UNOAhCEmtTd9/JsczC
        ipHhGjzNthdXa7Cj9jj7Qw1YsbxIdYU=
Date:   Sun, 3 Apr 2022 20:46:30 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Linux Edac Mailing List <linux-edac@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stable Kernel <stable@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        x86 Mailing List <x86@kernel.org>
Subject: Re: [PATCH v6 2/2] x86/MCE/AMD: Fix memory leak when
 `threshold_create_bank()` fails
Message-ID: <Yknrhk5EjMLxraIU@zn.tnic>
References: <20220329104705.65256-1-ammarfaizi2@gnuweeb.org>
 <20220329104705.65256-3-ammarfaizi2@gnuweeb.org>
 <87wng6ksjl.ffs@tglx>
 <215ca9e7-b719-d5b8-c6db-1d71544d47be@gnuweeb.org>
 <00347b4a-e719-9dac-b42b-05a3f117fd46@gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <00347b4a-e719-9dac-b42b-05a3f117fd46@gnuweeb.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 12:45:04AM +0700, Ammar Faizi wrote:
> > Yazen, Borislav, please take a deeper look on this again. I will send
> > a v7 revision to really make it simpler by moving that "per-CPU var write"
> > before the loop.
> 
> (only if it's really safe)

Don't bother - I've discussed it with tglx offlist. The current solution
remains.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
