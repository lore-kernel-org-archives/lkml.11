Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1778BC433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Jul 2022 13:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbiGEN4O (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Jul 2022 09:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbiGENzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 09:55:46 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A8C26F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 06:36:56 -0700 (PDT)
Received: from zn.tnic (p200300ea970ff682329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:970f:f682:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6F3531EC04E4;
        Tue,  5 Jul 2022 15:36:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1657028210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=GFZB6hQrFUj7F40WxfxetMyblgqJcf/FkHxEIUACZKI=;
        b=UXJSGTGPhKfbk/vTKth2c8W3kodpAwNsuy1N1adOQUCmwhQ+doBPisYXvL2+tJHpAO4SRy
        PZ2fcdm+R9pMMiuJzsvZXRgGd5Xc1qywRkYAfD59K8FhCTpvmodBn1cHTbaLuikehq0QiE
        x5aSzTULghRklPcujE5oJPxb81LwGBc=
Date:   Tue, 5 Jul 2022 15:36:46 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Jan Beulich <jbeulich@suse.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Andrew Lutomirski <luto@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Juergen Gross <jgross@suse.com>
Subject: Re: Ping: [PATCH] x86/PAT: have pat_enabled() properly reflect state
 when running on e.g. Xen
Message-ID: <YsQ+brh7hisR5f2Y@zn.tnic>
References: <9385fa60-fa5d-f559-a137-6608408f88b0@suse.com>
 <dff7bcd3-affc-9272-81e9-d686d9c997d5@suse.com>
 <8756355c-b586-3d1b-531c-72a04a8c047a@leemhuis.info>
 <05b5e672-0a1b-2d00-a879-b5127a94973f@suse.com>
 <4c8c9d4c-1c6b-8e9f-fa47-918a64898a28@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4c8c9d4c-1c6b-8e9f-fa47-918a64898a28@leemhuis.info>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 12:57:18PM +0200, Thorsten Leemhuis wrote:
> Side note: Juergen Gross recently posted related patches in this code
> area to fix some other problems (regressions?), but his efforts look
> stalled, too:
> https://lore.kernel.org/all/ddb0cc0d-cefc-4f33-23f8-3a94c7c51a49@suse.com/

I'm still waiting for a resumbission of this:

https://lore.kernel.org/r/20220620113441.23961-1-jgross@suse.com

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
