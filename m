Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CDFC43334
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jun 2022 13:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345610AbiFUNuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jun 2022 09:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbiFUNuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 09:50:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990EE64E6;
        Tue, 21 Jun 2022 06:50:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5BA15B8180A;
        Tue, 21 Jun 2022 13:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B947C3411D;
        Tue, 21 Jun 2022 13:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655819415;
        bh=jLKG7q4iq+X+SftkQYJJNC89aOwHX5V7R84FQemlJ1M=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=CTnelC+GqqCAznaETVXeBMpGfFSqhzKpIVCghsM+3e43exhiZpazpIBo54SqTSF/R
         q4ZDQjYuoEqm0e1mbTDQwYyoy/ZFsU/yF3XE9C7BKv/aLZdoP4X0hisTQk4loSTmWx
         jyQjlCOc4pg1/iWmu6u5CCzhfarZ67U4hZdbBaja+e9RDoRiu1o89tywM36mWDptHx
         JlGflF+RUjMvD7b9IZdBbXVn2hhIrDxTFcZDTuZZFmZaxienjFZh9SL3x2VCobtDiQ
         SO75Y7ieOCQZ1DXYCopaIqlo0g2K+eKGYNL7br27MJtPCc34N7wpbJNDx4xFahBdgJ
         ou3ADt6RrkAdw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DEEC5E574DA;
        Tue, 21 Jun 2022 13:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Patch net-next 00/11] net: dsa: microchip: common spi probe for the
 ksz series switches - part 1
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165581941490.20739.3823115591202055805.git-patchwork-notify@kernel.org>
Date:   Tue, 21 Jun 2022 13:50:14 +0000
References: <20220617084255.19376-1-arun.ramadoss@microchip.com>
In-Reply-To: <20220617084255.19376-1-arun.ramadoss@microchip.com>
To:     Arun Ramadoss <arun.ramadoss@microchip.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
        andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com,
        olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (master)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 17 Jun 2022 14:12:44 +0530 you wrote:
> This patch series aims to refactor the ksz_switch_register routine to have the
> common flow for the ksz series switch. At present ksz8795.c & ksz9477.c have
> its own dsa_switch_ops and switch detect functionality.
> In ksz_switch_register, ksz_dev_ops is assigned based on the function parameter
> passed by the individual ksz8/ksz9477 switch register function. And then switch
> detect is performed based on the ksz_dev_ops.detect hook.  This patch modifies
> the ksz_switch_register such a way that switch detect is performed first, based
> on the chip ksz_dev_ops is assigned to ksz_device structure. It ensures the
> common flow for the existing as well as LAN937x switches.
> In the next series of patch, it will move ksz_dsa_ops and dsa_switch_ops
> from ksz8795.c and ksz9477.c to ksz_common.c and have the common spi
> probe all the ksz based switches.
> 
> [...]

Here is the summary with links:
  - [net-next,01/11] net: dsa: microchip: ksz9477: cleanup the ksz9477_switch_detect
    https://git.kernel.org/netdev/net-next/c/27faa0aa85f6
  - [net-next,02/11] net: dsa: microchip: move switch chip_id detection to ksz_common
    https://git.kernel.org/netdev/net-next/c/91a98917a883
  - [net-next,03/11] net: dsa: microchip: move tag_protocol to ksz_common
    https://git.kernel.org/netdev/net-next/c/534a0431e9e6
  - [net-next,04/11] net: dsa: microchip: ksz9477: use ksz_read_phy16 & ksz_write_phy16
    https://git.kernel.org/netdev/net-next/c/930e579083d7
  - [net-next,05/11] net: dsa: microchip: move vlan functionality to ksz_common
    https://git.kernel.org/netdev/net-next/c/f0d997e31bb3
  - [net-next,06/11] net: dsa: microchip: move the port mirror to ksz_common
    https://git.kernel.org/netdev/net-next/c/00a298bbc238
  - [net-next,07/11] net: dsa: microchip: get P_STP_CTRL in ksz_port_stp_state by ksz_dev_ops
    https://git.kernel.org/netdev/net-next/c/e593df51ffe8
  - [net-next,08/11] net: dsa: microchip: update the ksz_phylink_get_caps
    https://git.kernel.org/netdev/net-next/c/7012033ce10e
  - [net-next,09/11] net: dsa: microchip: update the ksz_port_mdb_add/del
    https://git.kernel.org/netdev/net-next/c/980c7d171d3a
  - [net-next,10/11] net: dsa: microchip: update fdb add/del/dump in ksz_common
    https://git.kernel.org/netdev/net-next/c/e587be759e6e
  - [net-next,11/11] net: dsa: microchip: move get_phy_flags & mtu to ksz_common
    https://git.kernel.org/netdev/net-next/c/1fe94f542e66

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


