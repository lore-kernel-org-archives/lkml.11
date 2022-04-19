Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6029AC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Apr 2022 10:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348425AbiDSKEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Apr 2022 06:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238681AbiDSKEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 06:04:06 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78C912A88
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 03:01:23 -0700 (PDT)
Received: from zn.tnic (p200300ea971b58fe329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:58fe:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4F9FE1EC0426;
        Tue, 19 Apr 2022 12:01:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1650362478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=i5Rt9cu26UqytBv7dPuzAEnJ77vRdXwejI5bMj+S6cI=;
        b=awS4CupNw+1X74RsWf+L+SCHMFRh1txBXaKDHyVW1VW8IdrDZMBQWqWSWMIYs0dt8p+sSd
        z12vRQMj7cIsFAsi/ra1Oa1m2lYJeNv+KaBlL1AIWgYxzNeCARa38MoyhZPodIS/WIjqEp
        D0Gak87okmGLv9T3l3Fbji24YUHOyPI=
Date:   Tue, 19 Apr 2022 12:01:14 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/cpu: Add new Alderlake and Raptorlake CPU model
 numbers
Message-ID: <Yl6Iai0/Z9lfxRMP@zn.tnic>
References: <20220310215652.32025-1-tony.luck@intel.com>
 <20220330134325.GM8939@worktop.programming.kicks-ass.net>
 <29d602962d6542bd90e877c104afcc7f@intel.com>
 <YlS7n7Xtso9BXZA2@agluck-desk3.sc.intel.com>
 <20220419085603.GO2731@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220419085603.GO2731@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 10:56:03AM +0200, Peter Zijlstra wrote:
> Let's hope our marketing team will stick with these names for a little
> while atleast :/

I'm waiting for the day when they run out of lakes and we and up doing

 #define INTEL_FAM6_LAKELAKE          0xff

:-P

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
