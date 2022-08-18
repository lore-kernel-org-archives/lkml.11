Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5AAC00140
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Aug 2022 14:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343817AbiHROzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Aug 2022 10:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343732AbiHROzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 10:55:04 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A0FBC83B
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 07:55:03 -0700 (PDT)
Received: from zn.tnic (p200300ea971b98ec329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:98ec:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DD6921EC0529;
        Thu, 18 Aug 2022 16:54:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1660834497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=DDeh3202LXxpye1KROUbj+poyTXRskNLEAAxPoXVUmM=;
        b=dFnfJlVKRl1WdykJHlvN8j4ucpeexCeElNFUhCGEELRha1iDyL+jIByaZl3vUZUkCTzNGH
        A6MTulN+LvAFj+9YQ9TSjGsQCrcXnmBTrtkHILwvJYnQ07YlzZHn8NwCdq+r2HansIfqZO
        sAm6HPOP409T7CWw68QUIiOjv9Is8qw=
Date:   Thu, 18 Aug 2022 16:54:53 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/6] x86/tdx: Add TDX Guest attestation interface
 driver
Message-ID: <Yv5SvTssXnR0fTfS@zn.tnic>
References: <20220728034420.648314-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220728034420.648314-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <Yv5KNyX992ddvVtD@zn.tnic>
 <7e4a4746-8146-b0b2-e0b3-d32960421da6@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7e4a4746-8146-b0b2-e0b3-d32960421da6@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 07:40:51AM -0700, Sathyanarayanan Kuppuswamy wrote:
> We have a v10 version of this patch. We have dropped GetQuote support as per Dave's
> comment. If it is not a problem, for the rest of the patches in this series, please
> check v10.
> 
> https://lore.kernel.org/lkml/Yu1z0KcU5C2AJO6S@fedora/T/

Ah, I saw that but that is only 2 patches. Seems you guys went at it
with the chainsaw... :-)

Ok, will continue with it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
