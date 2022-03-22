Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A90CC433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Mar 2022 12:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234826AbiCVMVt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Mar 2022 08:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234817AbiCVMVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 08:21:42 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFDD6CA6F;
        Tue, 22 Mar 2022 05:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=77siS/SH/HdarcIrWyVVppwMCwxzQ+Pw6iY9q6o5pqs=; b=2whWCEXXLZh0kwKMBXmKqCehAT
        uKxh09s1QPkjlTvRY+GC4mbQb2t+3xLmIR5nt2rixip3vimafyiS+XV/7wz6atwSsLGVxvQbFLTe2
        AWpuyQ3O/hAHV652EcB3HmGxxwK56l7Kifrs4L+hrREog/ZUhsSjVhDjtoMDsAr4PAbI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nWdUi-00C7UV-OO; Tue, 22 Mar 2022 13:20:12 +0100
Date:   Tue, 22 Mar 2022 13:20:12 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pali@kernel.org, marek.behun@nic.cz
Subject: Re: [PATCH v2 1/2] arm64: dts: uDPU: update partition table
Message-ID: <Yjm+/I9ItqFMuEsK@lunn.ch>
References: <20220322105857.1107016-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322105857.1107016-1-robert.marko@sartura.hr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 11:58:56AM +0100, Robert Marko wrote:
> Partition currently called "uboot" does not only contain U-boot, but
> rather it contains TF-A, U-boot and U-boot environment.
> 
> So, to avoid accidentally deleting the U-boot environment which is
> located at 0x180000 split the partition.
> 
> "uboot" is not the correct name as you can't boot these boards with U-boot
> only, TF-A must be present as well, so rename the "uboot" partition to
> "firmware".
> 
> While we are here, describe the NOR node as "spi-flash@0" instead of
> "m25p80@0" which is the old SPI-NOR driver name.
> 
> This won't break booting for existing devices as the SoC-s BootROM is not
> partition aware at all, it will simply try booting from 0x0 of the
> boot device that is set by bootstrap pins.
> 
> This will however prevent accidental or automated flashing of just U-boot
> to the partition.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
