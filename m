Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE07C43334
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jun 2022 12:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346043AbiFDM6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jun 2022 08:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344883AbiFDM6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 08:58:32 -0400
Received: from smtp.smtpout.orange.fr (smtp05.smtpout.orange.fr [80.12.242.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0939E13FA2
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 05:58:29 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id xTMInx8Q26rrExTMInf9Dc; Sat, 04 Jun 2022 14:58:28 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 04 Jun 2022 14:58:28 +0200
X-ME-IP: 90.11.190.129
Message-ID: <d7be07bb-2234-ae9c-b2b8-b8d23cce5978@wanadoo.fr>
Date:   Sat, 4 Jun 2022 14:58:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] nfp: Remove kernel.h when not needed
Content-Language: en-US
To:     Simon Horman <simon.horman@corigine.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, oss-drivers@corigine.com,
        netdev@vger.kernel.org
References: <e9bafd799489215710f7880214b58d6487407248.1654320767.git.christophe.jaillet@wanadoo.fr>
 <YpsjFwNv5s14sdhD@corigine.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <YpsjFwNv5s14sdhD@corigine.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 04/06/2022 à 11:17, Simon Horman a écrit :
> On Sat, Jun 04, 2022 at 07:33:00AM +0200, Christophe JAILLET wrote:
>> When kernel.h is used in the headers it adds a lot into dependency hell,
>> especially when there are circular dependencies are involved.
>>
>> Remove kernel.h when it is not needed.
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> Thanks for improving the NFP driver.
> 
> I think the contents of this patch looks good.
> 
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
> 
> I also think this patch is appropriate for net-next
> ("[PATCH net-next] ..." in subject) and should thus be re-submitted
> once net-next re-opens for the v5.20 development cycle, which I would
> expect to happen in the coming days, after v5.19-rc1 has been released.
> 
> I'm happy to handle re-submitting it if you prefer.
> 

Hi,
if you don't mind, yes I prefer.

Dealing with timing of release cycles and prefix depending on where the 
patch should land is a bit too much for me.

Thank you for your help :)

CJ
