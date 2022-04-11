Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C1F0C433FE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Apr 2022 10:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344981AbiDKKEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Apr 2022 06:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242929AbiDKKC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:02:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC3C1102;
        Mon, 11 Apr 2022 03:00:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9A6C612F4;
        Mon, 11 Apr 2022 10:00:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31BDFC385B3;
        Mon, 11 Apr 2022 10:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649671213;
        bh=UdoDcJzA6vWmn59uGLAhdPbeh3b5WbAbMB0lwW/B5cw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=QIdRy8uTHPdDv3UaCqkWLPiLmpqT4C7mENI6ZyPtPycrHq4jUBpQCtt1XgAk0cTs3
         cIFjp/xrveG05EVcAZwnutoejs3zGdlDSgQq5iQOyyRSQVh5EnrvXTkH0qLF7/IPHY
         2Z34mkyAyyT1Lc+zoUHWbpG7XNndbgjwzt/544zBrXDDZHYr0jKtdWfgHwxHNB968Z
         5Ffk0jl6TjAUL/Ibhe8vPCeKYnDSbRjbzeZEsaea27F0ooKfLCaaS3Vip1fm4cRR/E
         z9BHFcTGVl9X8llQRmliU/8efV0BmAWueK3R4vWIZ+L2Hme41NnkWdjS43NHF+58DD
         BSE0scGDoQnPw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1B711E7399B;
        Mon, 11 Apr 2022 10:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bnx2x: Fix spelling mistake "regiser" -> "register"
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164967121310.20630.17434852636742248136.git-patchwork-notify@kernel.org>
Date:   Mon, 11 Apr 2022 10:00:13 +0000
References: <20220408094901.2494831-1-lv.ruyi@zte.com.cn>
In-Reply-To: <20220408094901.2494831-1-lv.ruyi@zte.com.cn>
To:     CGEL <cgel.zte@gmail.com>
Cc:     aelior@marvell.com, skalluru@marvell.com, manishc@marvell.com,
        davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        lv.ruyi@zte.com.cn, zealci@zte.com.cn
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (master)
by David S. Miller <davem@davemloft.net>:

On Fri,  8 Apr 2022 09:49:01 +0000 you wrote:
> From: Lv Ruyi <lv.ruyi@zte.com.cn>
> 
> There are some spelling mistakes in the comments for macro. Fix it.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
> 
> [...]

Here is the summary with links:
  - bnx2x: Fix spelling mistake "regiser" -> "register"
    https://git.kernel.org/netdev/net-next/c/a21437d2b485

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


