Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA84C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Feb 2022 15:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242251AbiBYPkC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Feb 2022 10:40:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242235AbiBYPj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 10:39:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAE01D6C85;
        Fri, 25 Feb 2022 07:39:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D191618D8;
        Fri, 25 Feb 2022 15:39:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82205C340E7;
        Fri, 25 Feb 2022 15:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645803560;
        bh=01AtR9UlQ8B2u4YFKvs9jD1gUCizvmtnrjMGBb3QC98=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=W88tZtw68FGmY/0/E5NAGiAyRgqf5O3vnRrj0/Jdc2ZXvjAnuuAHKWFGs2so+805k
         qFLeeDjWGa1v9dSvk9+Mo4696qkd3/dBQc4XKBN4vFoSVLRFbnQY4Em9iCwmgkd5ul
         H1CKrwGK9AE45yb0+rJQ5c7cmCY4TVK/VqGYLJRU1r3MyXAtE2i0w7RgYoPZOqvjSM
         AtRCMRBme02zUrUW41/sMjEf085YpOSXT2SrSH79GCMqnuXWslb4LX6j3QFkqLQCKK
         Z88ZkyOmjJGr9c2+faHqGT6qovzX9I/UfCqGx5LiuQ0/U6oBm5dLq4b4+sSivUpjbl
         1Rfe9j5bqQQuA==
Message-ID: <aa952972-7041-26a8-e758-3f2801dff534@kernel.org>
Date:   Fri, 25 Feb 2022 08:39:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH net-next v2 2/3] net: neigh: use kfree_skb_reason() for
 __neigh_event_send()
Content-Language: en-US
To:     menglong8.dong@gmail.com
Cc:     rostedt@goodmis.org, mingo@redhat.com, davem@davemloft.net,
        kuba@kernel.org, yoshfuji@linux-ipv6.org, imagedong@tencent.com,
        edumazet@google.com, alobakin@pm.me, cong.wang@bytedance.com,
        paulb@nvidia.com, talalahmad@google.com, keescook@chromium.org,
        ilias.apalodimas@linaro.org, memxor@gmail.com,
        flyingpeng@tencent.com, mengensun@tencent.com,
        daniel@iogearbox.net, yajun.deng@linux.dev, roopa@nvidia.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20220225071739.1956657-1-imagedong@tencent.com>
 <20220225071739.1956657-3-imagedong@tencent.com>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <20220225071739.1956657-3-imagedong@tencent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/22 12:17 AM, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <imagedong@tencent.com>
> 
> Replace kfree_skb() used in __neigh_event_send() with
> kfree_skb_reason(). Following drop reasons are added:
> 
> SKB_DROP_REASON_NEIGH_FAILED
> SKB_DROP_REASON_NEIGH_QUEUEFULL
> SKB_DROP_REASON_NEIGH_DEAD
> 
> The first two reasons above should be the hot path that skb drops
> in neighbour subsystem.
> 
> Reviewed-by: Mengen Sun <mengensun@tencent.com>
> Reviewed-by: Hao Peng <flyingpeng@tencent.com>
> Signed-off-by: Menglong Dong <imagedong@tencent.com>
> ---
> v2:
> - introduce the new drop reason 'SKB_DROP_REASON_NEIGH_DEAD'
> - simplify the document for the new drop reasons
> ---
>  include/linux/skbuff.h     | 5 +++++
>  include/trace/events/skb.h | 3 +++
>  net/core/neighbour.c       | 6 +++---
>  3 files changed, 11 insertions(+), 3 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>

