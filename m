Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FB1C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Feb 2022 11:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352080AbiBNLs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Feb 2022 06:48:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351704AbiBNLjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:39:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B385B13DE1;
        Mon, 14 Feb 2022 03:30:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52A24611BC;
        Mon, 14 Feb 2022 11:30:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B177CC340F0;
        Mon, 14 Feb 2022 11:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644838210;
        bh=WMoynI5WXAeTD6YHq4DWDKMnxC4EGldppjWd4ecx7PU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=m7kLgs0iJvCnzVa6qCiteJMYfcvEaY8H8sgnpbNDoKfLat9mAWyWPBR/0ZhmiRd+j
         zV+iVQLWpeUbFwKzVr16FA7gWNP5j0pDJN5spBvZR1Wyk4/YtoeXCVx4vR1pzdNnlz
         cs2iCyr4FbLzHCdeq449eUBgQhXhgMRTNU/NZExaIuLngNuwdRrHCAP8UksFwXh9hV
         rksGeoQzJJQfnPLzjuku2oRNjSuGZPZIrt/Umv67OvvD6vT7T1W1+Mk5UWgP4n7OAa
         bGUXhsKU3Fbv/qsvh1Fh1Qlh2Xy/HyVI15vy3N2wHGxNrS+qHvGuoAealL33yxIaWn
         khaUj/4WLQXJA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9F332E6D4D5;
        Mon, 14 Feb 2022 11:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v20, 0/2] ADD DM9051 ETHERNET DRIVER
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164483821064.17157.12984377309696778794.git-patchwork-notify@kernel.org>
Date:   Mon, 14 Feb 2022 11:30:10 +0000
References: <20220211092756.27274-1-josright123@gmail.com>
In-Reply-To: <20220211092756.27274-1-josright123@gmail.com>
To:     Joseph CHAMG <josright123@gmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org, robh+dt@kernel.org,
        joseph_chang@davicom.com.tw, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        andy.shevchenko@gmail.com, andrew@lunn.ch, leon@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (master)
by David S. Miller <davem@davemloft.net>:

On Fri, 11 Feb 2022 17:27:54 +0800 you wrote:
> DM9051 is a spi interface chip,
> need cs/mosi/miso/clock with an interrupt gpio pin
> 
> Joseph CHAMG (2):
>   dt-bindings: net: Add Davicom dm9051 SPI ethernet controller
>   net: Add dm9051 driver
> 
> [...]

Here is the summary with links:
  - [v20,1/2] dt-bindings: net: Add Davicom dm9051 SPI ethernet controller
    https://git.kernel.org/netdev/net-next/c/759856e961e4
  - [v20,2/2] net: Add dm9051 driver
    https://git.kernel.org/netdev/net-next/c/2dc95a4d30ed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


