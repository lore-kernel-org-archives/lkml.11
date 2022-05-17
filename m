Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5CFC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 May 2022 09:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245006AbiEQJkQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 May 2022 05:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245010AbiEQJkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 05:40:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A992D45501;
        Tue, 17 May 2022 02:40:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46CF3614E5;
        Tue, 17 May 2022 09:40:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A04C3C36AE2;
        Tue, 17 May 2022 09:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652780411;
        bh=ftmXYUBdFrHTQ7Hbwsdl3QIj6GWmK1JZCyHgtUsGF+c=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=VQA8C0O8lOZOJff7A/1/ctdtHFTaJT14rgBen5ryNasCDNjSwUO0E+O43tlkDqAxA
         Dn77Psa3xK6ie7GzZaP2mDYjS2ErJDLDYuIMrLQkOTae9BWBTTFKJEEhyes29ttqf4
         dFGLrjcDh/zLSmmH99Iz/aoA46SuDloKoEaASi3duj/vuMaDISn5GZe+zICtapVoZX
         3Dn+F7Mk8QL2rK198gNT7/C0bTNsuEjhiW7pnNraw+akdXFVnIcsYm5St1lFfpoKFd
         3YlbBdtwSoN42BvP0e6cYiHAeX8H/Yxy9lJ1pg0LjDS85g4uCPt5m0pZ6tO+IdyniW
         1pDaExN5FsjoA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 84ED3F03935;
        Tue, 17 May 2022 09:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ethernet/ti: delete if NULL check befort devm_kfree
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165278041154.25162.1112878359765215659.git-patchwork-notify@kernel.org>
Date:   Tue, 17 May 2022 09:40:11 +0000
References: <20220516015208.6526-1-bernard@vivo.com>
In-Reply-To: <20220516015208.6526-1-bernard@vivo.com>
To:     Bernard Zhao <bernard@vivo.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        11115066@vivo.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhaojunkui2008@126.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (master)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 15 May 2022 18:52:05 -0700 you wrote:
> devm_kfree check the pointer, there is no need to check before
> devm_kfree call.
> This change is to cleanup the code a bit.
> 
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---
>  drivers/net/ethernet/ti/am65-cpsw-qos.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)

Here is the summary with links:
  - ethernet/ti: delete if NULL check befort devm_kfree
    https://git.kernel.org/netdev/net-next/c/1588f5a91b16

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


