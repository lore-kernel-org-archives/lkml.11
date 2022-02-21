Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03D5C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 18:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbiBUSf7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 13:35:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbiBUSdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 13:33:46 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C89B015A0B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 10:31:41 -0800 (PST)
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 22B41643A3;
        Mon, 21 Feb 2022 19:25:02 +0100 (CET)
Date:   Mon, 21 Feb 2022 19:25:56 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Eric Dumazet <edumazet@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Woody Suwalski <wsuwalski@gmail.com>,
        Florian Westphal <fw@strlen.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>
Subject: Re: Linux 5.17-rc5
Message-ID: <YhPZNLWkxH21uDAq@salvia>
References: <CAHk-=wgsMMuMP9_dWps7f25e6G628Hf7-B3hvSDvjhRXqVQvpg@mail.gmail.com>
 <8f331927-69d4-e4e7-22bc-c2a2a098dc1e@gmail.com>
 <CAHk-=wiAgNCLq2Lv4qu08P1SRv0D3mXLCqPq-XGJiTbGrP=omg@mail.gmail.com>
 <CANn89iJkTmDYb5h+ZwSyYEhEfr=jWmbPaVoLAnKkqW5VE47DXA@mail.gmail.com>
 <CAHk-=wigDNpiLAAS8M=1BUt3FCjWNA8RJr1KRQ=Jm_Q8xWBn-g@mail.gmail.com>
 <CANn89iJ2tmou5RNqmL22EHf+D2dptJPgpOVufSFEyoeJujw1cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANn89iJ2tmou5RNqmL22EHf+D2dptJPgpOVufSFEyoeJujw1cw@mail.gmail.com>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 10:21:16AM -0800, Eric Dumazet wrote:
> On Mon, Feb 21, 2022 at 10:08 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Mon, Feb 21, 2022 at 10:02 AM Eric Dumazet <edumazet@google.com> wrote:
> > >
> > > I am pretty sure Pablo fixed this one week ago.
> >
> > .. looks about right. Apart from the "it was never sent to me, so -rc5
> > ended up showing the problem" part.
> >
> 
> Indeed, I personally these kinds of trivial fixes should be sent right away,
> especially considering two bots complained about it.

I did not consider this so important, that was my fault.
