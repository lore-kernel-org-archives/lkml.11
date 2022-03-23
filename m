Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D83CC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Mar 2022 22:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345174AbiCWWPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Mar 2022 18:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241243AbiCWWPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 18:15:48 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1F689330;
        Wed, 23 Mar 2022 15:14:14 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id E536B221D4;
        Wed, 23 Mar 2022 23:14:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1648073652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W6I5uXL5BQ9Fq8+54NpWJEnlpv+fNccLE9GVeB9+xdg=;
        b=C7DQtxKA1eJ7QFA/2kF0rAbU3Zxg48MUOF73SQiHHf7aNNDgcj9Q8xvDUmNWWGFuAinUs7
        Pd2BOIwB+1nhT2XB+FZ1v31pudztrno8xTNsGSUaOolre6LoTJdPSmrgNniusIe0jqnvxh
        5+GdcH1QlocPNVvxFDV8QJ38NCAvtRQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 23 Mar 2022 23:14:11 +0100
From:   Michael Walle <michael@walle.cc>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Xu Liang <lxu@maxlinear.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 2/5] net: phy: support indirect c45 access in
 get_phy_c45_ids()
In-Reply-To: <Yjt3hHWt0mW6er8/@lunn.ch>
References: <20220323183419.2278676-1-michael@walle.cc>
 <20220323183419.2278676-3-michael@walle.cc> <Yjt3hHWt0mW6er8/@lunn.ch>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <43227d27d938fad8a2441363d175106e@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-03-23 20:39, schrieb Andrew Lunn:
>> +static int mdiobus_probe_mmd_read(struct mii_bus *bus, int prtad, int 
>> devad,
>> +				  u16 regnum)
>> +{
>> +	int ret;
>> +
>> +	/* For backwards compatibility, treat MDIOBUS_NO_CAP as c45 capable 
>> */
>> +	if (bus->probe_capabilities == MDIOBUS_NO_CAP ||
>> +	    bus->probe_capabilities >= MDIOBUS_C45)
> 
> Maybe we should do the work and mark up those that are C45 capable. At
> a quick count, see 16 of them.

You mean look at they are MDIOBUS_C45, MDIOBUS_C22_C45 or MDIOBUS_C22
and drop MDIOBUS_NO_CAP?

> 
>> +		return mdiobus_c45_read(bus, prtad, devad, regnum);
>> +
>> +	mutex_lock(&bus->mdio_lock);
>> +
>> +	/* Write the desired MMD Devad */
>> +	ret = __mdiobus_write(bus, prtad, MII_MMD_CTRL, devad);
>> +	if (ret)
>> +		goto out;
>> +
>> +	/* Write the desired MMD register address */
>> +	ret = __mdiobus_write(bus, prtad, MII_MMD_DATA, regnum);
>> +	if (ret)
>> +		goto out;
>> +
>> +	/* Select the Function : DATA with no post increment */
>> +	ret = __mdiobus_write(bus, prtad, MII_MMD_CTRL,
>> +			      devad | MII_MMD_CTRL_NOINCR);
>> +	if (ret)
>> +		goto out;
> 
> Make mmd_phy_indirect() usable, rather then repeat it.

I actually had that. But mmd_phy_indirect() doesn't check
the return code and neither does the __phy_write_mmd() it
actually deliberatly sets "ret = 0". So I wasn't sure. If you
are fine with a changed code flow in the error case, then sure.
I.e. mmd_phy_indirect() always (try to) do three accesses; with
error checks it might end after the first. If you are fine
with the error checks, should __phy_write_mmd() also check the
last mdiobus_write()?

-michael
