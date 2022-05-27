Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6B0C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 May 2022 21:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244869AbiE0VFQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 May 2022 17:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351516AbiE0VFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 17:05:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B15762A5;
        Fri, 27 May 2022 14:05:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4ECFCB82627;
        Fri, 27 May 2022 21:04:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847A2C385A9;
        Fri, 27 May 2022 21:04:56 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="FIuCpieH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1653685493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hP6/vL4yLFuWkYgRLSR15ITu58F1bCL+p66zfOWdQ5U=;
        b=FIuCpieHjU1MHF1lIZJv41/AV18M8BW3BHxFgh8o/tJ4xzICx1GSu6FfiwrH9s4tCtw65u
        fLW7wJXed8C7S8IWVvcg3mNTINr1IAjt2c0EinVwB66hhZ/m24Ny53BWPOA5apVehZEfND
        tEphcBxbB1/s3DSpsT9Tt2SdQCeD/78=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a069010a (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 27 May 2022 21:04:52 +0000 (UTC)
Date:   Fri, 27 May 2022 23:04:48 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Pavel Machek <pavel@denx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chris.Paterson2@renesas.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com
Subject: Re: [PATCH 5.10 000/163] 5.10.119-rc1 review
Message-ID: <YpE88Nwh/FQMyVVL@zx2c4.com>
References: <20220527084828.156494029@linuxfoundation.org>
 <20220527141421.GA13810@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220527141421.GA13810@duo.ucw.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On Fri, May 27, 2022 at 04:14:21PM +0200, Pavel Machek wrote:
> It seems we hit some problems, but I'm not sure if they are kernel
> problems or test infrastructure problems. Perhaps Chris can help?
> 
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/549589225

I'm clicking on everything red, and all the actual boot logs and
execution logs show things passing. Seems like this might be a CI issue?
I'm certainly very interested to learn about potential regressions
though if you can point to anything specific.

If I had to guess, it looks to me like the "lava" job finishes with
"result: pass", but never tells the controller properly, so it times out
waiting for the reply. Seems like CI infrastructure issue.

Jason
