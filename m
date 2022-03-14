Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A4DC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Mar 2022 23:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343771AbiCNXxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Mar 2022 19:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234318AbiCNXxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 19:53:13 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70541D321;
        Mon, 14 Mar 2022 16:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=AH8lET2Tj2kAiiPi9GqUtRtt3g/1zLmNS2wbBb+Uh6s=; b=xfMsWH0w8N/xe1EDTszWU0/5Co
        0LxLRQZSXrGT1+fO0l4b8AQ1dL70L+KOnxPm5oNeQoknqorSIN1UtaTq/7rlxk8z9d+yBjAjP72GP
        GZP5MzI3zbWxUCeSvZD1kYKzGTcEMVX5239FJYHvS7nIuvIFj2W+ZSltr8uHG1qzt6yE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nTuTh-00Apla-BE; Tue, 15 Mar 2022 00:51:53 +0100
Date:   Tue, 15 Mar 2022 00:51:53 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     hkallweit1@gmail.com, davem@davemloft.net, kuba@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCHv2] net: phy: Kconfig: micrel_phy: fix dependency issue
Message-ID: <Yi/VGY+PoiPnBQpJ@lunn.ch>
References: <20220314110254.12498-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314110254.12498-1-anders.roxell@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 12:02:54PM +0100, Anders Roxell wrote:
> When building driver CONFIG_MICREL_PHY the follow error shows up:
> 
> aarch64-linux-gnu-ld: drivers/net/phy/micrel.o: in function `lan8814_ts_info':
> micrel.c:(.text+0x1764): undefined reference to `ptp_clock_index'
> micrel.c:(.text+0x1764): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `ptp_clock_index'
> aarch64-linux-gnu-ld: drivers/net/phy/micrel.o: in function `lan8814_probe':
> micrel.c:(.text+0x4720): undefined reference to `ptp_clock_register'
> micrel.c:(.text+0x4720): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `ptp_clock_register'
> 
> Rework Kconfig for MICREL_PHY to depend on 'PTP_1588_CLOCK_OPTIONAL'.
> Arnd describes in a good way why its needed to add this depends in patch
> e5f31552674e ("ethernet: fix PTP_1588_CLOCK dependencies").
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: ece19502834d ("net: phy: micrel: 1588 support for LAN8814 phy")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
