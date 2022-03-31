Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3511C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Mar 2022 18:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236897AbiCaSsi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Mar 2022 14:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234355AbiCaSsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 14:48:36 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1375F1F0820
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 11:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NpNBulrUtcpc8Onu2yDjkaMRwHGXonadscW2Ecw/kHc=; b=o9I1j1q6wV0tq1VphucAwJ7f3H
        RjyLvQ7Iil+Z0Smm8e3tEw2VhZGREwT4t+Ri548E9PCVoWKoiihwF2u2pE/1zeXKu3flG+cVb+Ysu
        Z12nDFMVDEfpdY6GzcuA1588gucUPgdsQcuRObfzJ4rbHTnDmxejFV5Z50WRnLUZsFhj6Yo0t3umr
        a5FisIdIFZza3JdHa7rEX/wkPAx9aEK3XgGQCM1FwMPXR21yXCilcIY79ZT6dpjBP7uzw4oeV0ICK
        MQDby5SYwqgTG8sKPhYrBD3tIkepNNrkXAkk+jVu/YmLJsU4jpWJU5TeH6YTmLIExCLBiY6K9+Ud8
        Oo65M+rg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58074)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1nZzoa-0005DO-55; Thu, 31 Mar 2022 19:46:35 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1nZzoS-0007s9-7E; Thu, 31 Mar 2022 19:46:28 +0100
Date:   Thu, 31 Mar 2022 19:46:28 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        David Hildenbrand <david@redhat.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        linux-arm-kernel@lists.infradead.org,
        Logan Gunthorpe <logang@deltatee.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Minchan Kim <minchan@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Zi Yan <ziy@nvidia.com>
Subject: Re: [GIT PULL] hardening fixes for v5.18-rc1
Message-ID: <YkX3BKpxwCaey8QU@shell.armlinux.org.uk>
References: <202203311127.503A3110@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202203311127.503A3110@keescook>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 11:35:40AM -0700, Kees Cook wrote:
> Hi Linus,
> 
> Please pull these hardening fixes for v5.18-rc1. This addresses an
> -Warray-bounds warning found under a few ARM defconfigs, and disables
> long-broken CONFIG_HARDENED_USERCOPY_PAGESPAN.

I don't see these patches on linux-arm-kernel... are we doing away with
patch review now? :D

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
