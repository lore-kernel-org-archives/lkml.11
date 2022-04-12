Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3C1C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 14:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356784AbiDLPAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 11:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiDLPA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 11:00:29 -0400
Received: from relay5.hostedemail.com (relay5.hostedemail.com [64.99.140.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182E153730
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 07:58:11 -0700 (PDT)
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay10.hostedemail.com (Postfix) with ESMTP id 3824D1F4B;
        Tue, 12 Apr 2022 14:58:10 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf05.hostedemail.com (Postfix) with ESMTPA id 72E3B20018;
        Tue, 12 Apr 2022 14:58:08 +0000 (UTC)
Message-ID: <070642693caa4c18282b08714a21026d814cd1a0.camel@perches.com>
Subject: Re: [Patch net-next 3/3] MAINTAINERS: Add maintainers for Microchip
 T1 Phy driver
From:   Joe Perches <joe@perches.com>
To:     Arun Ramadoss <arun.ramadoss@microchip.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Russell King <linux@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, UNGLinuxDriver@microchip.com
Date:   Tue, 12 Apr 2022 07:58:07 -0700
In-Reply-To: <20220412063317.4173-4-arun.ramadoss@microchip.com>
References: <20220412063317.4173-1-arun.ramadoss@microchip.com>
         <20220412063317.4173-4-arun.ramadoss@microchip.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 72E3B20018
X-Stat-Signature: m1xco8uidj5thif6k37k4gprddjjjqq4
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18c+GKq6R78PY4V+EkUEYA/ONBnFdTa+zw=
X-HE-Tag: 1649775488-399066
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-04-12 at 12:03 +0530, Arun Ramadoss wrote:
> Signed-off-by: Arun Ramadoss <arun.ramadoss@microchip.com>
> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fd768d43e048..cede8ccf19b2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12903,6 +12903,12 @@ F:	drivers/net/dsa/microchip/*
>  F:	include/linux/platform_data/microchip-ksz.h
>  F:	net/dsa/tag_ksz.c
>  
> +MICROCHIP LAN87xx/LAN937x T1 PHY DRIVER
> +M:	UNGLinuxDriver@microchip.com

Individual people are maintainers.
Random exploder addresses are not maintainers.

Please use an actual person and maybe add something like

M:	Actual name <actual_email@domain.tld>
R:	UNGLinuxDriver@microchip.com

instead

> +L:	netdev@vger.kernel.org
> +S:	Maintained
> +F:	drivers/net/phy/microchip_t1.c
> +
>  MICROCHIP LAN743X ETHERNET DRIVER
>  M:	Bryan Whitehead <bryan.whitehead@microchip.com>
>  M:	UNGLinuxDriver@microchip.com


