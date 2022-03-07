Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78070C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Mar 2022 18:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239395AbiCGS6A (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Mar 2022 13:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244848AbiCGS5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 13:57:46 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD2292D0E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 10:56:51 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 6E2812223A;
        Mon,  7 Mar 2022 19:56:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1646679408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jynvMdOjVlgIcz22WDLr8fvdTgkc/bKXr6LbivyuED4=;
        b=vTQ0XovIyiQumIN7uhXJjFwNCBoyivvrbaDyTk3gJthGdsbROQT927Em7CVFOuQVuBsgIt
        4dhmRp1AtvhBe7NDq9+8LJ2WACD8eK1Wjrb85DAVU0Y7weUjlz/cSp88Cf8FYin+9+q/HM
        S65yPk5N+6nGtVh4wEIUONSvrYCg1Co=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 07 Mar 2022 19:56:48 +0100
From:   Michael Walle <michael@walle.cc>
To:     Tudor.Ambarus@microchip.com
Cc:     p.yadav@ti.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, heiko.thiery@gmail.com
Subject: Re: [PATCH v1] mtd: spi-nor: unset quad_enable if SFDP doesn't
 specify it
In-Reply-To: <92cde38c-d398-44f4-26f8-ef4919f5944e@microchip.com>
References: <20220304185137.3376011-1-michael@walle.cc>
 <7f339d0c-5ca9-261c-a545-d4ebf3bda140@microchip.com>
 <92cde38c-d398-44f4-26f8-ef4919f5944e@microchip.com>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <7f947928e7189f98eb950828990b3920@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-03-07 10:23, schrieb Tudor.Ambarus@microchip.com:
> On 3/7/22 09:12, Tudor.Ambarus@microchip.com wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know 
>> the content is safe
>> 
>> On 3/4/22 20:51, Michael Walle wrote:
>>> EXTERNAL EMAIL: Do not click links or open attachments unless you 
>>> know the content is safe
>>> 
>>> While the first version of JESD216 specify the opcode for 4 bit I/O
>>> accesses, it lacks information on how to actually enable this mode.
>>> 
>>> For now, the one set in spi_nor_init_default_params() will be used.
>>> But this one is likely wrong for some flashes, in particular the
>>> Macronix MX25L12835F. Thus we need to clear the enable method when
>>> parsing the SFDP. Flashes with such an SFDP revision will have to use 
>>> a
>>> flash (and SFDP revision) specific fixup.
>>> 
>>> This might break quad I/O for some flashes which relied on the
>>> spi_nor_sr2_bit1_quad_enable() that was formerly set. If your bisect
>>> turns up this commit, you'll probably have to set the proper
>>> quad_enable method in a post_bfpt() fixup for your flash.
>>> 
>> 
>> Right, I meant adding a paragraph such as the one from above.
>> 
>>> Signed-off-by: Michael Walle <michael@walle.cc>
>>> Tested-by: Heiko Thiery <heiko.thiery@gmail.com>
>>> ---
>>> changes since RFC:
>>>  - reworded commit message
>>>  - added comment about post_bfpt hook
>>> 
>>> Tudor, I'm not sure what you meant with
>>>   Maybe you can update the commit message and explain why would some
>>>   flashes fail to enable quad mode, similar to what I did.
>>> 
>>> It doesn't work because the wrong method is chosen? ;)
>>> 
>>>  drivers/mtd/spi-nor/sfdp.c | 11 ++++++++++-
>>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>> 
>>> diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
>>> index a5211543d30d..6bba9b601846 100644
>>> --- a/drivers/mtd/spi-nor/sfdp.c
>>> +++ b/drivers/mtd/spi-nor/sfdp.c
>>> @@ -549,6 +549,16 @@ static int spi_nor_parse_bfpt(struct spi_nor 
>>> *nor,
>>>         map->uniform_erase_type = map->uniform_region.offset &
>>>                                   SNOR_ERASE_TYPE_MASK;
>>> 
>>> +       /*
>>> +        * The first JESD216 revision doesn't specify a method to 
>>> enable
>>> +        * quad mode. spi_nor_init_default_params() will set a legacy
>>> +        * default method to enable quad mode. We have to disable it
>>> +        * again.
>>> +        * Flashes with this JESD216 revision need to set the 
>>> quad_enable
>>> +        * method in their post_bfpt() fixup if they want to use quad 
>>> I/O.
>>> +        */
>> 
>> Great. Looks good to me. I'll change the subject to "mtd: spi-nor: 
>> sfdp:"
>> when applying.
> 
> As we talked on the meeting, we can instead move the default quad mode 
> init
> to the deprecated way of initializing the params, or/and to where 
> SKIP_SFDP
> is used. This way you'll no longer need to clear it here.

Mh, I just had a look and I'm not sure it will work there,
because in the deprecated way, the SFDP is still parsed and
thus we might still have the wrong enable method for flashes
which don't have PARSE_SFDP set.

-michael
