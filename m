Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6425BC38145
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Sep 2022 04:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbiICE20 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Sep 2022 00:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiICE2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 00:28:24 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE930C2E8A
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 21:28:22 -0700 (PDT)
Received: from nazgul.tnic (unknown [84.201.196.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 388361EC068C;
        Sat,  3 Sep 2022 06:28:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1662179297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=CgxVGHbcD6eBLXY0Rv8tA3Z9PMAyTxATsYR3svKe7OY=;
        b=ZnwSSY9N+SjfnUMLmSNNXiiMfoCC6xe5ndI41dF/pnrKq5y+iOXVkImza9x1/eVvm7Vq6B
        btQI0n1TumNj7EfMoSrhKrr3I2IQ/IZAwdSGLGTJnM4HmmZ4XTTarbeEID+Z+g+ty3W9OC
        z16HA8GL3jtpTh5lF70Z/wz2MlBR21c=
Date:   Sat, 3 Sep 2022 06:28:22 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Bill Wendling <morbo@google.com>
Cc:     Juergen Gross <jgross@suse.com>,
        "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev
Subject: Re: [PATCH 1/2] x86/paravirt: clean up typos and grammaros
Message-ID: <YxLX5i0aUoe9zBsx@nazgul.tnic>
References: <20220902213750.1124421-1-morbo@google.com>
 <20220902213750.1124421-2-morbo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220902213750.1124421-2-morbo@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 09:37:49PM +0000, Bill Wendling wrote:
> Drive-by clean up of the comment.
> 
> [ Impact: cleanup]

We used to do that type of "impact" tagging years ago but we stopped.
Where did you dig this out from?

:)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
