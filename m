Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35D5ECAA2C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Aug 2022 19:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243616AbiHYTiO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Aug 2022 15:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243425AbiHYTiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 15:38:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00047BD75E;
        Thu, 25 Aug 2022 12:38:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B058AB82958;
        Thu, 25 Aug 2022 19:38:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F391FC433D6;
        Thu, 25 Aug 2022 19:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661456288;
        bh=0EKkmySRoTnW1XH04T4d9KZzOI/S3N/6yiEDx5sDFE0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U98uAfbqkP6lL7+uPgp5TS4M+eNzDyK5mvZzcRYQEulKniPf8OUkVdGKXZZlgJTK6
         /OCxBIpWqqu1Fe6ipRyzkCtGrFthXvgM/jGNSaZWLSsC5ybGdE428zQjqopcyL/NSq
         ZF70OlNhf2MnFH2orpbkhgBoEsqCTvdcq7Pt6bvjfmG3ZGEz4MDcVIcylTevUK1UJb
         aTvFmMY07dRmFmpkWP7XVw2P5CkD1T/xCiWPaciFE6H9Gnmilc1YwCZEuVSZOXvzqQ
         hCjFrDcP1wCO+CnRulkvlE0DJLP+jY1IEDB7Lr+IcuDMxS1RCbPx0kZcpEPLV7+7Gw
         6YMW25qZsuJaQ==
Date:   Thu, 25 Aug 2022 12:38:07 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Marcus Carlberg <marcus.carlberg@axis.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, <kernel@axis.com>,
        Pavana Sharma <pavana.sharma@digi.com>,
        Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>,
        Ashkan Boldaji <ashkan.boldaji@digi.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] net: dsa: mv88e6xxx: support RGMII cmode
Message-ID: <20220825123807.3a7e37b7@kernel.org>
In-Reply-To: <20220822144136.16627-1-marcus.carlberg@axis.com>
References: <20220822144136.16627-1-marcus.carlberg@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Aug 2022 16:41:36 +0200 Marcus Carlberg wrote:
> Since the probe defaults all interfaces to the highest speed possible
> (10GBASE-X in mv88e6393x) before the phy mode configuration from the
> devicetree is considered it is currently impossible to use port 0 in
> RGMII mode.
> 
> This change will allow RGMII modes to be configurable for port 0
> enabling port 0 to be configured as RGMII as well as serial depending
> on configuration.
> 
> Fixes: de776d0d316f ("net: dsa: mv88e6xxx: add support for mv88e6393x family")
> Signed-off-by: Marcus Carlberg <marcus.carlberg@axis.com>

Seems like a new configuration which was not previously supported
rather than a regression, right? If so I'll drop the Fixes tag
when applying.
