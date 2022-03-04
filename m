Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39331C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Mar 2022 11:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236728AbiCDLM5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Mar 2022 06:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbiCDLMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 06:12:54 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C33184B42
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 03:12:06 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1nQ5qW-0000S2-O5; Fri, 04 Mar 2022 12:11:40 +0100
Message-ID: <f9e46b61-37e5-a280-edb0-27f8e81a8680@pengutronix.de>
Date:   Fri, 4 Mar 2022 12:11:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [BUG] mtd: cfi_cmdset_0002: write regression since v4.17-rc1
Content-Language: en-US
To:     Tokunori Ikegami <ikegami.t@gmail.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        linux-mtd@lists.infradead.org, Joakim.Tjernlund@infinera.com,
        miquel.raynal@bootlin.com, vigneshr@ti.com, richard@nod.at,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>, marek.vasut@gmail.com,
        cyrille.pitchen@wedev4u.fr,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linuxppc-dev@lists.ozlabs.org
References: <b687c259-6413-26c9-d4c9-b3afa69ea124@pengutronix.de>
 <dff2abcc-5813-2f2c-35ba-f03cd1f35ac3@leemhuis.info>
 <e11b76dc-5539-fb7e-da1c-a5005713d6b0@gmail.com>
 <3dbbcee5-81fc-cdf5-9f8b-b6ccb95beddc@pengutronix.de>
 <0f2cfcac-83ca-51a9-f92c-ff6495dca1d7@gmail.com>
 <b231b498-c8d2-28af-ce66-db8c168047f7@pengutronix.de>
 <66ee55d9-4f20-6722-6097-e53c2108ea07@gmail.com>
 <579eab10-594c-d6b2-0ddb-ea6ab8e02856@pengutronix.de>
 <cedb1604-e024-2738-5b33-15703a653803@gmail.com>
 <117facba-ba33-349d-1085-25315cc1ae92@gmail.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <117facba-ba33-349d-1085-25315cc1ae92@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tokunori-san,

On 20.02.22 13:22, Tokunori Ikegami wrote:
> Hi Ahmad-san,
> 
> Could you please try the version 2 patch attached for the error case?
> This version is to check the DQ true data 0xFF by chip_good().

I had a similar patch locally as well at first. I just tested yours
and I can't reproduce the issue.

> But I am not sure if this works or not since the error is possible to be caused by Hi-Z 0xff on floating bus or etc.

That it works for me could be because of Hi-Z 0xff, which is why
decided against it.

>>>>> What seems to work for me is checking if chip_good or chip_ready
>>>>> and map_word is equal to 0xFF. I can't justify why this is ok though.
>>>>> (Worst case bus is floating at this point of time and Hi-Z is read
>>>>> as 0xff on CPU data lines...)
>>>> Sorry I am not sure about this.
>>>> I thought the chip_ready() itself is correct as implemented as the data sheet in the past.
>>>> But it did not work correctly so changed to use chip_good() instead as it is also correct.
>>> What exactly in the datasheet makes you believe chip_good is not appropriate?
>> I just mentioned about the actual issue behaviors as not worked chip_good() on S29GL964N and not worked chip_ready() on MX29GL512FHT2I-11G before etc.
>> Anyway let me recheck the data sheet details as just checked it again quickly but needed more investigation to understand.
> 
> As far as I checked still both chip_good() and chip_ready() seem correct but still the root cause is unknown.
> If as you mentioned the issue was cased by the DQ true data 0xFF I am not sure why the read work without any error after the write operation.
> Also if the error was caused by the Hi-Z 0xff on floating bus as mentioned I am not sure why the read work without any error after the write operation with chip_ready().
> Sorry anyway the root cause is also unknown when the write operation was changed to use chip_good() instead of chip_ready().

I've be ok with v1 then. Restores working behavior for me and shouldn't break others.

Cheers and thanks again,
Ahmad

> 
> Regards,
> Ikegami
> 
>>
>> Regards,
>> Ikegami
>>
>>>
>>> Cheers,
>>> Ahmad
>>>
>>>


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
