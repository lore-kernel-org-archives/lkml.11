Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C9DC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 May 2022 13:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238419AbiEKNIi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 May 2022 09:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234773AbiEKNId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 09:08:33 -0400
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAD8694BF
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 06:08:25 -0700 (PDT)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4KywFg4Vvfz1s767;
        Wed, 11 May 2022 15:08:23 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4KywFg3pqTz1qqkC;
        Wed, 11 May 2022 15:08:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id kYXiVRSumpor; Wed, 11 May 2022 15:08:22 +0200 (CEST)
X-Auth-Info: YEBr5TXT5M0JFjoy9bg7asKyhj92V+KtsCcBJL9EYLO6BmBfGrQV3CaUgj1M9MBe
Received: from igel.home (ppp-46-244-167-40.dynamic.mnet-online.de [46.244.167.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 11 May 2022 15:08:22 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 5485A2C39F6; Wed, 11 May 2022 15:08:22 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Ungerer <gerg@uclinux.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] m68k: math-emu: Fix dependencies of math emulation support
References: <e0a9cf982a80f14efbf01cdc38e31128a9f41999.1652262437.git.geert@linux-m68k.org>
        <875ymcwek5.fsf@igel.home>
        <CAMuHMdXrd07goR2WffENJnLMAWZxtxoQzaL_7+SG-ZSvaYK1HQ@mail.gmail.com>
X-Yow:  Yow!  Now we can become alcoholics!
Date:   Wed, 11 May 2022 15:08:22 +0200
In-Reply-To: <CAMuHMdXrd07goR2WffENJnLMAWZxtxoQzaL_7+SG-ZSvaYK1HQ@mail.gmail.com>
        (Geert Uytterhoeven's message of "Wed, 11 May 2022 14:02:01 +0200")
Message-ID: <87lev8ushl.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mai 11 2022, Geert Uytterhoeven wrote:

> The FPU emu code also relies on the CPU trapping on the proper
> instructions, which I believe you need a 68020+ for, too?

While pre-020 doesn't have the coprocessor interface (which is not
fpu-specific, though), they still use the same exception vector.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
