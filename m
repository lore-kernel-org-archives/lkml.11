Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052EFC433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Apr 2022 11:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234949AbiDHLnC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Apr 2022 07:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234914AbiDHLm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 07:42:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B1E18CD0D;
        Fri,  8 Apr 2022 04:40:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E6E8B82A16;
        Fri,  8 Apr 2022 11:40:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE0FDC385A8;
        Fri,  8 Apr 2022 11:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649418012;
        bh=ln+r0fTjyK6JjAT4B3s05a6DFoVKo/oNXPZA1T+sWRw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=kvcJYKE919SEUw0sFnY8NbyR3/Dt61b9zjN7GFyXz//HQDGI73Jw4KeBeM+y3NmQb
         66FwcFQ01ORKumsJGk0+6qpLkxevw/vPiJhugZyWXCOUT9demDd0Enf/xw57boz6vM
         JZr61meYGrtEoUQiYlQZO0TTYioFxzAWs/5AZK8k8BokF0bmkwnlK0DblO8RKTrvpg
         9urTNeXRhTdtj7qiJHQrRLXBvJLql78Tlzw2E4GQ6+juycnRZiBmRm7pOCbusTD65J
         ImGYUnbJ4GJwwtC/UAR9UJaou8eoB2wW94QyRc/2etCkl67fCAPeMmVjzhktdW//Eq
         HIv6xABmjh0cA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CBE58E8DBDA;
        Fri,  8 Apr 2022 11:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] vxlan: fix error return code in vxlan_fdb_append
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164941801183.4420.2330469840554611351.git-patchwork-notify@kernel.org>
Date:   Fri, 08 Apr 2022 11:40:11 +0000
References: <20220407024622.185179-1-wh_bin@126.com>
In-Reply-To: <20220407024622.185179-1-wh_bin@126.com>
To:     Hongbin Wang <wh_bin@126.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        roopa@nvidia.com, edumazet@google.com, bigeasy@linutronix.de,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (master)
by David S. Miller <davem@davemloft.net>:

On Wed,  6 Apr 2022 22:46:22 -0400 you wrote:
> When kmalloc and dst_cache_init failed,
> should return ENOMEM rather than ENOBUFS.
> 
> Signed-off-by: Hongbin Wang <wh_bin@126.com>
> ---
>  drivers/net/vxlan/vxlan_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - vxlan: fix error return code in vxlan_fdb_append
    https://git.kernel.org/netdev/net/c/7cea5560bf65

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


