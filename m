Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B026ECAAD2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Aug 2022 07:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiH2Htv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Aug 2022 03:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiH2Htp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 03:49:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FDE4F66C;
        Mon, 29 Aug 2022 00:49:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4553B60ED2;
        Mon, 29 Aug 2022 07:49:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3748C433D6;
        Mon, 29 Aug 2022 07:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661759381;
        bh=aGFduZhHwfv9PnY3vRPitP/7usWw3M+bWFBLuYbVIS0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yt6GPMZRoQxQaQf7mU/klM55vy27vm/KW0cqKOSj5iD/P/uxiaB1ghupJK+xPOHZE
         jycDWKH4POpzprvZDeN7T2Blk08twg/3ueahnOlDziRYemic+wlJlb/b7Ty6IgS/HJ
         yKAcr7PsClex4E5DnXvgHPsNsfCpWcgDjEqnMmng=
Date:   Mon, 29 Aug 2022 09:48:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Maxime Coquelin <maxime.coquelin@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, elic@nvidia.com,
        guanjun@linux.alibaba.com, parav@nvidia.com,
        gautam.dawar@xilinx.com, dan.carpenter@oracle.com,
        xieyongji@bytedance.com, jasowang@redhat.com, mst@redhat.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] vduse: prevent uninitialized memory accesses
Message-ID: <YwxvXFiuRqGxRgZH@kroah.com>
References: <20220829073424.5677-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829073424.5677-1-maxime.coquelin@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 09:34:24AM +0200, Maxime Coquelin wrote:
> If the VDUSE application provides a smaller config space
> than the driver expects, the driver may use uninitialized
> memory from the stack.
> 
> This patch prevents it by initializing the buffer passed by
> the driver to store the config value.
> 
> This fix addresses CVE-2022-2308.
> 
> Cc: xieyongji@bytedance.com
> Cc: stable@vger.kernel.org # v5.15+
> Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
> 
> Acked-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Please no blank line above the Acked-by: line here if possible.

thanks,

greg k-h
