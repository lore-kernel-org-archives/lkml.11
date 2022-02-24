Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562D2C433FE
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Feb 2022 14:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235674AbiBXOzj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Feb 2022 09:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235666AbiBXOzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 09:55:37 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D25E254557;
        Thu, 24 Feb 2022 06:55:07 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 7222122236;
        Thu, 24 Feb 2022 15:55:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645714505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T+nj1LXBgfdrS//vBjhL1t/BXLWyCGMXuhBk/lp7Sdg=;
        b=ZYnGOLI3clP5LcOWs885rEZZGnWxdvib1aqxw55IsYSY9PxQ7EQ3Bc22QVXlmPvWSnY6bU
        llsZXULjwETbIUxvEhbQFNcjm3epozqWTzSQ/jzJsnrAuELy3ctqnHRWN/eTvVGvkQwcNg
        vAykG5noDJl9oVC+mWgON4IU3bDxT5U=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 24 Feb 2022 15:55:05 +0100
From:   Michael Walle <michael@walle.cc>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        arnd@arndb.de, alexandre.belloni@bootlin.com, olof@lixom.net,
        soc@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com,
        Manohar.Puri@microchip.com
Subject: Re: [PATCH v7] ARM: dts: add DT for lan966 SoC and 2-port board
 pcb8291
In-Reply-To: <85566f97-dcfc-f477-1ebb-5cac955b791a@microchip.com>
References: <20220221080858.14233-1-kavyasree.kotagiri@microchip.com>
 <3b4c56201a478876783e69243c901cd8@walle.cc>
 <85566f97-dcfc-f477-1ebb-5cac955b791a@microchip.com>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <413b29b8a2e7a73561f942d4b7c78b9b@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 2022-02-24 15:51, schrieb Nicolas Ferre:
>>> +/ {
>>> +     model = "Microchip LAN966 family SoC";
>>> +     compatible = "microchip,lan966";
>> 
>> As mentioned earlier, this isn't a documented compatible string. So,
>> I guess without overwriting this in the board dts it will throw an
>> error with the dt schema validator. OTOH, there are many dtsi files
>> in arch/arm/boot/dts/ doing this. I don't know what is correct here.
> 
> I see it documented here:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/arm/atmel-at91.yaml#n165
> 
> Isn't it what is expected?

That only documents
   compatible = "microchip,lan9662-pcb8291", "microchip,lan9662", 
"microchip,lan966";

But not the one above.

> 
>> Everthing else looks good.
> 
> Thanks a lot for your reviews.
> 
>> Reviewed-by: Michael Walle <michael@walle.cc>
> 
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> I'm queuing it to at91-dt branch for reaching arm-soc in 5.18 merge 
> window.

Nice, then I'm good to go for my patches on top of this :)

-michael
