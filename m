Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC3CC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 May 2022 12:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376776AbiEEMeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 May 2022 08:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358555AbiEEMeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 08:34:22 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBCE4E3B1;
        Thu,  5 May 2022 05:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=XZ182GK+zd43cwU06UATfEbQEp8bgNAsA6rwfjr7piQ=; b=zsnzffvDHw0n86KhviU7kGzKG5
        cMKAZlIr6PL7pRj0j57lr/+sRdcM2dHuhNaS6TFBtY85ZMbJbxuZb/VR9fS3z1UHhsjUJuRHl6mvg
        yrkcgg1dzOKT2iUxvrhU4cJ2+Xkp/hyluqxehPHMzAqfwuavMY2cqJJFJMkNtEXQPBDQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nmact-001Lu3-J3; Thu, 05 May 2022 14:30:35 +0200
Date:   Thu, 5 May 2022 14:30:35 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/7] net: phy:
 genphy_c45_pma_base1_setup_master_slave: do no set unknown configuration
Message-ID: <YnPDa1gn7adlJ08Q@lunn.ch>
References: <20220505063318.296280-1-o.rempel@pengutronix.de>
 <20220505063318.296280-4-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505063318.296280-4-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 08:33:14AM +0200, Oleksij Rempel wrote:
> Do not change default master/slave forced configuration if no changes was
> requested.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


