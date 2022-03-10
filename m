Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92672C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Mar 2022 21:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344150AbiCJVyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Mar 2022 16:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234601AbiCJVyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 16:54:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C2FA9942
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 13:53:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3017FB80CB3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F59C340E8;
        Thu, 10 Mar 2022 21:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646949196;
        bh=ELDMz4ZJxMMGxscYfx34KKaOhnj2XGHJKkEOFAkp6JY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T7GxiRBjKwzXfujEBnnTkfhs5eDX3moRl3BTfNw1KfdnaRxeoUs9gB89QwhS3S6/C
         RWWQMTwenRiDdDFUByvSwKZMBIhd4fz2mXgVoRcMPcn8eUzOS5Ary/qTKleAkb71Xh
         l2PYM/LGtF2LhMDiAoR0qbocsd9vNthFyiFNPjEk=
Date:   Thu, 10 Mar 2022 22:52:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Phy <linux-phy@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [GIT PULL] Generic phy updates for v5.18-rc1
Message-ID: <YipzBhbHRbcwlWzt@kroah.com>
References: <YiJM/aHDOqqcvimp@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiJM/aHDOqqcvimp@matsya>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 11:01:41PM +0530, Vinod Koul wrote:
> Hello Greg,
> 
> Please pull to receive the Generic phy updates for v5.18. Bunch of new
> device support and updates to few existing drivers.
> 
> The pull is based on fixes tag you had merged earlier. I had merged
> that into next for resolving dependencies between next & fixes.
> 
> The following changes since commit 9a8406ba1a9a2965c27e0db1d7753471d12ee9ff:
> 
>   phy: dphy: Correct clk_pre parameter (2022-02-02 10:33:04 +0530)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-for-5.18

Pulled and pushed out, thanks.

greg k-h
