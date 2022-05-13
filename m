Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97E3C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 May 2022 17:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382417AbiEMRWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 May 2022 13:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381904AbiEMRWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 13:22:00 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFF253A60
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 10:21:55 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 0374D221D4;
        Fri, 13 May 2022 19:21:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1652462513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QMV8VRxmSptJXLRk6YRt/p7jiW7WuIAN+Y3frdH9Rt0=;
        b=eWYiklEo44ZYsfC1Bt+l2zVQZYk65FzJe5tSi1A3/ClC5oZi7njpRcslmOah4tktSnm9Y2
        ePVWvTK+XECyPeTripAfD5pIt7w7RZkRTqW/B5oSt1cyWar6GVKK7W2lelWSibH5kZI0Kj
        Y6PTTjgbhOEWd/aO5ZNigpAOjhPDl2o=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 13 May 2022 19:21:52 +0200
From:   Michael Walle <michael@walle.cc>
To:     Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc:     linux-mtd@lists.infradead.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: Support Dual and Quad Read on Macronix
 mx25u25635f
In-Reply-To: <d59ec4e0-3bce-2b44-1fc5-54a26fe77c7f@nokia.com>
References: <20220513094759.44185-1-alexander.sverdlin@nokia.com>
 <34eccc66cc75dd0ffbf8a77780b6f8a7@walle.cc>
 <d59ec4e0-3bce-2b44-1fc5-54a26fe77c7f@nokia.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <a6515b6d3c790be8a66f30069a05df56@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 2022-05-13 18:09, schrieb Alexander Sverdlin:
>>> According to datasheet both Dual and Quad Read is supported. The read 
>>> test
>>> shows x3.8 speed gain.
>> 
>> Does it have SFDP? Try adding PARSE_SFDP instead of the
>> NO_SFDP_FLAGS.
> 
> Some issues with its SFDP were known:
> https://patchwork.ozlabs.org/project/linux-mtd/patch/1492068234-9509-1-git-send-email-dev@kresin.me/

That doesn't seem to be the case for your flash. The quad and
dual flags you've added, will enable SFDP parsing anyway. So
instead of adding these flags, just adding PARSE_SFDP should
work, too. We still have to keep the SPI_NOR_4B_OPCODES.

>> Please post an SFDP dump of this flash [1].

Thanks.

>> xxd -p /sys/bus/spi/devices/spi0.0/sfdp
> 53464450060102ff00060110300000ffc2000104100100ff84000102c000
> 00ffffffffffffffffffffffffffffffffffe520fbffffffff0f44eb086b
> 083b04bbfeffffffffff00ffffff44eb0c200f5210d800ff8749b50082d2
> 04d24403673830b030b0f7bdd55c4a9e29fff050f985ffffffffffffffff
> ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
> ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
> ffffffffffffffffffffffff7f8fffff215cdcffffffffffffffffffffff
                           ^^^^^^^^^^^^^^^^

That's the 4BAIT table.


> ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
> ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
> ffff002050169df9c06485cbffffffffffff

-michael
