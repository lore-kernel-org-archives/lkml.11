Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF63C433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Apr 2022 15:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244249AbiDGPih (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Apr 2022 11:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiDGPid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 11:38:33 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AF6113C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 08:36:32 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id p15so10302624lfk.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 08:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pnuMUPEbVjet+lFSG2AcBAs7iUWisKztMADa8lx2NWA=;
        b=NEOY9oEROP7jpPOjBJg+zCvJ7gS9PfH2CL5RzbkqJjP6Q5ZAvRja7o6Aj1N3C/sgAN
         KfvszgsA4xHnNUWmyXnhMAnYFvI8Fa6oCevVlX6zHezs/qCi7WkYKvHp46XIbbXbDyE2
         BqOqjRO51v+GF6frJ8buWEEb9yGpzXYdHlCJoUH1r42+IuKYgzCSiqhyzNNwwpGJrELg
         lDWqizOSM6/Jc3O8wAcT3QTqSNBmoDuxHoG5B8CDx+XeEef9IB2sUWJCOnTz1Jr3DAtg
         lhUp/TyI7aYny1g38SzSaaZjNuP2/8o+2na0s0sk/PSlrxC1Wzie/5rovJT1JdoGIK6T
         pIxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pnuMUPEbVjet+lFSG2AcBAs7iUWisKztMADa8lx2NWA=;
        b=791/yhbglRNC2IrpX4KLQwgdTrYbGxSSIJusQLXCGhpqmviNhR6FAFeN2AZwOKkjLq
         NZXOiAw78hFWDcZkQzbTxleFcM6VEnWxGzjUoZ8LxS0/V4K8RgpcouDVUtC7V66/vJeu
         ZOJxw0MyO+dqsoVif9kkYWWwOQbmzVji77H82hKEERyf6W2RqYhfL3LMJ1oNwuRmpbwH
         sWMFddv7YTV/oyBjWh9VkOVE87xk27OhuyhyUgVxK0X0GkYN+9IGyi23yiphzqzk0fHo
         Q0kfIM2UoNRHB6p66URczJm02RAQEOq9rQ6fSkM4E9rJA/Ln9ENMkBUGaWCepo8HQv6q
         l5zQ==
X-Gm-Message-State: AOAM533AoYwtB4d+GmIDmwKtqq+A0zamHgNeK5CKdaJNo2CKJttfsZnx
        EEoG32VexGyXzo9NOhY3GKa//yOEroa6G6ZZdMiVRQ==
X-Google-Smtp-Source: ABdhPJyQBnxIZf6a3UCCpc849WOauUeIuK2PhayYs3HTddHJ/pLzgR8VpQupGjIPexVMrCQ+Psoi+Uu302OV6h6JdeQ=
X-Received: by 2002:a05:6512:1107:b0:44a:62dc:dd0f with SMTP id
 l7-20020a056512110700b0044a62dcdd0fmr9980262lfg.479.1649345790167; Thu, 07
 Apr 2022 08:36:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220406172600.1141083-1-jeffreyjilinux@gmail.com> <20220406223141.51881854@kernel.org>
In-Reply-To: <20220406223141.51881854@kernel.org>
From:   Brian Vazquez <brianvv@google.com>
Date:   Thu, 7 Apr 2022 08:36:18 -0700
Message-ID: <CAMzD94T_wo=5x5mzm6NgjgSyTrj6koCqg_ia50HeKZnGp73C6w@mail.gmail.com>
Subject: Re: [PATCH net-next] net-core: rx_otherhost_dropped to core_stats
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Jeffrey Ji <jeffreyjilinux@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Menglong Dong <imagedong@tencent.com>,
        Petr Machata <petrm@nvidia.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeffrey Ji <jeffreyji@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good to me, thanks Jeffrey.

Reviewed-by: Brian Vazquez <brianvv@google.com>


On Wed, Apr 6, 2022 at 10:31 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Wed,  6 Apr 2022 17:26:00 +0000 Jeffrey Ji wrote:
> > From: Jeffrey Ji <jeffreyji@google.com>
> >
> > Increment rx_otherhost_dropped counter when packet dropped due to
> > mismatched dest MAC addr.
> >
> > An example when this drop can occur is when manually crafting raw
> > packets that will be consumed by a user space application via a tap
> > device. For testing purposes local traffic was generated using trafgen
> > for the client and netcat to start a server
> >
> > Tested: Created 2 netns, sent 1 packet using trafgen from 1 to the other
> > with "{eth(daddr=$INCORRECT_MAC...}", verified that iproute2 showed the
> > counter was incremented. (Also had to modify iproute2 to show the stat,
> > additional patch for that coming next.)
> >
> > Signed-off-by: Jeffrey Ji <jeffreyji@google.com>
>
> Acked-by: Jakub Kicinski <kuba@kernel.org>
