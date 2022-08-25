Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10DAECAAA2
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Aug 2022 22:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244290AbiHYWGR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Aug 2022 18:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244272AbiHYWGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 18:06:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D97A5FAF6;
        Thu, 25 Aug 2022 15:06:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3745D61C58;
        Thu, 25 Aug 2022 22:06:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 982DBC433D6;
        Thu, 25 Aug 2022 22:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661465172;
        bh=5wYIu9W6XxQ/os2bwAZJfcc5FIIGnwYbVeLuMf2a0J0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W+/wXewvDQwYnV4uFqWTwIEG8lZ4yAYzo1Gt2uEaMywf/xzMhCvCRcebGczDSUtAf
         J99i713y4uQHYhbZ+Ipaj/6rmfqP8lVywY9ZaCtOdkcaR1CHlUSPy0ERkI51QpMhs9
         6STA+FFEwUi9z5c3EksUxGsyykawHzpRc0H1gq8y7kAB0MAydci7KoRnGtwzZEX6si
         2tibA1sdsTBOncnomayHKTJicTgymgxd8SIClBHJd9DzSD7H9xi/EL6+yrP8FlJb6R
         XMExWOT0vQ5DCOrVpcxk1gPtlfTpQZKcKcbw2N7xojzKyHrTdG+c/ktFbBtG9yMXQ/
         f97lD/CLIAsPg==
Date:   Fri, 26 Aug 2022 00:06:05 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Marcus Carlberg <marcus.carlberg@axis.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, <kernel@axis.com>,
        Pavana Sharma <pavana.sharma@digi.com>,
        Ashkan Boldaji <ashkan.boldaji@digi.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] net: dsa: mv88e6xxx: support RGMII cmode
Message-ID: <20220826000605.5cff0db8@thinkpad>
In-Reply-To: <20220825123807.3a7e37b7@kernel.org>
References: <20220822144136.16627-1-marcus.carlberg@axis.com>
        <20220825123807.3a7e37b7@kernel.org>
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Aug 2022 12:38:07 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Mon, 22 Aug 2022 16:41:36 +0200 Marcus Carlberg wrote:
> > Since the probe defaults all interfaces to the highest speed possible
> > (10GBASE-X in mv88e6393x) before the phy mode configuration from the
> > devicetree is considered it is currently impossible to use port 0 in
> > RGMII mode.
> > 
> > This change will allow RGMII modes to be configurable for port 0
> > enabling port 0 to be configured as RGMII as well as serial depending
> > on configuration.
> > 
> > Fixes: de776d0d316f ("net: dsa: mv88e6xxx: add support for mv88e6393x family")
> > Signed-off-by: Marcus Carlberg <marcus.carlberg@axis.com>  
> 
> Seems like a new configuration which was not previously supported
> rather than a regression, right? If so I'll drop the Fixes tag
> when applying.

Please leave the fixes tag. This configuration should have been
supported from the beginning.

Marek
