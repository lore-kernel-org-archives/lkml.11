Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C559C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  2 May 2022 12:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbiEBM0f (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 May 2022 08:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbiEBM0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 08:26:33 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37B7B7F6
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 05:23:04 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 38F2B1EC0373;
        Mon,  2 May 2022 14:22:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1651494179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=7siz2JYrn12FxM0xEcNQzLq7tlEW6UJKBJdVpTlotAw=;
        b=PtByNp0J45Rqqw1kxJyJTDaraTlB6NpxQoPZOj6RxU38bavUZLPL/lkcLn3ykg3KS8HKbZ
        8sild7pI5Ly7logxUng+zvcL8Yz+aK/bQWIzxIdgv3D+fvD9Q0+006lLbY6zOw5Cdk0kxO
        a6pq18fxdHy2qpe5U6ncQFw41GZ6vsc=
Date:   Mon, 2 May 2022 14:22:55 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [patch 0/3] x86/fpu: Prevent FPU state corruption
Message-ID: <Ym/NH568aRckfmB8@zn.tnic>
References: <20220501192740.203963477@linutronix.de>
 <Ym+sMv5NUOhmLVPH@debian9.Home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Ym+sMv5NUOhmLVPH@debian9.Home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 11:02:26AM +0100, Filipe Manana wrote:
> Thanks for fixing this. I had been reliably hitting that fpu state splat
> since 5.18-rc1 with fstests, and was annoying because it made a few tests
> fail (fstests reports a failure whenever there's a splat or warning in
> dmesg).
> 
> I confirm that with this patchset applied the issue no longer happens and
> everything seems to be working fine, so:
> 
> Tested-by: Filipe Manana <fdmanana@suse.com>

Thanks for taking the time to bisect it, trace it - which basically
showed where the problem is - and test it!

Much appreciated.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
