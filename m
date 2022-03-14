Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E81DC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Mar 2022 16:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbiCNQmM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Mar 2022 12:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236642AbiCNQlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:41:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6917C473B6;
        Mon, 14 Mar 2022 09:40:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73A07608C3;
        Mon, 14 Mar 2022 16:40:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FBEAC340E9;
        Mon, 14 Mar 2022 16:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647276013;
        bh=f6j100uU3wgK7s/aNPsFd7DSTWSNi49pn+hCa98zhX0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PLHaIbYAbJ5DfRs37Z8P2qxAM3W2Ogv0jrM0iYjXWzXID+I9IwAHDZfeAAYvSwJcZ
         SnUz1hHnvAfhGZf//VdZomrWvx1IO/kZ4cawytg2DdAWIQ3QtS5mlFsZsmt0syz4WM
         DFeYw95mMN5nNAjhOjWxbzIaEzdg40AXLaTe6wXdh8dzTAltF97dh4Z3jLoKe0vjj0
         GDKiJ9XR/KZkuYiTAQBieYcnx1zUbx8H5ETBgldKsmW8oqdyy2ADBqkuZ+vNJSOKrj
         MIcmPwPUlvTrsS0Gtx8iNy7saorTqeCpYE+z1dfpln6R/Ll9QjG7+TKPpX6LzXbvJ5
         rMCr5+TXjJm1w==
Date:   Mon, 14 Mar 2022 09:40:12 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     cgel.zte@gmail.com
Cc:     chi.minghao@zte.com.cn, davem@davemloft.net,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        sebastian.hesselbarth@gmail.com, zealci@zte.com.cn
Subject: Re: [PATCH V3] net: mv643xx_eth: use platform_get_irq() instead of
 platform_get_resource()
Message-ID: <20220314094012.3e42cedb@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20220314024144.2112308-1-chi.minghao@zte.com.cn>
References: <20220311082051.783b7c0b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <20220314024144.2112308-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Mar 2022 02:41:44 +0000 cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> It is not recommened to use platform_get_resource(pdev, IORESOURCE_IRQ)
> for requesting IRQ's resources any more, as they can be not ready yet in
> case of DT-booting.
> 
> platform_get_irq() instead is a recommended way for getting IRQ even if
> it was not retrieved earlier.
> 
> It also makes code simpler because we're getting "int" value right away
> and no conversion from resource to int is required.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>

Your previous patch was applied, you must send a incremental fix on top
of this tree:

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/
