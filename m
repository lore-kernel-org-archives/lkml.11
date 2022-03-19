Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9423DC433FE
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Mar 2022 10:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242657AbiCSKGV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Mar 2022 06:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235071AbiCSKGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 06:06:18 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367982CD832;
        Sat, 19 Mar 2022 03:04:56 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1nVVwx-0003do-2B; Sat, 19 Mar 2022 11:04:43 +0100
Date:   Sat, 19 Mar 2022 11:04:43 +0100
From:   Florian Westphal <fw@strlen.de>
To:     zhouzhouyi@gmail.com
Cc:     edumazet@google.com, davem@davemloft.net, yoshfuji@linux-ipv6.org,
        dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Xu <xuweihf@ustc.edu.cn>
Subject: Re: [PATCH] net:ipv4: send an ack when seg.ack > snd.nxt
Message-ID: <20220319100443.GA13956@breakpoint.cc>
References: <20220319090142.137998-1-zhouzhouyi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220319090142.137998-1-zhouzhouyi@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zhouzhouyi@gmail.com <zhouzhouyi@gmail.com> wrote:
> -	if (after(ack, tp->snd_nxt))
> +	if (after(ack, tp->snd_nxt)) {
> +		tcp_send_ack(sk);
>  		return -1;
> +	}

If we really need to do this we need to
  if (!(flag & FLAG_NO_CHALLENGE_ACK))
	tcp_send_challenge_ack(sk);

... else this might result in two acks?
Whats the problem thats being fixed here?
