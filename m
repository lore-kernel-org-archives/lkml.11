Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74391C433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  1 May 2022 11:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346488AbiEALfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 May 2022 07:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346455AbiEALfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 07:35:21 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD871186E2;
        Sun,  1 May 2022 04:31:55 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 5AF6892009C; Sun,  1 May 2022 13:31:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 54F0092009B;
        Sun,  1 May 2022 12:31:52 +0100 (BST)
Date:   Sun, 1 May 2022 12:31:52 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Stephen Zhang <starzhangzsd@gmail.com>
cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        liam.howlett@oracle.com, ebiederm@xmission.com, alobakin@pm.me,
        f.fainelli@gmail.com, paul@crapouillou.net, linux@roeck-us.net,
        anemo@mba.ocn.ne.jp, zhangshida <zhangshida@kylinos.cn>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH v2] MIPS: undefine and redefine cpu_has_fpu when it is
 overrided
In-Reply-To: <CANubcdUxobBn968rtz0z-zZVJQfV5k3PQcdLdXNbsw3mEphk0A@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2205011230100.9383@angie.orcam.me.uk>
References: <20220429032621.674865-1-starzhangzsd@gmail.com> <20220429095104.GA11365@alpha.franken.de> <alpine.DEB.2.21.2204291559490.9383@angie.orcam.me.uk> <CANubcdWykz0j5BaGNhYMW16wX9UbfgsLdEs-ebNWCWP+p1OKWw@mail.gmail.com> <alpine.DEB.2.21.2204301609310.9383@angie.orcam.me.uk>
 <CANubcdUxobBn968rtz0z-zZVJQfV5k3PQcdLdXNbsw3mEphk0A@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 May 2022, Stephen Zhang wrote:

> Thanks for your elaboration.It helps a lot.
> I want to submit a v3 patch like:
> 
> #if cpu_has_fpu
> # error "Forcing `cpu_has_fpu' to non-zero is not supported"
> #endif
> 
> but this will cause the link error if not combined with the fix:
> 
> MIPS: IP30: Remove incorrect `cpu_has_fpu' override
> 
> Maybe I should submit one first, and see how it goes then.

 Let's wait a couple of days until the fixes required have been queued.

  Maciej
