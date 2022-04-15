Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668E2C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Apr 2022 12:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353264AbiDOM3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Apr 2022 08:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351575AbiDOM30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 08:29:26 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E565FC1CB5;
        Fri, 15 Apr 2022 05:26:58 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 4CE8A92009D; Fri, 15 Apr 2022 14:26:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 46C0092009B;
        Fri, 15 Apr 2022 13:26:58 +0100 (BST)
Date:   Fri, 15 Apr 2022 13:26:58 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Matt Turner <mattst88@gmail.com>
cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        linux-alpha <linux-alpha@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Alpha: Remove redundant local asm header redirections
In-Reply-To: <CAEdQ38EpBMnkP-PNZnwaoO4poFJQO5YSFJeZgiQ-obJmjogBFQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2204150100380.9383@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2202131944000.34636@angie.orcam.me.uk> <CAEdQ38EpBMnkP-PNZnwaoO4poFJQO5YSFJeZgiQ-obJmjogBFQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Apr 2022, Matt Turner wrote:

> Sorry for the delay. I'll apply this. I just haven't had much time for
> alphas lately.

 No worries, and thanks for chiming in.  I plan to get one of my Alphas 
set up and wired in my remote lab later this year, so I hope to get a bit 
more active with the port.  At least I've got a reasonably recent build of 
the toolchain:

$ alpha-linux-gnu-gcc --version
alpha-linux-gnu-gcc (GCC) 12.0.1 20220129 (experimental)
[...]

> Maybe now's a good time to remind you that I'm still waiting on you to
> upstream the m41t80/SWARM/i2c/smbus patches? It's been more than 11
> years now, so it seems long enough for a ping :)

 Umm, right, I came across them recently!  I'll see what I can do, however 
I don't have my SWARM in my remote lab, so I can only verify things when 
I'm next to it (which has been occasional only since the start of the 
bloody pandemic).  As I recall there was an issue with the incompatibility 
of the SMBUS protocol subset implemented by the SOC and the RTC causing a 
race.  I've had more stuff outstanding, such as PHY IRQ support for the 
Ethernet interfaces.

 And I yet have to see why my compiler miscompiled one endianness of CFE 
too (and find a way to publish my CFE fixes)!

  Maciej
