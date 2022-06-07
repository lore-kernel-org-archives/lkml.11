Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28258C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jun 2022 09:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239374AbiFGJUb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 05:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239295AbiFGJUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 05:20:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6668CE52A9;
        Tue,  7 Jun 2022 02:20:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7190611DE;
        Tue,  7 Jun 2022 09:20:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49FA7C3411C;
        Tue,  7 Jun 2022 09:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654593613;
        bh=Kxo13GNINV7Mv2iQmG0qXKbjXvV2omItDkxes0R90Wo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ebi/WVdl1MxqzOlmc08dRDWdf9Lx/kS7Z/Qyn2eoIpOc7Uwcls/KJ/nFYu4/a6vR0
         G4aet2ud+Kaa9lSjuNpeLYS8bJHnGq1OBx7HkFQqnDbkSZS/MlN89c9dohkZwQRHfK
         tYgj+pHQSqhvWYiN23E3bVH+QMYv3Y2mDz6JI0K/m3xmASXsX2MVeJI6NG39bniawn
         baEO2DcC1PX1MARCbvt62K9vQVaIFbpQGU2UN4Uola8v3P4F9aP4zs41LmdoGP6J3h
         yAwInDizPwxKNFTZfQqy5J2C2AZ1wuzZTY12LJG9pC8Fa+R+thG+fmWa7G/NDcCdXk
         a6V61rUPqbuQA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2E3DEE737EE;
        Tue,  7 Jun 2022 09:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] WAN: Fix syntax errors in comments
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165459361318.9388.14355232312884432812.git-patchwork-notify@kernel.org>
Date:   Tue, 07 Jun 2022 09:20:13 +0000
References: <20220604040917.8926-1-wangxiang@cdjrlc.com>
In-Reply-To: <20220604040917.8926-1-wangxiang@cdjrlc.com>
To:     Xiang wangx <wangxiang@cdjrlc.com>
Cc:     davem@davemloft.net, kevin.curtis@farsite.co.uk,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (master)
by Paolo Abeni <pabeni@redhat.com>:

On Sat,  4 Jun 2022 12:09:17 +0800 you wrote:
> Delete the redundant word 'the'.
> 
> Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
> ---
>  drivers/net/wan/farsync.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - WAN: Fix syntax errors in comments
    https://git.kernel.org/netdev/net-next/c/6fa4a6d20c16

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


