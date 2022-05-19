Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31848C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 19 May 2022 15:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238377AbiESPDQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 May 2022 11:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240484AbiESPC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 11:02:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2D8EBEB2
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 08:01:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60E50B82559
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 15:01:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C58FEC385AA;
        Thu, 19 May 2022 15:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652972504;
        bh=2peLXIHGWglCmyR/bvzZxIAVGwKGih10obviZg1W3hM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BUf0dvh8lhk2JTFzx9yx6uy38NdQrALC+6Vqh/QplD20CpkZV+WR1FAsj7LDzE8RB
         Z883selXnhhvgYU0sIjUmGDN3pqkBqnLBLDn2k6s1cJjJyxNcEPQoVOrl3ieXExHZ+
         gni+NxAu+zVtfYQ+m4o2ZA6V+T/q0uYf3uRSUnIw=
Date:   Thu, 19 May 2022 16:56:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Linux Phy <linux-phy@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL]: Generic phy updates for v5.19
Message-ID: <YoZaurFLJJe8mYNv@kroah.com>
References: <Ynz77p8KWnLzSzK3@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ynz77p8KWnLzSzK3@matsya>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 05:52:06PM +0530, Vinod Koul wrote:
> Hello Greg,
> 
> Please pull to receive the Generic phy updates for v5.19. This time no
> new driver, few driver with new chip support and driver updates. As
> usual the changes are already in linux-next.
> 
> The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:
> 
>   Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-for-5.19

Pulled and pushed out, thanks.

greg k-h
