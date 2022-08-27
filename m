Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833A8ECAAD5
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Aug 2022 02:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbiH0CqX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Aug 2022 22:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiH0CqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 22:46:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7187AE7266;
        Fri, 26 Aug 2022 19:46:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7BDFB83387;
        Sat, 27 Aug 2022 02:46:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209FEC433C1;
        Sat, 27 Aug 2022 02:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661568377;
        bh=lrKD4wXLL55A4dSy805qVttWuDV5BsmjYOQPLQfvxWg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eqe0d+IpjnNf+H9Siy0BxztNh0PTxdDBHTRTfL4knU6p6MeVAL4Co4KVZJ2kxH9Qg
         mz2qJbVGqAB/CVq9KaG3eQQAlXHXR7l/0jQUmGnz19uZGcLThHPuCo4t9mgF9Wat0U
         xk0vuH49ZgRbjN5TAWwbQ0yrT6O18HCseACj3otpaB2gwADuThIK+TBzfWIz6WL1+f
         p/HN/lZEW8mD3XztN/idObS9f+oHiDUG4veaszU6DL+USE6REBxfL2sJM/1avnVNcG
         l49xrnLOBVDWnktORy7JJF3QZvwj7hzkQtIb2kp5XIlcs4fJ8FJuxXIgsNLnNVFL2W
         QO/01mMrSjDqQ==
Date:   Fri, 26 Aug 2022 19:46:16 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Zhengchao Shao <shaozhengchao@huawei.com>
Cc:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <jhs@mojatatu.com>, <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>,
        <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>
Subject: Re: [PATCH -next] net: sched: sch_skbprio: add support for qlen
 statistics of each priority in sch_skbprio
Message-ID: <20220826194616.37abfe9e@kernel.org>
In-Reply-To: <20220825102745.70728-1-shaozhengchao@huawei.com>
References: <20220825102745.70728-1-shaozhengchao@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Aug 2022 18:27:45 +0800 Zhengchao Shao wrote:
> diff --git a/net/sched/sch_skbprio.c b/net/sched/sch_skbprio.c
> index 7a5e4c454715..fe2bb7bf9d2a 100644
> --- a/net/sched/sch_skbprio.c
> +++ b/net/sched/sch_skbprio.c
> @@ -83,6 +83,7 @@ static int skbprio_enqueue(struct sk_buff *skb, struct Qdisc *sch,
>  		__skb_queue_tail(qdisc, skb);

The skb queue called "qdisc" here (confusingly) already maintains 
a length (also called qlen). Can we just access that variable instead
of maintaining the same value manually?

>  		qdisc_qstats_backlog_inc(sch, skb);
>  		q->qstats[prio].backlog += qdisc_pkt_len(skb);
> +		q->qstats[prio].qlen++;

