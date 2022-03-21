Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22942C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Mar 2022 22:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbiCUWx0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Mar 2022 18:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbiCUWxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 18:53:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6808F3C8AFF;
        Mon, 21 Mar 2022 15:32:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4CD2CB819FE;
        Mon, 21 Mar 2022 21:26:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35EB8C340E8;
        Mon, 21 Mar 2022 21:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647898008;
        bh=MdFVdpU9BRlhC7Gxb+jB5c2HWKX2X/KfKn/uOM/qpiE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SLjoLzMsOepdgVQIUkD155E5Lv55uy4SxBqRQjREUvxi64ef+SR6i/X6QLx0XX3hq
         u/Abo0XBjstS3FnpI+jMs1dIVs1Jb3qIIvYYbOL24vW8qsK7iKtuEjDvHbBAo+JY28
         4hKPJWksHKgboXCrZJz+lJjb06PDnEA9LpEJTJ5XWrWBv6kL4+jv4N8aM6fqGVb+Pb
         H4xNx9ptFyCNwuKTg7hyJi/A6VbawiG5/Rqi5fkc69HnVTfO9rDC3VPNo9fDaXQ+K1
         UKki2tLUjqoju+7pLD84rTGAAQTZHnOsssm7A8IGfgNQLg4Wir3Fp52qsjpKr0V22v
         GaBbEUjG9NWug==
Date:   Mon, 21 Mar 2022 14:26:45 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Jeremy Linton <jeremy.linton@arm.com>, netdev@vger.kernel.org,
        opendmb@gmail.com, davem@davemloft.net,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH] net: bcmgenet: Use stronger register read/writes to
 assure ordering
Message-ID: <20220321142645.38b8a087@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <0465ecd0-0cd7-1376-51bf-38aa385c128a@gmail.com>
References: <20220310045358.224350-1-jeremy.linton@arm.com>
        <0465ecd0-0cd7-1376-51bf-38aa385c128a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Mar 2022 12:04:34 -0700 Florian Fainelli wrote:
> On 3/9/22 8:53 PM, Jeremy Linton wrote:
> > GCC12 appears to be much smarter about its dependency tracking and is
> > aware that the relaxed variants are just normal loads and stores and
> > this is causing problems like:

> > Fixes: 69d2ea9c79898 ("net: bcmgenet: Use correct I/O accessors")
> > Reported-by: Peter Robinson <pbrobinson@gmail.com>
> > Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>  
> 
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Commit 8d3ea3d402db ("net: bcmgenet: Use stronger register read/writes
to assure ordering") in net now, thanks!
