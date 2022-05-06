Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A23C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  6 May 2022 01:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388179AbiEFByf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 May 2022 21:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388155AbiEFBx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 21:53:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D7CB0D;
        Thu,  5 May 2022 18:50:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C88DB8322A;
        Fri,  6 May 2022 01:50:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB9A4C385AF;
        Fri,  6 May 2022 01:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651801812;
        bh=3L6EWigNjLfkSY3gbVoUUSk6fenLP0PHh1EmiBIFWKA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=IQwgh0x76Mccvw5H64r98arR8SKqKNRcTfidCv7cHHTWlZvjUuSG3gDQYbufQJ9OW
         4v/NOvVS06S9HT5VOcr5jIQR1TpiSLW9h7E9kNwstxpgSQAUhD8vTzolxb5gTSczKP
         WW5NbRFp/sqdIHXleaBOZ6+gajrB1IQr31sgOfrlMitzaFxx5tHGKlVUngxw40E8AY
         aaKEUAGaQWjZlQri3x49+XFIM2PFiPtdX3afTPa7OD+hQnisoFQwzGurcB0ACUfA5w
         k7jZwUxonHBWQF4u4BciFkd/UhhmMFlOQSeQEKxRBRGRne26+I6AZupM/1TqLfDlPQ
         qp6W7sJ5XY58g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B68ABE8DBDA;
        Fri,  6 May 2022 01:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next RESEND] MAINTAINERS: add missing files for bonding
 definition
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165180181274.30469.17316991103647300467.git-patchwork-notify@kernel.org>
Date:   Fri, 06 May 2022 01:50:12 +0000
References: <903ed2906b93628b38a2015664a20d2802042863.1651690748.git.jtoppins@redhat.com>
In-Reply-To: <903ed2906b93628b38a2015664a20d2802042863.1651690748.git.jtoppins@redhat.com>
To:     Jonathan Toppins <jtoppins@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 May 2022 14:59:08 -0400 you wrote:
> The bonding entry did not include additional include files that have
> been added nor did it reference the documentation. Add these references
> for completeness.
> 
> Signed-off-by: Jonathan Toppins <jtoppins@redhat.com>
> ---
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [net-next,RESEND] MAINTAINERS: add missing files for bonding definition
    https://git.kernel.org/netdev/net/c/4e707344e185

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


