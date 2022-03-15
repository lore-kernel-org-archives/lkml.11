Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2724DC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Mar 2022 05:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344888AbiCOFgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Mar 2022 01:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241159AbiCOFga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 01:36:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DD42A715;
        Mon, 14 Mar 2022 22:35:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07D06611F2;
        Tue, 15 Mar 2022 05:35:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA16C340E8;
        Tue, 15 Mar 2022 05:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647322518;
        bh=LdbNkZ4BJOe4jwda1t7OnYnnbOsaj1r77GEwuErKVaA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=R7sTkl9J4bV9GmqjQBOFs35WEfwOqCTEK3KmOggGrEfgJBzHs4KGY3b+C2ijpt0Ek
         HQmGA4t4+9la8fctcMUtkYwVVzpbBpZSIC6odfR9QOGiChO9i+4vhvuMaHW1GwgkMl
         m+rbqvZMfeEFa5U9dIpNc6Sy/w+MDJcRmvmQXmHFNOfg8iz1PduDmSTp8lDHp6k3HL
         e7o1YMrd7kQHQ8jJALpfc8nud6goL9jYuDPIVeIG7rNSdp+nbzlnqJ7JRzxqkcmh95
         rGv5ZMbX7ps29JKv8i6BxWyoDoIaskEuDv2CbAYSkkuGrs8kr0QDPVOPI0ZMRqjwEE
         PpYDKZCaKWWNg==
Date:   Mon, 14 Mar 2022 22:35:16 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     davem@davemloft.net, robh+dt@kernel.org,
        thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/2] net: mvneta: Armada 98DX2530 SoC
Message-ID: <20220314223516.000780cd@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20220315011742.2465356-1-chris.packham@alliedtelesis.co.nz>
References: <20220315011742.2465356-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Mar 2022 14:17:40 +1300 Chris Packham wrote:
> This is split off from [1] to let it go in via net-next rather than waiting for
> the rest of the series to land.
> 
> [1] - https://lore.kernel.org/lkml/20220314213143.2404162-1-chris.packham@alliedtelesis.co.nz/

Patchwork says it doesn't apply cleanly to net-next [1].
Could you double check?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/
