Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21DCC4167D
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Feb 2022 13:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357442AbiBHNVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Feb 2022 08:21:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359692AbiBHMwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 07:52:43 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2178CC03FECA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 04:52:43 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8C4F41EC02B9;
        Tue,  8 Feb 2022 13:52:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644324757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=wW5v18SsFr9UFGcEVFzDWXiJLXGqG2TS6A5yFHIl6Jc=;
        b=lauEYb3mkpYVOjoKl82iGb4BxW8WhTexv0OYMU0Bi1UGmkaqXeONSkaTS7vb3qNqIYHZgA
        1r8h0Aw0NO0LejTu36v1B2nacn2kHrlOm20OtnkjRPmbfGwFFDP2ISJIlEPWuHf9WS8fqX
        KuM9pm/0RJSI/s2NmzqvIgDwEiDfKLI=
Date:   Tue, 8 Feb 2022 13:52:32 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Hugh Dickins <hughd@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: x86: should clear_user() have alternatives?
Message-ID: <YgJnhB+bAxoNsiSB@zn.tnic>
References: <2f5ca5e4-e250-a41c-11fb-a7f4ebc7e1c9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2f5ca5e4-e250-a41c-11fb-a7f4ebc7e1c9@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hugh,

On Mon, Feb 07, 2022 at 09:45:36PM -0800, Hugh Dickins wrote:
> I realize that dd'ing from /dev/zero to /dev/null, and sparse files on
> tmpfs, are not prime candidates for optimization; and I've no idea how
> much clear_user() normally gets used for long clears.

Right, we usually don't take such "optimizations" because the folks who
send them always come up with either microbenchmarks or only test on a
single machine.

> If I were capable of compiler asm, with alternatives, and knew at what
> length ERMS becomes advantageous when clearing, I would be sending you
> a proper patch.  As it is, I'm hoping to tempt someone else to do the
> work!  Or reject it as too niche to bother with.

Yap, looking at arch/x86/lib/clear_page_64.S - that's straight-forward
asm without special-cases noodles like __copy_user_nocache, for example,
so I wouldn't be opposed to someone

 - remodelling it so that you can have clear_user* variants there too,
 with the length supplied so that you can call a common function with
 arbitrary length and clear_page* can call it too. And then call them in
 a clear_user() version just like the clear_page() one which selects the
 proper target based on CPU feature flags.

 - testing this on bunch of modern machines with, say, a kernel build or
 some sensible benchmark so that we at least have some coverage

If the numbers are worth it - and judging by your quick testing above
they should be - then I don't mind taking that at all.

If only someone would have the time and diligence to do it properly...

:-)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
