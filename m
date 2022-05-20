Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C302C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 20 May 2022 23:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352449AbiETX0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 May 2022 19:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354077AbiETX0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 19:26:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF1754BE8
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 16:26:00 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653089158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GXl2vZK8puszcOApjIRM6ipBqamYF8etYeeQxgi9t5c=;
        b=Ge1GbYxJiIrzO7+HtjEO7xasn5LCGkqxqYYrM/F0B6gO0Q1SUxnLjfjWJCibrC/MXIpjJ3
        FtGAkaCTtAnpcrVC9FOp2RZfblScKVBXtToMz61M/KdI9ANzNZN1KlLqVxr9/Wh/2KObhA
        F3+wyQoA4maHBAATR8GCsrLC0CqxevVL28uEo2xPVafnalKJf2mVcibpqTtokBBR/GjJ0B
        B7JpFCWXL0NpRkRsB8Yzs+AvESIXQdH9nKyR46Hu8aZxEPX3mt3vyN3VYJjB5JtAvG8uGk
        JhRvNDjSTse1Q6zy9lhGiIpgNgxSHe5dg9H3URRXB1QJh5dD3uFf0vc3cSXDuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653089158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GXl2vZK8puszcOApjIRM6ipBqamYF8etYeeQxgi9t5c=;
        b=bdrx6T6/OumYHk0OqR+Y8wRLS0Vj5+UqI6uPx0nzpCsD/CVpT6lvt1ijM8c2h+x5jG4zGY
        SnVBUdez4bhQH/CQ==
To:     Shreenidhi Shedi <yesshedi@gmail.com>, srivatsa@csail.mit.edu,
        amakhalov@vmware.com, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com
Cc:     virtualization@lists.linux-foundation.org, pv-drivers@vmware.com,
        x86@kernel.org, linux-kernel@vger.kernel.org, yesshedi@gmail.com,
        Shreenidhi Shedi <sshedi@vmware.com>
Subject: Re: [PATCH v2] x86/vmware: use unsigned integer for shifting
In-Reply-To: <20220520140954.597725-1-sshedi@vmware.com>
References: <20220520140954.597725-1-sshedi@vmware.com>
Date:   Sat, 21 May 2022 01:25:57 +0200
Message-ID: <87pmk7iy62.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20 2022 at 19:39, Shreenidhi Shedi wrote:

> From: Shreenidhi Shedi <yesshedi@gmail.com>
>
> From: Shreenidhi Shedi <sshedi@vmware.com>

Can you please decide which of your personalities wrote that patch?

> Shifting signed 32-bit value by 31 bits is implementation-defined
> behaviour. Using unsigned is better option for this.

Better option? There are no options. It's either correct or not. Please
be precise and technical in your wording.

> Fixes: 4cca6ea04d31 ("x86/apic: Allow x2apic without IR on VMware platform")
>
> Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>

Please keep the tags together. This extra new line is pointless and
makes the maintainer do extra work to remove it.

Documentation/process/* has all the relevant directives for
you. Following them is not an option. It's mandatory.

> @@ -476,8 +477,8 @@ static bool __init vmware_legacy_x2apic_available(void)
>  {
>  	uint32_t eax, ebx, ecx, edx;
>  	VMWARE_CMD(GETVCPU_INFO, eax, ebx, ecx, edx);
> -	return (eax & (1 << VMWARE_CMD_VCPU_RESERVED)) == 0 &&
> -	       (eax & (1 << VMWARE_CMD_LEGACY_X2APIC)) != 0;
> +	return !(eax & BIT(VMWARE_CMD_VCPU_RESERVED)) &&
> +		(eax & BIT(VMWARE_CMD_LEGACY_X2APIC))

Testing your changes before submission is not optional either. How is
this supposed to compile?

Thanks,

        tglx
