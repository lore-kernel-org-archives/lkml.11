Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A384FC4167D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 12:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381739AbiDEL71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 07:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245068AbiDEIxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:53:05 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B75103E;
        Tue,  5 Apr 2022 01:51:01 -0700 (PDT)
Received: from zn.tnic (p2e55dff8.dip0.t-ipconnect.de [46.85.223.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A27331EC03D2;
        Tue,  5 Apr 2022 10:50:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1649148655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0ktS2SIjmKrtK22LLClo6EqQScwdtGgTFjzqLBa5r/k=;
        b=lmleDHRM0KvhUep7AsjnLgP+qh35HqZQnDNl1VigAi/Fmg+AJ7FGFoXdm30SWJE0b59YjQ
        slYIKd0SpjaYbnip4EKof+r/bjKVht4u7aLKkDriIVAc7a6tcLCfN55oanq5KiHaFWW/HX
        70nm8ixMWRIn7qbJuViWP4LM64za0O4=
Date:   Tue, 5 Apr 2022 10:50:53 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Mike Travis <mike.travis@hpe.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steve Wahl <steve.wahl@hpe.com>, x86@kernel.org,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v3 0/3] x86/platform/uv: UV Kernel support for UV5
Message-ID: <YkwC7TCRMM0ejFvh@zn.tnic>
References: <20220318224304.174967-1-mike.travis@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220318224304.174967-1-mike.travis@hpe.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 05:43:01PM -0500, Mike Travis wrote:
> Mike Travis (3):
>   x86/platform/uv: Update NMI Handler for UV5
>   x86/platform/uv: Update TSC sync state for UV5
>   x86/platform/uv: Log gap hole end size
> 
>  arch/x86/kernel/apic/x2apic_uv_x.c | 20 +++++++++++++++-----
>  arch/x86/platform/uv/uv_nmi.c      | 21 +++++++++++----------
>  2 files changed, 26 insertions(+), 15 deletions(-)

All three zapped from tip until

  https://lore.kernel.org/r/87zgl02w6v.ffs@tglx

is resolved.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
