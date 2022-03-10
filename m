Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FEDC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Mar 2022 20:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245268AbiCJUoI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Mar 2022 15:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbiCJUoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 15:44:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A4913C248;
        Thu, 10 Mar 2022 12:43:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32128617C6;
        Thu, 10 Mar 2022 20:43:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34361C340E8;
        Thu, 10 Mar 2022 20:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646944983;
        bh=2X6X1LYtrX77vVoEtJ20iw6HueElnm3T45J6J+kFSug=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gIX0JKfXhZ9l8mvyXVN0RrwZk2rkkayVp1XwNj28i6eOvc8IA4LQs31F46jwT1oDn
         f0vyyn9wVXjlaNG2dI9lZI1x1K9uI1jbqSZBeN5RH3D7ix8eB2Di6AfB2mvt1V7+Uw
         c+uEF6WXqkDukHJhbNrM/lTN279wB4+2qUjLHJnYsmR/JkwTl3J0Vo4aTAIIn25BCT
         Y2Mfc1Ccps246X2hJEphlrI34oVM2uJYCp8yMkOuXWMu+xiQMrN3RtrzehOnpLZ8QV
         vU/11rq9xxmaY9QVWmxHdHE2CrPCyPzTucCQ92kgJ53C4Doomwy/Z/9ttVJCN9rmV2
         wG842JEznPtjQ==
Date:   Thu, 10 Mar 2022 12:43:02 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, paskripkin@gmail.com
Subject: Re: [PATCH net-next v1 4/4] net: usb: asix: suspend internal PHY if
 external is used
Message-ID: <20220310124302.0ee9c7bd@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20220310114434.3465481-4-o.rempel@pengutronix.de>
References: <20220310114434.3465481-1-o.rempel@pengutronix.de>
        <20220310114434.3465481-4-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Mar 2022 12:44:34 +0100 Oleksij Rempel wrote:
> +	/* In case main PHY is not the embedded PHY, we need to take care of
> +	 * embedded PHY as well. */

Another nit would be to move the */ to the next line like checkpatch
wants us to.
