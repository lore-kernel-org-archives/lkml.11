Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56839C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Feb 2022 15:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242519AbiBQPb2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Feb 2022 10:31:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242517AbiBQPbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 10:31:22 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2922B2C73
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 07:31:06 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 80E931EC05ED;
        Thu, 17 Feb 2022 16:31:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1645111861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=mVGSrz/E5c9qGSm3I3kFADQVW9P+q45aYXq9eDC7Odg=;
        b=WyvXD0aAP48qsuvUznb0TtPpqOvg99pBXnzS4vUdjpA+qhqfVSes/GAegvVw1ZzDIBFO3M
        AEUlqKyWvET0R3ReLXYosmF7rXKIWtQnsKR2Offw1+geNktU83b7leysvi3XMWrffbYhIs
        8rYUh/BjFWsqXPmVupv7gt3w0GAWjnE=
Date:   Thu, 17 Feb 2022 16:31:07 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sean Christopherson <seanjc@google.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@intel.com, luto@kernel.org,
        peterz@infradead.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        aarcange@redhat.com, ak@linux.intel.com, dan.j.williams@intel.com,
        david@redhat.com, hpa@zytor.com, jgross@suse.com,
        jmattson@google.com, joro@8bytes.org, jpoimboe@redhat.com,
        knsathya@kernel.org, pbonzini@redhat.com, sdeep@vmware.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCHv2 00/29] TDX Guest: TDX core support
Message-ID: <Yg5qO3Kfd1H8WwD4@zn.tnic>
References: <YgOoId+vyd1VhIqQ@zn.tnic>
 <20220210004831.03dea501738bee060003d040@intel.com>
 <YgOr6tZjsooJgAi9@zn.tnic>
 <YgPwwI2+16/7jQC4@google.com>
 <YgQR/S67Fqz9PanR@zn.tnic>
 <YgQfGKXOemtXnFau@google.com>
 <YgQl6Uk9rONgv9+F@zn.tnic>
 <20220216154809.w27bt6oi3ql4ssip@black.fi.intel.com>
 <Yg5nh1RknPRwIrb8@zn.tnic>
 <Yg5pvO1nXo6qQP9C@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yg5pvO1nXo6qQP9C@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 03:29:00PM +0000, Sean Christopherson wrote:
> FWIW, I don't think there's much existing SEV host virtualization stuff that can
> be moved without first extracting and decoupling it from KVM, which will be
> non-trivial.  I do want to do that some day, but it definitely shouldn't hold up
> merging SNP.

Oh sure, code movement is lowest prio so whenever you feel like it.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
