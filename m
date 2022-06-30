Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2083C43334
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jun 2022 03:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbiF3DkU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jun 2022 23:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbiF3DkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 23:40:19 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886BB1E3D0;
        Wed, 29 Jun 2022 20:40:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E0485CE1290;
        Thu, 30 Jun 2022 03:40:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51991C341CA;
        Thu, 30 Jun 2022 03:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656560414;
        bh=GRbxPmIzfYUd0olcDNpMbJNFXHPvb4nZdiy0NGphrGM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=bhA+3/gNul4m4v+BbNir3u6UqcgU80tomzUMKByDoBDcY3OUJi8LalB3W/h9LIQRl
         A6ThfNeqqYmz+eLEoctgnsLxBFYkt1YnirArlKxKzviYEqRfLDRXFU1WeLOSPt6nJF
         unsGZvyEAchoILtCEmUuYyfMudSXJDihYAyoDRlNhZ1zESRWPN7pR/TTd5dFDpo4i7
         JeCyYkclxKBKER8Pi81i7MY1bzMU9h3NiV40xXufZ/Ra6FVwSkK5tPfeqFLioYmgeK
         r/JxNvUAFUGfaJTvujhQDlMbNErV3K5TUd+WhQ024ascFDKu2C8tREgWWCsyLRREif
         8w15H8okvwZCw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3D31EE49BBA;
        Thu, 30 Jun 2022 03:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/4] net: dsa: add pause stats support
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165656041424.25608.15286972215720415620.git-patchwork-notify@kernel.org>
Date:   Thu, 30 Jun 2022 03:40:14 +0000
References: <20220628085155.2591201-1-o.rempel@pengutronix.de>
In-Reply-To: <20220628085155.2591201-1-o.rempel@pengutronix.de>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     woojung.huh@microchip.com, andrew@lunn.ch,
        vivien.didelot@gmail.com, f.fainelli@gmail.com, olteanv@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        lukas@wunner.de, UNGLinuxDriver@microchip.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 Jun 2022 10:51:51 +0200 you wrote:
> changes v2:
> - add Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
> - remove packet calculation fix from ar9331 patch. It needs more fixes.
> - add packet calculation fix for microchip
> 
> Oleksij Rempel (4):
>   net: dsa: add get_pause_stats support
>   net: dsa: ar9331: add support for pause stats
>   net: dsa: microchip: add pause stats support
>   net: dsa: microchip: count pause packets together will all other
>     packets
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/4] net: dsa: add get_pause_stats support
    https://git.kernel.org/netdev/net-next/c/3d410403a572
  - [net-next,v2,2/4] net: dsa: ar9331: add support for pause stats
    https://git.kernel.org/netdev/net-next/c/ea294f39b438
  - [net-next,v2,3/4] net: dsa: microchip: add pause stats support
    https://git.kernel.org/netdev/net-next/c/c4748ff6566b
  - [net-next,v2,4/4] net: dsa: microchip: count pause packets together will all other packets
    https://git.kernel.org/netdev/net-next/c/961d6c70d886

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


