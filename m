Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A242FC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Mar 2022 14:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356915AbiCPO5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Mar 2022 10:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346464AbiCPO5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 10:57:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BDD66AE4;
        Wed, 16 Mar 2022 07:56:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76602B81B9C;
        Wed, 16 Mar 2022 14:56:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F068DC340E9;
        Wed, 16 Mar 2022 14:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647442576;
        bh=qqQodrddbOG2kNSyXN0MaEI+Rphq9l9zxCo9YGmpGCo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VVj07273ngZHg/dCg+geeWRkBS/WwhTqptxMeYb72lfXqSo2jFoi4dvm8VP76dJG9
         iSay+S/X0pDaygtTkSl1nQ8gbP9hW75Qrvv273piCITyiqlyzS6cOGqDQ2536pLpt+
         QZe3SKyfcvfNlkblA9+uTsBJBqqMyoLBRf3757ZxWlYqCQUhKtank+rN36qcJ3MZZw
         QGrN2C/Jo40McV2HCjDjIGb5yT7y0J5PkJhlpz/elAqUm6MRXkxjU5n5dD8ElEyHUR
         TZr2PVUBNJiywU3eXv6ririiGPCo5J9+1P2ybh/31PDQuotXoXNlg0Yn/uFXfhEMoT
         ANB1uqSIB+W1g==
Message-ID: <30b0991a-8c41-2571-b1b6-9edc7dc9c702@kernel.org>
Date:   Wed, 16 Mar 2022 08:56:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.2
Subject: Re: [PATCH net-next 1/3] net: gre_demux: add skb drop reasons to
 gre_rcv()
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     menglong8.dong@gmail.com, rostedt@goodmis.org, mingo@redhat.com,
        xeb@mail.ru, davem@davemloft.net, yoshfuji@linux-ipv6.org,
        imagedong@tencent.com, edumazet@google.com, kafai@fb.com,
        talalahmad@google.com, keescook@chromium.org, alobakin@pm.me,
        flyingpeng@tencent.com, mengensun@tencent.com,
        dongli.zhang@oracle.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Biao Jiang <benbjiang@tencent.com>
References: <20220314133312.336653-1-imagedong@tencent.com>
 <20220314133312.336653-2-imagedong@tencent.com>
 <20220315200847.68c2efee@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <daa287f3-fbed-515d-8f37-f2a36234cc8a@kernel.org>
 <20220315215553.676a5d24@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <20220315215553.676a5d24@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/22 10:55 PM, Jakub Kicinski wrote:
> On Tue, 15 Mar 2022 21:49:01 -0600 David Ahern wrote:
>>>>  	ver = skb->data[1]&0x7f;
>>>> -	if (ver >= GREPROTO_MAX)
>>>> +	if (ver >= GREPROTO_MAX) {
>>>> +		reason = SKB_DROP_REASON_GRE_VERSION;  
>>>
>>> TBH I'm still not sure what level of granularity we should be shooting
>>> for with the reasons. I'd throw all unexpected header values into one 
>>> bucket, not go for a reason per field, per protocol. But as I'm said
>>> I'm not sure myself, so we can keep what you have..  
>>
>> I have stated before I do not believe every single drop point in the
>> kernel needs a unique reason code. This is overkill. The reason augments
>> information we already have -- the IP from kfree_skb tracepoint.
> 
> That's certainly true. I wonder if there is a systematic way of
> approaching these additions that'd help us picking the points were 
> we add reasons less of a judgment call.

In my head it's split between OS housekeeping and user visible data.
Housekeeping side of it is more the technical failure points like skb
manipulations - maybe interesting to a user collecting stats about how a
node is performing, but more than likely not. IMHO, those are ignored
for now (NOT_SPECIFIED).

The immediate big win is for packets from a network where an analysis
can show code location (instruction pointer), user focused reason (csum
failure, 'otherhost', no socket open, no socket buffer space, ...) and
traceable to a specific host (headers in skb data).
