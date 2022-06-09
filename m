Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DB1C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jun 2022 04:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237649AbiFIE7d (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jun 2022 00:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237025AbiFIE7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 00:59:30 -0400
Received: from smtp.smtpout.orange.fr (smtp01.smtpout.orange.fr [80.12.242.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712D01E4BE5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 21:59:27 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id zAGRnsqeNk3ICzAGRnIqe6; Thu, 09 Jun 2022 06:59:25 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 09 Jun 2022 06:59:25 +0200
X-ME-IP: 90.11.190.129
Message-ID: <22584780-a2eb-0a83-daaa-f259aa2adc42@wanadoo.fr>
Date:   Thu, 9 Jun 2022 06:59:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] virtio: Directly use ida_alloc_range()/ida_free()
Content-Language: en-US
To:     =?UTF-8?B?dG9tb3Jyb3cgV2FuZyAo546L5b635piOKQ==?= 
        <wangdeming@inspur.com>, "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>
Cc:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <aff7bba2680b49fab6a14694e33fd41d@inspur.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <aff7bba2680b49fab6a14694e33fd41d@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 09/06/2022 à 02:42, tomorrow Wang (王德明) a écrit :
>>
>> An explanation in the commit log of why the -1 is needed would also help
>> reviewer/maintainer, IMHO.
>>
>> It IS correct, but it is not that obvious without looking at
>> ida_simple_get() and ida_alloc_range().
>>
> 
> can I mention one patch about repair ida_free  for this.
> 
> 

If you manage to find another patch and provide a lore.kernel.org link 
to it, I think it should be okay.

However, after a *quick* look in some mailing list, I've not found yet a 
description for that.

CJ
