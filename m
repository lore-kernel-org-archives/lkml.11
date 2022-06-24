Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7243FC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jun 2022 15:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbiFXPND (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jun 2022 11:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbiFXPM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 11:12:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5EA2186;
        Fri, 24 Jun 2022 08:12:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E286FB828E0;
        Fri, 24 Jun 2022 15:12:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31881C3411C;
        Fri, 24 Jun 2022 15:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656083573;
        bh=ArJ8nSdj0KHrFxlJPaWywYeKHfHuOQzKJrys9Xs47W8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dx935WPKb7QJ2yLN16HJ1iz7aKxhGDBE5pjEGe9oP6SmaBHVWnjKFxXM20WMyflUU
         3neeQUHhMipjcYsOXG/QSWj51eSc058sdu+bpFyPYBrsHJGmCfOaeWFJTmhPgZqtQ9
         I3H4SKlDpXz4ZtAC1XgYOU3yb9sFuvGoPUxa7A68spy/DSwgM+Nicr3Ki3JhhY08cB
         BtN4nDSdG6Mgrn64JBXmUDvRIPsIm7n1CHea4iOyhdbETz9QprT2L5nb6c3A0qtu12
         EpRGWVgwE071rFYImgdcDfXM1ubejHcSvnrYTCLbjEsMnMUh2wAXigkmjJRkc6nyMw
         5xzKg7XqXQ0mQ==
Message-ID: <ad7673eb-ff0d-ce39-e05d-6af3be5ac68c@kernel.org>
Date:   Fri, 24 Jun 2022 09:12:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH] ipv6/sit: fix ipip6_tunnel_get_prl when memory allocation
 fails
Content-Language: en-US
To:     zys.zljxml@gmail.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, yoshfuji@linux-ipv6.org
Cc:     kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
        eric.dumazet@gmail.com, pabeni@redhat.com,
        katrinzhou <katrinzhou@tencent.com>
References: <20220624081254.1251316-1-zys.zljxml@gmail.com>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <20220624081254.1251316-1-zys.zljxml@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/22 2:12 AM, zys.zljxml@gmail.com wrote:
> diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
> index c0b138c20992..4fb84c0b30be 100644
> --- a/net/ipv6/sit.c
> +++ b/net/ipv6/sit.c
> @@ -323,8 +323,6 @@ static int ipip6_tunnel_get_prl(struct net_device *dev, struct ip_tunnel_prl __u
>  		kcalloc(cmax, sizeof(*kp), GFP_KERNEL_ACCOUNT | __GFP_NOWARN) :
>  		NULL;
>  
> -	rcu_read_lock();
> -
>  	ca = min(t->prl_count, cmax);
>  
>  	if (!kp) {
> @@ -337,11 +335,12 @@ static int ipip6_tunnel_get_prl(struct net_device *dev, struct ip_tunnel_prl __u
>  					      __GFP_NOWARN);
>  		if (!kp) {
>  			ret = -ENOMEM;
> -			goto out;
> +			goto err;
>  		}
>  	}
>  
>  	c = 0;
> +	rcu_read_lock();
>  	for_each_prl_rcu(t->prl) {
>  		if (c >= cmax)
>  			break;
> @@ -362,7 +361,7 @@ static int ipip6_tunnel_get_prl(struct net_device *dev, struct ip_tunnel_prl __u
>  		ret = -EFAULT;
>  
>  	kfree(kp);
> -
> +err:
>  	return ret;
>  }
>  

'out' label is no longer used and should be removed.
