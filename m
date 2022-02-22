Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7422DC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Feb 2022 23:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236283AbiBVX2s (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Feb 2022 18:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235305AbiBVX2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 18:28:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C703C2A25C;
        Tue, 22 Feb 2022 15:28:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6B363B81CBB;
        Tue, 22 Feb 2022 23:28:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEAD6C340E8;
        Tue, 22 Feb 2022 23:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645572497;
        bh=0qNV1CqjAiQa3hQW/D/ZwwNUzvWSCy9eJtLIcIdCxrs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g1pv7mNxzgecQvF+0f1RHqUW0bELxM5HBmj7W1FWFa6mNU25UXIqF8hbMqPmmoq/7
         ycQuKBfalklYdSJ8HIQtojou/3BRWksJ5E612TlDEtPtIsYm8sbqlkkZhlEQ9ZFA5N
         3NrD6+mYdXx3yweOncUYRy/97Q9+wz8enNwg5GoEQD15ij5Q0NyDYaCjCB/DBmkl7Y
         17+ERs5GTRsONevva5kHNRkBtqo7T/okD+IekYEcAz+qL90C/vM4xdHZQbGFWf9BqF
         6thi9vvWOz13TdgBezOKC8tMyaPBZMFEcWarHtRaJj/HzR85yovWgrM+EUMxpjake5
         sAswcTPJLy9gQ==
Date:   Tue, 22 Feb 2022 15:28:15 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Guillaume Nault <gnault@redhat.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        "Ziyang Xuan (William)" <william.xuanziyang@huawei.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        Vasily Averin <vvs@virtuozzo.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: vlan: allow vlan device MTU change follow real
 device from smaller to bigger
Message-ID: <20220222152815.1056ca24@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20220222103733.GA3203@debian.home>
References: <20220221124644.1146105-1-william.xuanziyang@huawei.com>
        <CANn89iKyWWCbAdv8W26HwGpM9q5+6rrk9E-Lbd2aujFkD3GMaQ@mail.gmail.com>
        <YhQ1KrtpEr3TgCwA@gondor.apana.org.au>
        <8248d662-8ea5-7937-6e34-5f1f8e19190f@huawei.com>
        <CANn89iLf2ira4XponYV91cbvcdK76ekU7fDW93fmuJ3iytFHcw@mail.gmail.com>
        <20220222103733.GA3203@debian.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Feb 2022 11:37:33 +0100 Guillaume Nault wrote:
> What about an explicit option:
> 
>   ip link add link eth1 dev eth1.100 type vlan id 100 follow-parent-mtu
> 
> 
> Or for something more future proof, an option that can accept several
> policies:
> 
>   mtu-update <reduce-only,follow,...>
> 
>       reduce-only (default):
>         update vlan's MTU only if the new MTU is smaller than the
>         current one (current behaviour).
> 
>       follow:
>         always follow the MTU of the parent device.
> 
> Then if anyone wants more complex policies:
> 
>       follow-if-not-modified:
>         follow the MTU of the parent device as long as the VLAN's MTU
>         was not manually changed. Otherwise only adjust the VLAN's MTU
>         when the parent's one is set to a smaller value.
> 
>       follow-if-not-modified-but-not-quite:
>         like follow-if-not-modified but revert back to the VLAN's
>         last manually modified MTU, if any, whenever possible (that is,
>         when the parent device's MTU is set back to a higher value).
>         That probably requires the possibility to dump the last
>         modified MTU, so the administrator can anticipate the
>         consequences of modifying the parent device.
> 
>      yet-another-policy (because people have a lot of imagination):
>        for example, keep the MTU 4 bytes lower than the parent device,
>        to account for VLAN overhead.
> 
> Of course feel free to suggest better names and policies :).
> 
> This way, we can keep the current behaviour and avoid unexpected
> heuristics that are difficult to explain (and even more difficult for
> network admins to figure out on their own).

My $0.02 would be that if we want to make changes that require new uAPI
we should do it across uppers.
