Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59DFC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Apr 2022 11:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234993AbiDMLME (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Apr 2022 07:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbiDMLMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 07:12:03 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58FF140EB;
        Wed, 13 Apr 2022 04:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=CBlu8+J5V5g3eicBd9/EALqxYdrUeqXoa0KFWr1/CBo=; b=bvL9CxLnFpwWqAiMycEp4G+Kyj
        HwZdWb+IhLaHtvSoz16da28NrRCjV0Uwq9fYWfo8p9g/Zw0p4GyJ6/B/K7LA8K3Y+AdAY+8tXkAo5
        OLpYrX/fAGFS39RNmnxTdeHfmkKNVrmtEv4jJRQMkuYMlGPPhdr0c6tz+LtoytprYxjCokraCNpTr
        bQXEV3pvgk7mHJJ9PAYtgsFsJh8SshYoB7zG+mwmkABF0W/oBB27kM9siiJkAt9TUuuP8YA1yG1Nx
        W6iXtdAIRMNnCKJP3tsP/+ahzrlguAeFLR0ep8zLslhQ/SPJ2f2OUsuFTUjmCsz4pfLVVUK4wYQ7/
        V4oCzAtg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58238)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1neasP-00032X-I2; Wed, 13 Apr 2022 12:09:33 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1neasL-0003II-Ni; Wed, 13 Apr 2022 12:09:29 +0100
Date:   Wed, 13 Apr 2022 12:09:29 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] kernel-doc: support DECLARE_PHY_INTERFACE_MASK()
Message-ID: <Ylavaf+OlgTVeI6a@shell.armlinux.org.uk>
References: <20211030020813.32654-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211030020813.32654-1-rdunlap@infradead.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2021 at 07:08:13PM -0700, Randy Dunlap wrote:
> Support the DECLARE_PHY_INTERFACE_MASK() macro that is used to declare
> a bitmap by converting the macro to DECLARE_BITMAP(), as has been done
> for the __ETHTOOL_DECLARE_LINK_MODE_MASK() macro.
> 
> This fixes a 'make htmldocs' warning:
> 
> include/linux/phylink.h:82: warning: Function parameter or member 'DECLARE_PHY_INTERFACE_MASK(supported_interfaces' not described in 'phylink_config'
> 
> that was introduced by commit
>   38c310eb46f5 ("net: phylink: add MAC phy_interface_t bitmap")
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Russell King (Oracle) <linux@armlinux.org.uk>

Thanks Randy, sorry I missed this patch.

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

What is the intention for merging this patch? Will Jon merge it?
Your tags said To: Jon but you don't seem to have included him in
the email.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
