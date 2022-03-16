Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B165AC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Mar 2022 12:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355937AbiCPM5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Mar 2022 08:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240134AbiCPM5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 08:57:45 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC4F62A12;
        Wed, 16 Mar 2022 05:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=LmmB2Erj1jpfGkRLnpwe7cf7WboJOCv0J54etJDojOY=; b=Td4FigwoT7Iu2FICJhxFKA1fQU
        gfzRAkQ2wpTv4eW9I6v1ohLxY3+zdr8TUZW3evkk81VG7F2ATov8ON8y1ZcPBO5d0rjJgAX7OplXU
        ZuHXJ9cyBXv2kzDIOXIWNq7DuuE2IgGb1Y/fm3hmcFNbLFBKhst3ltpf5Nwkoka6+4d4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nUTCR-00BEEh-FP; Wed, 16 Mar 2022 13:56:23 +0100
Date:   Wed, 16 Mar 2022 13:56:23 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     cgel.zte@gmail.com
Cc:     kuba@kernel.org, sebastian.hesselbarth@gmail.com,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH V2] net: mv643xx_eth: undo some opreations in
 mv643xx_eth_probe
Message-ID: <YjHed0u9X0bVd6fL@lunn.ch>
References: <20220316012444.2126070-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316012444.2126070-1-chi.minghao@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 01:24:44AM +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Cannot directly return platform_get_irq return irq, there
> are operations that need to be undone.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
