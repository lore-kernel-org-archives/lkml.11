Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C739EC433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 21 May 2022 04:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239170AbiEUE1x (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 May 2022 00:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235127AbiEUE1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 00:27:48 -0400
Received: from m12-11.163.com (m12-11.163.com [220.181.12.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CDD50185402;
        Fri, 20 May 2022 21:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Message-ID:Date:MIME-Version:Subject:From; bh=e/Ov0
        lqfN8UhhLpL9Uu3zMOTTxiC1rpZZKHr2yVZ1rg=; b=SOmvlyvIh+C35HVGHw9ut
        vnAzVXnWv6hCPtoNlcLmBJxQ1f9+l7sSd4uAx0L8lahEzSZcaveZgtGTIxoFFgtG
        3OlhvOBCUZxKaxIympHFAqbfu5aY3LI1Vxwc/nPnLys3evL3zUFkRvSxI9pj9JKv
        rpRVjY1uuq0QI+yAR3HKsw=
Received: from [192.168.3.102] (unknown [218.201.129.20])
        by smtp7 (Coremail) with SMTP id C8CowAAnZ3vjaYhiPV91Dg--.11075S2;
        Sat, 21 May 2022 12:26:12 +0800 (CST)
Message-ID: <0936de49-a349-8fd4-2598-2a8995b01c86@163.com>
Date:   Sat, 21 May 2022 12:26:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v4 0/2] ARM: sun8i-r40: Enable usb otg support
Content-Language: en-US
To:     Evgeny Boger <boger@wirenboard.com>
Cc:     andre.przywara@arm.com, devicetree@vger.kernel.org,
        jernej.skrabec@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, robh+dt@kernel.org,
        samuel@sholland.org, wens@csie.org
References: <264cb004-677a-13df-cc68-676ef3c2e7d8@163.com>
 <ec5f7fe8-d47d-ce7f-0e0a-2bdf41a88ba2@wirenboard.com>
From:   qianfan <qianfanguijin@163.com>
In-Reply-To: <ec5f7fe8-d47d-ce7f-0e0a-2bdf41a88ba2@wirenboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8CowAAnZ3vjaYhiPV91Dg--.11075S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZryDKFW7AF1fJFW5Aw48Crg_yoW5AF1fpF
        W8KrW3Cr4vk3y0y3yqgw48uFWjqrs5KF43Ga1kGw48X3s8AasYvr1IyrW5ta48ZFn3Xay2
        qFy5X3WDW3WqyaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07joksgUUUUU=
X-Originating-IP: [218.201.129.20]
X-CM-SenderInfo: htld0w5dqj3xxmlqqiywtou0bp/xtbB2AwI7WBHKkk3ygAAsI
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/5/20 4:54, Evgeny Boger 写道:
> Hi qianfan,
>
> As Allwinner A40i user, let me first thank you for your effort for 
> making better upstream support for R40!
>
> However, I would strongly suggest *not* to add USB support to one more 
> Allwinner SoC in this particular way.
> The problem is, this approach consists of a number of carefully 
> crafted hacks in device tree to make current drivers work on Allwinner 
> hardware without modification to the drivers.
>
> a few examples:
>
> 1) please notice how ohci0 and ehci0 nodes do not contain reference to 
> usb phy. It is done intentionally, otherwise EHCI will reset musb mode.
> Of course omitting phy reference here is also completely breaking 
> power cycling in case of usb error and otherwise messes with a power 
> management.
>
> 2) one must always enable ohci, ehci and usb_otg nodes at the same 
> time. If one forgets to enable ohci/ehci nodes while enabling usb_otg 
> node, the system will silently fail to work as USB host.
>
> 3) For host-only mode we still have to enable usb_otg node despite no 
> role switching is needed. That's because phy reference is missing in 
> ehci/ohci, so the ehci/ohci driver won't enable the PHY.
> Also I might be wrong, but I think phy won't be routed to ehci/ohci 
> controllers is this case.
>
> 4) musb host controller is initialized and present to hardware though 
> never actually used
>
> To summarize, not only the resulting device tree is not describing the 
> hardware properly, it is creating device tree configuration which will 
> be very hard to support in future, once proper driver support is in 
> place.
PHY setting is did in MUSB driver, so we need enable MUSB regardless of 
host mode.

I know your's point, OHCI/EHCI need do more works to init USBPHY, it 
shoule be able to work
in dependently, but I don't have the ability to deal with these things 
right now, I need
learn more things about OHCI/EHCI, that's a long-term goal.

So now I need to make the whole usb work and do some tests as much as 
possible,
hoping to merge this patch into master. Some other optimizations can be 
made later.

Thanks for yours guide.
>
>
> At Wiren Board kernel tree we tried to untangle this issue [1-6]. 
> Unfortunately I didn't have time to prepare it for kernel submission 
> yet, but I think I better submit it as RFC to get a feedback from you 
> and others.
>
>
> [1] 
> https://github.com/wirenboard/linux/commit/359abbbd86ddff4d3c61179c882c286de32bb089
> [2] 
> https://github.com/wirenboard/linux/commit/6327f9d7972c21b229fb83457fdde643b31553f9
> [3] 
> https://github.com/wirenboard/linux/commit/f01f4c66758bde460a4d8c5b54ecee3b585c0232
> [4] 
> https://github.com/wirenboard/linux/commit/c27598ad601e5a46f624b73412a531d6f1f63d37
> [5] 
> https://github.com/wirenboard/linux/commit/5796d6eebb86b32a3751b2038b63af46f94954b3
> [6] 
> https://github.com/wirenboard/linux/commit/0928a675d875f9c2849fd3a9888f718bbb673bda
>
>

