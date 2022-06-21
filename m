Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D737C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jun 2022 16:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353660AbiFUQCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jun 2022 12:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353491AbiFUQCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 12:02:34 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E1D25C53;
        Tue, 21 Jun 2022 09:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6f6mchpkGAoQTBVb95PMvTYApL6hiX50UGJlEV/6gZo=; b=mYghn/1swk/lIPK0weN4r6vRdI
        kQsTxWBXBos7RDrvIzyJRb+rxRPcVj5BzaoCnRnxx98SAQlbDI3d2jLe1lse5FrBK+t5qvbXGUsdo
        ICVDaXTZk2O97NpRmtldppVMokDgO6NatHXPvgE3MoKJNbWaF2CEzYsqS3LvQh2lOAgIXNGWzxXbk
        424XVpss3oBBWGvCLSGB7hPft2KcU9uziA8gWUBlNRp54GnXZzAX6MxyxTJN8h+od5OnvIJvusoGb
        81IkwQ4/VgA2A9s9Z0Ap4uIaVx429cn0QGU+JDSG051w/Ci93JAloMNcdNYGUX2OHQ+1U1qLOeJE1
        N865ywOg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:32966)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1o3gJy-0002bT-RO; Tue, 21 Jun 2022 17:01:42 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1o3gJw-0006FV-KO; Tue, 21 Jun 2022 17:01:40 +0100
Date:   Tue, 21 Jun 2022 17:01:40 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Yann Sionneau <ysionneau@kalray.eu>
Cc:     linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        jvetter@kalray.eu, jmaselbas@kalray.eu
Subject: Re: [PATCH] net: phylink: check for pcs_ops being NULL
Message-ID: <YrHrZJLSDEky9b7w@shell.armlinux.org.uk>
References: <20220621134917.24184-1-ysionneau@kalray.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621134917.24184-1-ysionneau@kalray.eu>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 03:49:17PM +0200, Yann Sionneau wrote:
> Out of tree drivers that have not been updated
> after 001f4261fe4d ("net: phylink: use legacy_pre_march2020") would not set the
> legacy_pre_march2020 boolean which if not initialized will default to false.
> Such drivers will most likely still be using the legacy interface and will
> not have pcs_ops.

... which means they're broken. The answer is not to patch phylink like
this, because even with this, it's likely that they are still broken.

They need to set legacy_pre_march2020.

Note that the legacy stuff will be going away - some of it, such as the
mac_pcs_an_restart() method will be going away, maybe in the next merge
window.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
