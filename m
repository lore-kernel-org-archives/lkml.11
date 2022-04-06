Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548FEC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 12:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiDFNBh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Apr 2022 09:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbiDFNBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:01:10 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4A85BC1C8
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 02:26:32 -0700 (PDT)
Received: from zn.tnic (p2e55dff8.dip0.t-ipconnect.de [46.85.223.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 90CD81EC0426;
        Wed,  6 Apr 2022 11:25:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1649237147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=4cZSb3cc+Gu90BQrKaaggIaclA4W6uCeg9JKu/+H7fE=;
        b=OPQ0p0uQnCJZWG8yZP+JQxzuxibM2vDmCkRqvV7WvCxeAkvhBxP8DukTYbfViuL2uAcrg3
        x2geai0zDRVlcnAML5np+1n5PyMLnBRdmY5gS1NfXiuPuE3FlfUmmbYyRV6ODwWIirGymO
        tPatFAlJLZ/RWM2xExOCiuDIpyft8VU=
Date:   Wed, 6 Apr 2022 11:25:49 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Wyes Karny <wyes.karny@amd.com>
Cc:     linux-kernel@vger.kernel.org, Lewis.Carroll@amd.com,
        Mario.Limonciello@amd.com, gautham.shenoy@amd.com,
        Ananth.Narayan@amd.com, bharata@amd.com, len.brown@intel.com,
        x86@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
        chang.seok.bae@intel.com, keescook@chromium.org, metze@samba.org,
        zhengqi.arch@bytedance.com, mark.rutland@arm.com
Subject: Re: [PATCH] x86: Prefer MWAIT over HALT on AMD processors
Message-ID: <Yk1cnYWF+L+OgoCa@zn.tnic>
References: <20220405130021.557880-1-wyes.karny@amd.com>
 <YkxMtx9zdk+nH33r@zn.tnic>
 <c6ceb0a5-c3fa-790e-d3c7-228c71a477c2@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c6ceb0a5-c3fa-790e-d3c7-228c71a477c2@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 11:44:52AM +0530, Wyes Karny wrote:
> If x86_FEATURE_ZEN is set and X86_FEATURE_MWAIT is not set or has
> X86_BUG_MONITOR then it won't return correct value.

Can that ever happen on Zen uarch?

Also, what does this mean: "allow MWAIT early on."?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
