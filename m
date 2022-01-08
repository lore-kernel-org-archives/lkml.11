Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D611C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jan 2022 23:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbiAHXJs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jan 2022 18:09:48 -0500
Received: from angie.orcam.me.uk ([78.133.224.34]:38712 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbiAHXJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 18:09:47 -0500
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 8090D92009C; Sun,  9 Jan 2022 00:09:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 7221C92009B;
        Sat,  8 Jan 2022 23:09:45 +0000 (GMT)
Date:   Sat, 8 Jan 2022 23:09:45 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Muni Sekhar <munisekharrms@gmail.com>
cc:     noloader@gmail.com, linux-x86_64@vger.kernel.org,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: x86, nmi: IOCK error
In-Reply-To: <CAHhAz+hopmWpr6Whe_=92UrdrrANaQKFmVZjcx6p+=2tWouFuw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2201082302580.56863@angie.orcam.me.uk>
References: <CAHhAz+h2OgBMP8Mm+dNPuNEq=DhWdc7Y+dJEvrXz9kAUD7O2GQ@mail.gmail.com> <CAH8yC8nEhcAs5hE=utcUEKZ8kohOx2TWhUsbue1sdZo23uiBHw@mail.gmail.com> <CAHhAz+hopmWpr6Whe_=92UrdrrANaQKFmVZjcx6p+=2tWouFuw@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2021, Muni Sekhar wrote:

> > Red Hat has a good article on the subject at
> > https://access.redhat.com/solutions/42261.
> NMI: IOCK error (debug interrupt?) for reason 60 on CPU 0.
> NMI: IOCK error (debug interrupt?) for reason 70 on CPU 0.
> What's the difference between reason 60 & reason 70? I was not able to
> find it in the above mentioned link.

 For any practical purpose the value of bit #4 in the NMI Status and 
Control Register does not matter as (in a compatible system) it merely 
toggles with every DRAM refresh cycle.

 HTH,

  Maciej
