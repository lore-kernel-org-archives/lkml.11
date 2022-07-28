Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C018C04A68
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jul 2022 15:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbiG1PS5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jul 2022 11:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbiG1PSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 11:18:52 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD70B6050B
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 08:18:40 -0700 (PDT)
Received: from zn.tnic (p57969665.dip0.t-ipconnect.de [87.150.150.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 361861EC0567;
        Thu, 28 Jul 2022 17:18:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1659021515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=RFFgyhldhcIGPI4uosV2Lk0agZN008XdlmOLfQBHDwI=;
        b=IXY5tKY2fhce9cZyBx/2LwD6jSvP4zibbUINYX2Y8OWPXBsQNI8AyVaVYO6q+Jj0rbt8zR
        miRpI3YCr7RFJc2+KPQedbpflLR5ERjOEyy7F2wZJ57KD18QCXN0F2WdGDjxXjYZKh6ZNo
        9bK3hc1ARgwwsFdy+P3SHZZEb9EBkGw=
Date:   Thu, 28 Jul 2022 17:18:31 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dimitri John Ledkov <dimitri.ledkov@canonical.com>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] x86/bugs: Do not enable IBPB at firmware entry when IBPB
 is not available
Message-ID: <YuKoxyUdAWsTfKez@zn.tnic>
References: <20220728122602.2500509-1-cascardo@canonical.com>
 <YuKCpLOLeDOI7GII@zn.tnic>
 <CADWks+aosM99jv9WwLvFo3LPEnsqts+2bJPzMnRqJX70qz51cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADWks+aosM99jv9WwLvFo3LPEnsqts+2bJPzMnRqJX70qz51cg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 03:33:35PM +0100, Dimitri John Ledkov wrote:
> Azure public cloud (so it is Azure custom hyper-v hypervisor) these
> instance types https://docs.microsoft.com/en-us/azure/virtual-machines/dav4-dasv4-series

Thank you both for the info.

Virt is an awful piece of sh*t when it goes and emulates all kinds of
imaginary CPUs. And AMD machine *without* an IBPB which is affected by
retbleed. Well, f*ck that.

Does that say somewhere on azure that those guests need to even enable
the mitigation or does the HV mitigate it for them?

Because I wouldn't mind to simply disable the mitigation when on a
hypervisor which doesn't support IBPB.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
