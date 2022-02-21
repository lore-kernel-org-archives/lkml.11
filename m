Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA248C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 18:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbiBUSoA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 13:44:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiBUSmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 13:42:38 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B74D9D97;
        Mon, 21 Feb 2022 10:42:12 -0800 (PST)
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 25BF663580;
        Mon, 21 Feb 2022 19:41:15 +0100 (CET)
Date:   Mon, 21 Feb 2022 19:42:09 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Eric Dumazet <edumazet@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Woody Suwalski <wsuwalski@gmail.com>,
        Florian Westphal <fw@strlen.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>
Subject: Re: Linux 5.17-rc5
Message-ID: <YhPdAeNwgffXqvfO@salvia>
References: <CAHk-=wgsMMuMP9_dWps7f25e6G628Hf7-B3hvSDvjhRXqVQvpg@mail.gmail.com>
 <8f331927-69d4-e4e7-22bc-c2a2a098dc1e@gmail.com>
 <CAHk-=wiAgNCLq2Lv4qu08P1SRv0D3mXLCqPq-XGJiTbGrP=omg@mail.gmail.com>
 <CANn89iJkTmDYb5h+ZwSyYEhEfr=jWmbPaVoLAnKkqW5VE47DXA@mail.gmail.com>
 <CAHk-=wigDNpiLAAS8M=1BUt3FCjWNA8RJr1KRQ=Jm_Q8xWBn-g@mail.gmail.com>
 <CANn89iJ2tmou5RNqmL22EHf+D2dptJPgpOVufSFEyoeJujw1cw@mail.gmail.com>
 <YhPZNLWkxH21uDAq@salvia>
 <CANn89i+72dv1AaeE1ThkceMVBHGCh3P49hOwuCkMSb1Y6U=hmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANn89i+72dv1AaeE1ThkceMVBHGCh3P49hOwuCkMSb1Y6U=hmg@mail.gmail.com>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 10:28:46AM -0800, Eric Dumazet wrote:
> On Mon, Feb 21, 2022 at 10:25 AM Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> >
> > On Mon, Feb 21, 2022 at 10:21:16AM -0800, Eric Dumazet wrote:
> > > On Mon, Feb 21, 2022 at 10:08 AM Linus Torvalds
> > > <torvalds@linux-foundation.org> wrote:
> > > >
> > > > On Mon, Feb 21, 2022 at 10:02 AM Eric Dumazet <edumazet@google.com> wrote:
> > > > >
> > > > > I am pretty sure Pablo fixed this one week ago.
> > > >
> > > > .. looks about right. Apart from the "it was never sent to me, so -rc5
> > > > ended up showing the problem" part.
> > > >
> > >
> > > Indeed, I personally these kinds of trivial fixes should be sent right away,
> > > especially considering two bots complained about it.
> >
> > I did not consider this so important, that was my fault.
> 
> Well, I was the one adding this compile error ;)

I poorly performed as a duly reviewer :)

> Testing CONFIG_IPV6=n builds is not my top priority.

For the record, this patch is now flying to the netdev tree via pull request:

https://patchwork.kernel.org/project/netdevbpf/patch/20220221161757.250801-1-pablo@netfilter.org/

Thanks.
