Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118F2C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Feb 2022 12:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240463AbiBWMaq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Feb 2022 07:30:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233949AbiBWMal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 07:30:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4396498F4D;
        Wed, 23 Feb 2022 04:30:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EF468B81EFF;
        Wed, 23 Feb 2022 12:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89133C340F0;
        Wed, 23 Feb 2022 12:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645619411;
        bh=j6CSj4b1i1i+lc+QnW4RLhYbTDN4Ia6gc9LCGe9XfR0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=VBaGnmdyh/CNqp1y0kpU/cTGi3aI0PKfF7sfKotgdkPtDKr9XoWRz0lzMKmHG+lOX
         WZ6J9Vq9kjnPIJig0oeNiixEqdwVSqru4xK6UgaDRCnNsyVhk2qatEKMTcFxHLcppl
         nO5luH7kTt8JAODNQM8AKrfBDU3zU/Tnmbo8afwnd7WBto69VIwnKd5JsM0Oh0Ew+r
         zQa/5X4UY8xykyXB/YzwWYjGB9FQkFDAI7jkzVJgoHdPqulbm3/FyGnNajuBblrjf1
         kI7EpA6meRzC+odYUnwzV+AAFsiTzia6c8So5tT8Agye/D21/OUqeIAh99JJtTMtid
         3UH6IYJ/piVsw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6BE9BE6D4BA;
        Wed, 23 Feb 2022 12:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/2] net: dsa: realtek: fix PHY register read
 corruption
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164561941143.20664.9166640246094519424.git-patchwork-notify@kernel.org>
Date:   Wed, 23 Feb 2022 12:30:11 +0000
References: <20220221184631.252308-1-alvin@pqrs.dk>
In-Reply-To: <20220221184631.252308-1-alvin@pqrs.dk>
To:     =?utf-8?b?QWx2aW4gxaBpcHJhZ2EgPGFsdmluQHBxcnMuZGs+?=@ci.codeaurora.org
Cc:     linus.walleij@linaro.org, andrew@lunn.ch, vivien.didelot@gmail.com,
        f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
        kuba@kernel.org, mir@bang-olufsen.dk, alsi@bang-olufsen.dk,
        luizluca@gmail.com, arinc.unal@arinc9.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (master)
by David S. Miller <davem@davemloft.net>:

On Mon, 21 Feb 2022 19:46:29 +0100 you wrote:
> From: Alvin Šipraga <alsi@bang-olufsen.dk>
> 
> These two patches fix the issue reported by Arınç where PHY register
> reads sometimes return garbage data.
> 
> v1 -> v2:
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/2] net: dsa: realtek: allow subdrivers to externally lock regmap
    https://git.kernel.org/netdev/net-next/c/907e772f6f6d
  - [v2,net-next,2/2] net: dsa: realtek: rtl8365mb: serialize indirect PHY register access
    https://git.kernel.org/netdev/net-next/c/2796728460b8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


