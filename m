Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B0FC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Mar 2022 04:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239461AbiCJEVR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Mar 2022 23:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236319AbiCJEVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 23:21:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C00B11942E;
        Wed,  9 Mar 2022 20:20:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30D076184A;
        Thu, 10 Mar 2022 04:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86FB1C340FB;
        Thu, 10 Mar 2022 04:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646886011;
        bh=yE8W9mRMdO2uhbRzLthfGmH4O4VZYLVLsEzAmz9J0xs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=YT1qdoIIInN5/ngTHS6Rjnr86nh+TWI6l0AeZOFVYGG3iYdllWNraUKdsPocdrHM/
         dFwOCpWbqOxnI2RGC7s//0004qJePASFe0NntQsnfHx+BUBqZzkMsIkOy94i+3J2fi
         8FiaNH/oMkrCNnxOQ9ITg1IXc1OHqnldZ9lMk6iKV5ANGbuZlc45VunsbpPO8c5TxX
         F0iGiU39UUrHdNKvT9/X+mVTPoUDERVDevBHH2hapQRJ4iDid10PoNhOvJgCrwXhfd
         2rv7vpf+NCnlHIUNKeTaIntJQhQwVGzMLglVivMSEPmaef75I4J/4Mea9lzgFL9OYe
         lwIJxknqywxtQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 66E40F03841;
        Thu, 10 Mar 2022 04:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/1] stmmac: intel: Add ADL-N PCI ID
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164688601141.11305.7538223970424164595.git-patchwork-notify@kernel.org>
Date:   Thu, 10 Mar 2022 04:20:11 +0000
References: <20220309033415.3370250-1-michael.wei.hong.sit@intel.com>
In-Reply-To: <20220309033415.3370250-1-michael.wei.hong.sit@intel.com>
To:     Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>
Cc:     davem@davemloft.net, kuba@kernel.org, mcoquelin.stm32@gmail.com,
        peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
        joabreu@synopsys.com, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        vee.khee.wong@linux.intel.com, weifeng.voon@intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  9 Mar 2022 11:34:15 +0800 you wrote:
> Add PCI ID for Ethernet TSN Controller on ADL-N.
> 
> Signed-off-by: Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c | 2 ++
>  1 file changed, 2 insertions(+)

Here is the summary with links:
  - [net-next,1/1] stmmac: intel: Add ADL-N PCI ID
    https://git.kernel.org/netdev/net-next/c/30c5601fbf35

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


