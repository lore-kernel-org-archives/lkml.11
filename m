Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF18C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Mar 2022 06:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiCQGII (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Mar 2022 02:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiCQGHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 02:07:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6B119315A;
        Wed, 16 Mar 2022 22:42:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87DE36176A;
        Thu, 17 Mar 2022 04:05:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 254F7C340E9;
        Thu, 17 Mar 2022 04:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647489936;
        bh=NGN9ZhkibSIf00mfrRrfihSPTloWTNjxCfxfbDIq/Hs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aLh9rNSOkAFytCS8Z6mFXcO9YVBj4JsA2EgLEVv+SuQbXfgpIQlXWIHiB02uwdloX
         rILE1trsxG8UIQfRXImbAl7sIM+pbH8qjC1lRCI0vh+MYkm8TZHpNIx3Fy9Qv5hhA1
         lRCe3GeVHLBRFXpXvYdNSzLSIzeBWyop1NI4Vvp/rinYWnfBunx5gigrWhptuP2W2I
         /uTb8FElp4xGu5Drf9TettlTNtWQ3BVrlCPy7mZ9KqjqT8l3UCoAMatcUdbJlcalSv
         gbOPdJ6vxWXR9B0lycilHPgcMXiNs8rvGCgw6+HhC9nBcnuadvV1QtGm8cdjtHbXKj
         VdRql+nyKrwww==
Date:   Wed, 16 Mar 2022 21:05:34 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     David Ahern <dsahern@kernel.org>
Cc:     menglong8.dong@gmail.com, pabeni@redhat.com, rostedt@goodmis.org,
        mingo@redhat.com, xeb@mail.ru, davem@davemloft.net,
        yoshfuji@linux-ipv6.org, imagedong@tencent.com,
        edumazet@google.com, kafai@fb.com, talalahmad@google.com,
        keescook@chromium.org, alobakin@pm.me, flyingpeng@tencent.com,
        mengensun@tencent.com, dongli.zhang@oracle.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        benbjiang@tencent.com
Subject: Re: [PATCH net-next v3 3/3] net: icmp: add reasons of the skb drops
 to icmp protocol
Message-ID: <20220316210534.06b6cfe0@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <4315b50e-9077-cc4b-010b-b38a2fbb7168@kernel.org>
References: <20220316063148.700769-1-imagedong@tencent.com>
        <20220316063148.700769-4-imagedong@tencent.com>
        <20220316201853.0734280f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <4315b50e-9077-cc4b-010b-b38a2fbb7168@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Mar 2022 21:35:47 -0600 David Ahern wrote:
> On 3/16/22 9:18 PM, Jakub Kicinski wrote:
> > 
> > I guess this set raises the follow up question to Dave if adding 
> > drop reasons to places with MIB exception stats means improving 
> > the granularity or one MIB stat == one reason?
> 
> There are a few examples where multiple MIB stats are bumped on a drop,
> but the reason code should always be set based on first failure. Did you
> mean something else with your question?

I meant whether we want to differentiate between TYPE, and BROADCAST or
whatever other possible invalid protocol cases we can get here or just
dump them all into a single protocol error code.
