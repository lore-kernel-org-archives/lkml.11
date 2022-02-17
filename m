Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1592C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Feb 2022 16:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243278AbiBQQbU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Feb 2022 11:31:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235842AbiBQQbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 11:31:18 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B372F1B061E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 08:31:02 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4DAEF1EC0304;
        Thu, 17 Feb 2022 17:30:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1645115457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=GEMXnFkd4n8W4nnufiYYxj/WrSmsnfwoOjRtO415OSw=;
        b=hWwBcxGUB+kqzgL3CyVJ2V8lnTPpzOsDp4vJrTz4/KLjoqnDT6s41R+qYoZEs6ZJZRlTfA
        4ItbM1plYVjIYXzza2mYFtb/HbTowU1rjokxcx7dqjD1S469xkmvzychTlU/HjSaXOuQwN
        j1duv9I48k8O7xZyJN5uvOgsJRB9X88=
Date:   Thu, 17 Feb 2022 17:30:57 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jue Wang <juew@google.com>
Cc:     Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH] x86/mce: work around an erratum on fast string copy
 instructions.
Message-ID: <Yg54QYeiAtwJN/qU@zn.tnic>
References: <CAPcxDJ5t47M-+Bn_D+Vj7zbJTxhjrx=HsLX=iQj-EF_h2oVTsg@mail.gmail.com>
 <20220216215313.1707663-1-juew@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220216215313.1707663-1-juew@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 01:53:13PM -0800, Jue Wang wrote:
> Subject: Re: [PATCH] x86/mce: work around an erratum on fast string copy

When sending a new version of the patch, make sure you add it to the
subject so that I know which one is the newest:

[PATCH -v<INCREASING NUMBER>] x86/mce: Work around an erratum with fast string copy instructions

> +static noinstr bool quirk_skylake_repmov(void)
> +{
> +	u64 mcgstatus = mce_rdmsrl(MSR_IA32_MCG_STATUS);
> +	u64 misc_enable = __rdmsr(MSR_IA32_MISC_ENABLE);
> +
> +	// Only applies the quirk to local machine checks, i.e., no broadcast
> +	// sync is needed.
> +	if ((mcgstatus & MCG_STATUS_LMCES) &&
> +	    unlikely(misc_enable & MSR_IA32_MISC_ENABLE_FAST_STRING)) {
> +		u64 mc1_status = mce_rdmsrl(MSR_IA32_MCx_STATUS(1));
> +
> +		// The blob of logic below is checking for a software
> +		// recoverable data fetch error.
> +		if ((mc1_status &
> +		     (MCI_STATUS_VAL | MCI_STATUS_OVER | MCI_STATUS_UC | MCI_STATUS_EN |
> +		      MCI_STATUS_ADDRV | MCI_STATUS_MISCV | MCI_STATUS_PCC |
> +		      MCI_STATUS_AR | MCI_STATUS_S)) ==
> +		     (MCI_STATUS_VAL |                   MCI_STATUS_UC | MCI_STATUS_EN |
> +		      MCI_STATUS_ADDRV | MCI_STATUS_MISCV |
> +		      MCI_STATUS_AR | MCI_STATUS_S)) {
> +			msr_clear_bit(MSR_IA32_MISC_ENABLE,
> +				      MSR_IA32_MISC_ENABLE_FAST_STRING_BIT);

With CONFIG_KASAN=y and CONFIG_DEBUG_ENTRY=y:

vmlinux.o: warning: objtool: quirk_skylake_repmov()+0x4d: call to msr_clear_bit() leaves .noinstr.text section

You're going to have to use the mce_{rd,wr}msrl() routines.

> +			mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
> +			mce_wrmsrl(MSR_IA32_MCx_STATUS(1), 0);
> +			pr_err_once("Errata detected, disable fast string copy instructions.\n");
> +			return true;
> +		}
> +	}
> +	return false;
> +}

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
