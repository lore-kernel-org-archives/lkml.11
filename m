Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3D6C433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Apr 2022 12:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238533AbiD3Mnk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Apr 2022 08:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236594AbiD3Mnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 08:43:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14D9102F;
        Sat, 30 Apr 2022 05:40:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A7A8BB82A2F;
        Sat, 30 Apr 2022 12:40:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4339DC385AE;
        Sat, 30 Apr 2022 12:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651322411;
        bh=c1pCe6FL9VmirU33xIcaiAcKqp+v2nfmn51Eu2GxUk8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=fIOaT4qvv7TpJdVmJ1ni9Aytmi3wppenvHSKVlVlTlRJTEIyurnKFgUO/ENH66Yu1
         Tp+v7BzCx8D9KZUC1JQz9pjhSaaEb/0ANRy81uCeSXp6rG96YRjy1V2CWkUnWwjo+s
         3sUgldaDjaNT2d1SbXR0ODJFyweOCwGvFQJysyMpVLWCgMK15PQEGhF7fFk6FqYoiq
         fvdR0csIjomlMvb1pqF8QS6cjTkfDfE4YbAhGn4kEWFM//wMwbaABNLFkoMT7Ogr8D
         XWusvoWw3F2KxzMfbQs47ixTFAWJKT73/LLI0ZJnlLW0nBOXW/jWUu3B5isfMiogng
         h++hHvxKTWxMw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 29471F03841;
        Sat, 30 Apr 2022 12:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: cpsw: add missing of_node_put() in cpsw_probe_dt()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165132241116.25919.5899361907812594760.git-patchwork-notify@kernel.org>
Date:   Sat, 30 Apr 2022 12:40:11 +0000
References: <20220429015337.934328-1-yangyingliang@huawei.com>
In-Reply-To: <20220429015337.934328-1-yangyingliang@huawei.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        grygorii.strashko@ti.com, davem@davemloft.net, kuba@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (master)
by David S. Miller <davem@davemloft.net>:

On Fri, 29 Apr 2022 09:53:37 +0800 you wrote:
> 'tmp_node' need be put before returning from cpsw_probe_dt(),
> so add missing of_node_put() in error path.
> 
> Fixes: ed3525eda4c4 ("net: ethernet: ti: introduce cpsw switchdev based driver part 1 - dual-emac")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
> v2:
>    add of_node_put() at label 'err_node_put'.
> 
> [...]

Here is the summary with links:
  - [v2] net: cpsw: add missing of_node_put() in cpsw_probe_dt()
    https://git.kernel.org/netdev/net/c/95098d5ac255

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


