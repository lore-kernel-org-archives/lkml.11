Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5339C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Mar 2022 19:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351110AbiCKT3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Mar 2022 14:29:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237286AbiCKT3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 14:29:42 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDA49A9B1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 11:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Aq3TMBOFCfpJGlYnfuH0Up8vmk4Xb4+iQbh/HTw69s0=; b=kQZ1NKSDAm707BTZIin0qUI1SE
        qVPOKbmgKl332kr/d8GUt/cBGkPmCnvK+kDv6fXn+kIqkbQHeqZjbYItg4j+WD6zOOaHRkTOy4oJg
        c6fzt2E/wLCQtzj0iM+oXdcMbP8vJvX+TIPaorlF8vuqX1Cvpnj8kuT6L+faHBaUUsoduvRjPyM9c
        REDsopn4yT7qib4RxQJhIL04JN401sQLdXYTzqqa8cJwgHE8dEGZsVE2p9hAyE6XXw/P9DzeqMc8m
        j6FSo8u/Wfv2xxsuKkmVBo5wr52xfUsagFHUmMmz30ItYv95YNQLzqDZn2wukzFhhfeeg1NxexE/d
        2Jm+cySQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57808)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1nSkwF-0000ZN-72; Fri, 11 Mar 2022 19:28:34 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1nSkwC-0001td-Pq; Fri, 11 Mar 2022 19:28:32 +0000
Date:   Fri, 11 Mar 2022 19:28:32 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, patches@armlinux.org.uk
Subject: Re: [PATCH] ARM: Spectre-BHB: provide empty stub for non-config
Message-ID: <Yiui4HUz8RxHMdYf@shell.armlinux.org.uk>
References: <20220311191820.25771-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311191820.25771-1-rdunlap@infradead.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 11:18:20AM -0800, Randy Dunlap wrote:
> When CONFIG_GENERIC_CPU_VULNERABILITIES is not set, references
> to spectre_v2_update_state() cause a build error, so provide an
> empty stub for that function when the Kconfig option is not set.
> 
> Fixes this build error:
> 
> arm-linux-gnueabi-ld: arch/arm/mm/proc-v7-bugs.o: in function `cpu_v7_bugs_init':
> proc-v7-bugs.c:(.text+0x52): undefined reference to `spectre_v2_update_state'
> arm-linux-gnueabi-ld: proc-v7-bugs.c:(.text+0x82): undefined reference to `spectre_v2_update_state'
> 
> Fixes: b9baf5c8c5c3 ("ARM: Spectre-BHB workaround")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>

Acked-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

I'd suggest sending this direct to Linus as I've been doing with the
other fixes for Spectre BHB. Trying to fit it now into a pull request
is just going to be very messy.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
