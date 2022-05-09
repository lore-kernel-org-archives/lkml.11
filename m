Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56EBC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 May 2022 13:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236655AbiEIN5Y (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 May 2022 09:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236485AbiEIN5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 09:57:20 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6C12D1C0;
        Mon,  9 May 2022 06:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=Kxxyg1HZnQSs/qeLzfqToEvB7I7JnrqLFn5Ofm/34bY=; b=mkpF3BTb9sYAwjiKkfmAKvRtRR
        ta5V+lcRSuTlh4plsa5nFCL0LXnihub+nNgTIzgxSU1xT7urt4+VNvXnAP/AnSCOLVBobQsOmhgBW
        pz/K0YRJlb4ZwMUDrFsRojpY4T2ELh3V6rI11kweNRCSvQz3J/QOhMgVeSNyqbbfrLtI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1no3p5-001x4a-GG; Mon, 09 May 2022 15:53:15 +0200
Date:   Mon, 9 May 2022 15:53:15 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: micrel: Fix incorret variable type in micrel
Message-ID: <Ynkcy0VhJ/HTfqMU@lunn.ch>
References: <20220509134951.2327924-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509134951.2327924-1-wanjiabing@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 09:49:51PM +0800, Wan Jiabing wrote:
> In lanphy_read_page_reg, calling __phy_read() might return a negative
> error code. Use 'int' to check the negative error code.

Hi Wan

As far as the code goes, this looks good.

Please could you add a Fixes: tag, to indicate where the problem was
introduced. Please also read the netdev FAQ, so you can correctly set
the patch subject. This should be against the net tree, since it is a
fix.

Thanks
	Andrew
