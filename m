Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB76CC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Mar 2022 19:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350759AbiC3TcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Mar 2022 15:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350741AbiC3TcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 15:32:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839611929A;
        Wed, 30 Mar 2022 12:30:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D266B614F0;
        Wed, 30 Mar 2022 19:30:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8743BC340F3;
        Wed, 30 Mar 2022 19:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648668612;
        bh=8onKiBYlVNpLQTNxcJtyuKnNPZLikBvRjBdmcyWb0x8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=I4089kO3GFzMWh/yZDm+5ewjhUvy5jrBUQmM/kCEBG+EAazB+UkvrJpqniJli4dN/
         vPpZ3kugXVxMhFNjGjGDxzxLZ50pgCBMk5YcSWA0sEtkEIYIrtrc+wDv8rfd7U7oWr
         wHaGAoWHfXwpHhOD+wcXhMHpPwXHS6kGC/phFZ3Dcv21yJVVXibTJlUNpD1fbWW3Eb
         RjxKj6/M7l5ryLn+s9vsnQOmPILI7UCxNxufCJDJt+IoaTxtGzljpDxLq2Rz2jwROX
         ag6N3Ty+gVpzr4e0Jy/r+jjpA78CQ43Ok/lqc/Ieu75mDzOAUJbZjWfJGZHOmeg0cZ
         LpzKRPqva1xtw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6C380E6BBCA;
        Wed, 30 Mar 2022 19:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: dsa: felix: fix possible NULL pointer dereference
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164866861243.12292.10767729029354514539.git-patchwork-notify@kernel.org>
Date:   Wed, 30 Mar 2022 19:30:12 +0000
References: <20220329090800.130106-1-zhengyongjun3@huawei.com>
In-Reply-To: <20220329090800.130106-1-zhengyongjun3@huawei.com>
To:     zhengyongjun <zhengyongjun3@huawei.com>
Cc:     andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com,
        davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, vladimir.oltean@nxp.com,
        claudiu.manoil@nxp.com, alexandre.belloni@bootlin.com,
        UNGLinuxDriver@microchip.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 29 Mar 2022 09:08:00 +0000 you wrote:
> As the possible failure of the allocation, kzalloc() may return NULL
> pointer.
> Therefore, it should be better to check the 'sgi' in order to prevent
> the dereference of NULL pointer.
> 
> Fixes: 23ae3a7877718 ("net: dsa: felix: add stream gate settings for psfp").
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> 
> [...]

Here is the summary with links:
  - [v2] net: dsa: felix: fix possible NULL pointer dereference
    https://git.kernel.org/netdev/net/c/866b7a278cdb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


