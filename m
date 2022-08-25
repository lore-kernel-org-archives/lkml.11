Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0F7C04AA5
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Aug 2022 09:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238603AbiHYJyx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Aug 2022 05:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239774AbiHYJyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 05:54:25 -0400
X-Greylist: delayed 354 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 25 Aug 2022 02:52:46 PDT
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172F1AE9F7;
        Thu, 25 Aug 2022 02:52:45 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id D02C3402B;
        Thu, 25 Aug 2022 11:46:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1661420808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MmqCI6NdaD8MiJoPnI7CffU1uRQPtkasbItKLLzsgpU=;
        b=Cp5ZKGWQ5qk9vhOrmIFp2QnGnK6gL+V0zsuDCu+RGRapPXgaOatkBOhuW39Qx5zIcc7Hh1
        +furDz9au55yxHcxLGszruYKhuYDGYLdCSWYcin/WuI6GFw75J4DhX/YsA8lKa5cTXsthN
        aiuvWO+q1Oa6hSgLusApf/TwZn53tb6EAlZzJ7wi4Nn7zGHew/pY8L7SXXss53zntdvJVB
        3/UJe1Ru+nia/h+louFDx7RVfHXAIp3nMZA2UkMwcOkLIX7IU/xbxOCXZ2+pn1QA02o5cf
        feCCoG6ox/eKVXYJFFoXJs2ofwOiABU3afC8FZ3y/toka+q5ccyVifDiPX2dnA==
MIME-Version: 1.0
Date:   Thu, 25 Aug 2022 11:46:48 +0200
From:   Michael Walle <michael@walle.cc>
To:     =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Frank Rowand <frowand.list@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 5/8] net: add helper eth_addr_add()
In-Reply-To: <0d9a0ce5-ab34-cf05-158e-e25fc5595b4d@gmail.com>
References: <20211228142549.1275412-1-michael@walle.cc>
 <20211228142549.1275412-6-michael@walle.cc>
 <0d9a0ce5-ab34-cf05-158e-e25fc5595b4d@gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <d6fe1cfc6daa78868ba85553998c9c3d@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-01-25 11:24, schrieb Rafał Miłecki:
> On 28.12.2021 15:25, Michael Walle wrote:
>> Add a helper to add an offset to a ethernet address. This comes in 
>> handy
>> if you have a base ethernet address for multiple interfaces.
>> 
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> ---
>>   include/linux/etherdevice.h | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>> 
>> diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
>> index 2ad71cc90b37..9d621dc85290 100644
>> --- a/include/linux/etherdevice.h
>> +++ b/include/linux/etherdevice.h
>> @@ -486,6 +486,20 @@ static inline void eth_addr_inc(u8 *addr)
>>   	u64_to_ether_addr(u, addr);
>>   }
>>   +/**
>> + * eth_addr_add() - Add (or subtract) and offset to/from the given 
>> MAC address.
>> + *
>> + * @offset: Offset to add.
>> + * @addr: Pointer to a six-byte array containing Ethernet address to 
>> increment.
>> + */
>> +static inline void eth_addr_add(u8 *addr, long offset)
>> +{
>> +	u64 u = ether_addr_to_u64(addr);
>> +
>> +	u += offset;
>> +	u64_to_ether_addr(u, addr);
>> +}
> 
> Please check eth_hw_addr_gen() which contains identical code +
> eth_hw_addr_set().
> 
> You should probably make eth_hw_addr_gen() use your new function as a
> helper.

You'd need to copy the mac address first because eth_addr_add()
modifies the mac address in place. I don't see that this is
improving anything.

-michael
