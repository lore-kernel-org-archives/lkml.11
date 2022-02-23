Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E0AC433FE
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Feb 2022 16:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242588AbiBWQEO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Feb 2022 11:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234947AbiBWQEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 11:04:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5ABBF97B;
        Wed, 23 Feb 2022 08:03:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6322F6194A;
        Wed, 23 Feb 2022 16:03:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF48C340EB;
        Wed, 23 Feb 2022 16:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645632223;
        bh=DMAP5LetazF0Rx1qRMQIPs2ELg7gH129oVIlNYECo2U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PncSR9SB7C+LYSAPO0Ak+gUFFxhJySUmNe/3+OqKVXq8s9bF/dNYk7aZEQhBZP+rA
         3GeXbVxO+2KsYQ9kCPpT/11Ko4XZi68iDiV07O74jHCvYy8TAvQS5bumoXkywH8SKk
         4gu4WQ/23+dCrcrBzs/PiOdAvy3bTI4/cE6zeiu8RLAlhVLOycbMdKAsciLDieEtK1
         3ks5VqWWiXPXP7kmvc9utvrE432KinOBfNBtCp6vnpem8HhsomvRaeA2vUFTLX7TUG
         B6kbkRbHkQyodmzk3TWo4wxVUMAS9Eel2oxIHL6SOxp3evkgQwAuhdlxmzg1IzpwBO
         lkODwrJflfq7A==
Date:   Wed, 23 Feb 2022 08:03:42 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Guillaume Nault <gnault@redhat.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Eric Dumazet <edumazet@google.com>,
        "Ziyang Xuan (William)" <william.xuanziyang@huawei.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        Vasily Averin <vvs@virtuozzo.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: vlan: allow vlan device MTU change follow real
 device from smaller to bigger
Message-ID: <20220223080342.5cdd597c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20220223112618.GA19531@debian.home>
References: <20220221124644.1146105-1-william.xuanziyang@huawei.com>
        <CANn89iKyWWCbAdv8W26HwGpM9q5+6rrk9E-Lbd2aujFkD3GMaQ@mail.gmail.com>
        <YhQ1KrtpEr3TgCwA@gondor.apana.org.au>
        <8248d662-8ea5-7937-6e34-5f1f8e19190f@huawei.com>
        <CANn89iLf2ira4XponYV91cbvcdK76ekU7fDW93fmuJ3iytFHcw@mail.gmail.com>
        <20220222103733.GA3203@debian.home>
        <20220222152815.1056ca24@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <20220223112618.GA19531@debian.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Feb 2022 12:26:18 +0100 Guillaume Nault wrote:
> Do you mean something like:
> 
>   ip link set dev eth0 vlan-mtu-policy <policy-name>
> 
> that'd affect all existing (and future) vlans of eth0?

I meant

  ip link set dev vlan0 mtu-policy blah

but also

  ip link set dev bond0 mtu-policy blah

and

  ip link set dev macsec0 mtu-policy blah2
  ip link set dev vxlan0 mtu-policy blah2

etc.

> Then I think that for non-ethernet devices, we should reject this
> option and skip it when dumping config. But yes, that's another
> possibility.
> 
> I personnaly don't really mind, as long as we keep a clear behaviour.
> 
> What I'd really like to avoid is something like:
>   - By default it behaves this way.
>   - If you modified the MTU it behaves in another way
>   - But if you modified the MTU but later restored the
>     original MTU, then you're back to the default behaviour
>     (or not?), unless the MTU of the upper device was also
>     changed meanwhile, in which case ... to be continued ...
>   - BTW, you might not be able to tell how the VLAN's MTU is going to
>     behave by simply looking at its configuration, because that also
>     depends on past configurations.
>   - Well, and if your kernel is older than xxx, then you always get the
>     default behaviour.
>   - ... and we might modify the heuristics again in the future to
>     accomodate with situations or use cases we failed to consider.

To be honest I'm still not clear if this is a real problem.
The patch does not specify what the use case is.
