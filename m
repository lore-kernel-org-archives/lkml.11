Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC360C433FE
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Mar 2022 15:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235796AbiCAP0f (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Mar 2022 10:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235782AbiCAP00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 10:26:26 -0500
Received: from v-zimmta03.u-bordeaux.fr (v-zimmta03.u-bordeaux.fr [147.210.215.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9661DA94DF;
        Tue,  1 Mar 2022 07:25:23 -0800 (PST)
Received: from v-zimmta03.u-bordeaux.fr (localhost [127.0.0.1])
        by v-zimmta03.u-bordeaux.fr (Postfix) with ESMTP id C2B201800A82;
        Tue,  1 Mar 2022 16:25:21 +0100 (CET)
Received: from begin (nat-inria-interne-54-gw-02-bso.bordeaux.inria.fr [194.199.1.54])
        by v-zimmta03.u-bordeaux.fr (Postfix) with ESMTPSA id 55C181800A92;
        Tue,  1 Mar 2022 16:25:21 +0100 (CET)
Received: from samy by begin with local (Exim 4.95)
        (envelope-from <samuel.thibault@labri.fr>)
        id 1nP4NN-00BrND-2C;
        Tue, 01 Mar 2022 16:25:21 +0100
Date:   Tue, 1 Mar 2022 16:25:21 +0100
From:   Samuel Thibault <samuel.thibault@labri.fr>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     willemb@google.com, davem@davemloft.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>
Subject: Re: [PATCH] SO_ZEROCOPY should rather return -ENOPROTOOPT
Message-ID: <20220301152520.jdeusajoymkx34fp@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@labri.fr>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        willemb@google.com, davem@davemloft.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>
References: <20220301144453.snstwdjy3kmpi4zf@begin>
 <CA+FuTSfi1aXiBr-fOQ+8XJPjCCTnqTicW2A3OUVfNHurfDL3jA@mail.gmail.com>
 <20220301150028.romzjw2b4aczl7kf@begin>
 <CA+FuTSeZw228fsDj+YoSpu5sLaXsp+uR+N+qHrzZ4e3yMWhPKw@mail.gmail.com>
 <20220301152017.jkx7amcbfqkoojin@begin>
 <CA+FuTSfVBVr_q6p+HcBL4NAX4z2BS0ZNaSfFF0yxO3QqeNX75Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+FuTSfVBVr_q6p+HcBL4NAX4z2BS0ZNaSfFF0yxO3QqeNX75Q@mail.gmail.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-AV-Checked: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Willem de Bruijn, le mar. 01 mars 2022 10:21:41 -0500, a ecrit:
> On Tue, Mar 1, 2022 at 10:20 AM Samuel Thibault
> <samuel.thibault@labri.fr> wrote:
> >
> > Willem de Bruijn, le mar. 01 mars 2022 10:14:18 -0500, a ecrit:
> > > On Tue, Mar 1, 2022 at 10:00 AM Samuel Thibault
> > > <samuel.thibault@labri.fr> wrote:
> > > >
> > > > Willem de Bruijn, le mar. 01 mars 2022 09:51:45 -0500, a ecrit:
> > > > > On Tue, Mar 1, 2022 at 9:44 AM Samuel Thibault <samuel.thibault@labri.fr> wrote:
> > > > > >
> > > > > > ENOTSUPP is documented as "should never be seen by user programs", and
> > > > > > is not exposed in <errno.h>, so applications cannot safely check against
> > > > > > it. We should rather return the well-known -ENOPROTOOPT.
> > > > > >
> > > > > > Signed-off-by: Samuel Thibault <samuel.thibault@labri.fr>
> > > > > >
> > > > > > diff --git a/net/core/sock.c b/net/core/sock.c
> > > > > > index 4ff806d71921..6e5b84194d56 100644
> > > > > > --- a/net/core/sock.c
> > > > > > +++ b/net/core/sock.c
> > > > > > @@ -1377,9 +1377,9 @@ int sock_setsockopt(struct socket *sock, int level, int optname,
> > > > > >                         if (!(sk_is_tcp(sk) ||
> > > > > >                               (sk->sk_type == SOCK_DGRAM &&
> > > > > >                                sk->sk_protocol == IPPROTO_UDP)))
> > > > > > -                               ret = -ENOTSUPP;
> > > > > > +                               ret = -ENOPROTOOPT;
> > > > > >                 } else if (sk->sk_family != PF_RDS) {
> > > > > > -                       ret = -ENOTSUPP;
> > > > > > +                       ret = -ENOPROTOOPT;
> > > > > >                 }
> > > > > >                 if (!ret) {
> > > > > >                         if (val < 0 || val > 1)
> > > > >
> > > > > That should have been a public error code. Perhaps rather EOPNOTSUPP.
> > > > >
> > > > > The problem with a change now is that it will confuse existing
> > > > > applications that check for -524 (ENOTSUPP).
> > > >
> > > > They were not supposed to hardcord -524...
> > > >
> > > > Actually, they already had to check against EOPNOTSUPP to support older
> > > > kernels, so EOPNOTSUPP is not supposed to pose a problem.
> > >
> > > Which older kernels returned EOPNOTSUPP on SO_ZEROCOPY?
> >
> > Sorry, bad copy/paste, I meant ENOPROTOOPT.
> 
> Same point though, right? These are not legacy concerns, but specific
> to applications written to SO_ZEROCOPY.
> 
> I expect that most will just ignore the exact error code and will work
> with either.

Well, in the code I just wrote, I ignored ENOPROTOOPT due to older
kernels, and it's only when the code happened to be run against PF_LOCAL
sockets that the ENOTSUPP question raised. My code has never been
exposed to a EOPNOTSUPP error, so I would have never written a check
against EOPNOTSUPP if you didn't mention it as a possibility.

Samuel
