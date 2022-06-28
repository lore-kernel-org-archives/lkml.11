Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC32C43334
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jun 2022 05:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244631AbiF1FK2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jun 2022 01:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244424AbiF1FKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 01:10:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0D8A1A9;
        Mon, 27 Jun 2022 22:10:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1049161784;
        Tue, 28 Jun 2022 05:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58862C341CB;
        Tue, 28 Jun 2022 05:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656393013;
        bh=ghHR3PFVwksAPwIE4sLnVqojSR/2FWodfH1woDUCwWw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=GWeBW4+WMpsRIYKoyPj1zkfT99YqseJpo+FxYvMJAYoByXTLf0k1BfJy10MSe5TQp
         xxDGi0tsLlDM8P90kVbVyGlnNd8NwY5UY7HyXGZ+67jB7znAq7c0uMf/z1t9vPewfW
         3ijeE/oWBCJ1XQhv4djb0lZJKqy/8eaPdWph2hgb68m+2PsXMttb9gIOiOIHpqYK/G
         k9c8BFUEDa8oixpjg+la90NzcdYIPcTXe2p/IWjUFhQY040gaR3d9elcwzDX+Hr4r2
         B7ZA3XGwBbij+cxh1spT0brIMSHJimRb9NGERQK1ihm3SsqnxrD/5D8RsuNVR0IAXP
         mWpafsTgBRdag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 32961E49FA2;
        Tue, 28 Jun 2022 05:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1 1/2] net: asix: fix "can't send until first packet is
 send" issue
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165639301319.30025.6669854790252095765.git-patchwork-notify@kernel.org>
Date:   Tue, 28 Jun 2022 05:10:13 +0000
References: <20220624075139.3139300-1-o.rempel@pengutronix.de>
In-Reply-To: <20220624075139.3139300-1-o.rempel@pengutronix.de>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, glance@acc.umu.se, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        lukas@wunner.de
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 24 Jun 2022 09:51:38 +0200 you wrote:
> If cable is attached after probe sequence, the usbnet framework would
> not automatically start processing RX packets except at least one
> packet was transmitted.
> 
> On systems with any kind of address auto configuration this issue was
> not detected, because some packets are send immediately after link state
> is changed to "running".
> 
> [...]

Here is the summary with links:
  - [net,v1,1/2] net: asix: fix "can't send until first packet is send" issue
    https://git.kernel.org/netdev/net/c/805206e66fab
  - [net,v1,2/2] net: usb: asix: do not force pause frames support
    https://git.kernel.org/netdev/net/c/ce95ab775f8d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


