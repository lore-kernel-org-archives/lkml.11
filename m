Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776EEC4332F
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Mar 2022 04:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239412AbiCJEBR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Mar 2022 23:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238110AbiCJEBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 23:01:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCE8D31F8;
        Wed,  9 Mar 2022 20:00:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1F35617E8;
        Thu, 10 Mar 2022 04:00:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35525C340F3;
        Thu, 10 Mar 2022 04:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646884811;
        bh=nGcXux3HhOMFeI4LfeIm/1h3o6WAHCoM7XbftuaGu0U=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=sFfOeHE0MLsUFnlzDk0MpqfHpxY2PAXlAY2oTh+2qnYoKCHTw0yr+Anp+YwZ73UbA
         2rIS38pelT10P9xRoGk6bn5caEZZJdsEdzdv30q3hT6bf4Xzx2CoRUef5zU1KvyPuq
         sDlPpvFWxHKTaz45hGgtFo2qgLkEb+kb4Aev4kunK5x5jVkQiwg/H5xcDbX2YDhRUb
         gc/rgvkHZgp8+Z5g5RcypGuO+AaEfMAal2MTDkA6Btv4BGqhia/zlTvAmP2P+qQAnI
         jRgGDdlVg/2jVcpVmFHGgWaT8uiGAq5Z2XolRsAS8Y4R9Th9hZ7C9rboQb5smcyAcn
         wtVzJQQ0CKNIw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1DA58F03841;
        Thu, 10 Mar 2022 04:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ptp: idt82p33: use rsmu driver to access i2c/spi bus
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164688481111.32652.2698356518749751397.git-patchwork-notify@kernel.org>
Date:   Thu, 10 Mar 2022 04:00:11 +0000
References: <1646748651-16811-1-git-send-email-min.li.xe@renesas.com>
In-Reply-To: <1646748651-16811-1-git-send-email-min.li.xe@renesas.com>
To:     Min Li <min.li.xe@renesas.com>
Cc:     richardcochran@gmail.com, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  8 Mar 2022 09:10:51 -0500 you wrote:
> rsmu (Renesas Synchronization Management Unit ) driver is located in
> drivers/mfd and responsible for creating multiple devices including
> idt82p33 phc, which will then use the exposed regmap and mutex
> handle to access i2c/spi bus.
> 
> Signed-off-by: Min Li <min.li.xe@renesas.com>
> 
> [...]

Here is the summary with links:
  - [net] ptp: idt82p33: use rsmu driver to access i2c/spi bus
    https://git.kernel.org/netdev/net-next/c/013a3e7c79ac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


