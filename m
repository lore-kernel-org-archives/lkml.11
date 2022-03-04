Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9F0C433FE
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Mar 2022 13:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbiCDNWS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Mar 2022 08:22:18 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:41994 "EHLO
        mail.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiCDNWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 08:22:16 -0500
Received: from localhost (cpc147930-brnt3-2-0-cust60.4-2.cable.virginm.net [86.15.196.61])
        by mail.monkeyblade.net (Postfix) with ESMTPSA id D9A4D841902F;
        Fri,  4 Mar 2022 05:21:25 -0800 (PST)
Date:   Fri, 04 Mar 2022 13:21:21 +0000 (GMT)
Message-Id: <20220304.132121.856864783082151547.davem@davemloft.net>
To:     andrew@lunn.ch
Cc:     Divya.Koppera@microchip.com, netdev@vger.kernel.org,
        hkallweit1@gmail.com, linux@armlinux.org.uk, kuba@kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        richardcochran@gmail.com, linux-kernel@vger.kernel.org,
        UNGLinuxDriver@microchip.com, madhuri.sripada@microchip.com,
        manohar.puri@microchip.com
Subject: Re: [PATCH net-next 0/3] Add support for 1588 in LAN8814
From:   David Miller <davem@davemloft.net>
In-Reply-To: <YiIO7lAMCkHhd11L@lunn.ch>
References: <20220304093418.31645-1-Divya.Koppera@microchip.com>
        <164639821168.27302.1826304809342359025.git-patchwork-notify@kernel.org>
        <YiIO7lAMCkHhd11L@lunn.ch>
X-Mailer: Mew version 6.8 on Emacs 27.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail.monkeyblade.net [0.0.0.0]); Fri, 04 Mar 2022 05:21:28 -0800 (PST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Lunn <andrew@lunn.ch>
Date: Fri, 4 Mar 2022 14:06:54 +0100

> On Fri, Mar 04, 2022 at 12:50:11PM +0000, patchwork-bot+netdevbpf@kernel.org wrote:
>> Hello:
>> 
>> This series was applied to netdev/net-next.git (master)
>> by David S. Miller <davem@davemloft.net>:
> 
> Hi David
> 
> Why was this merged?

Sorry, it seemed satraightforward to me, and I try to get the backlog under 40 patches before
I hand over to Jakub for the day.

If you want to review, reply to the thread immediately saying so, don't wait until you haver time for the
full review.

Thank you.
