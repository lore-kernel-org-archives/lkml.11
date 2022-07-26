Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6545EC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jul 2022 02:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237454AbiGZCu1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jul 2022 22:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235723AbiGZCuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 22:50:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A11D6160;
        Mon, 25 Jul 2022 19:50:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B477D614E5;
        Tue, 26 Jul 2022 02:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16A98C341CE;
        Tue, 26 Jul 2022 02:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658803815;
        bh=hyoarOGG0+HLL5wirVTHMCZd83tAizPY2jFWnK8m3Cw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=mHmgE1zQpCSOANDjQ95bSb2+6O23wCtB5hJNrdrX/H5r9LYmcZAUMT4Dhm8rIYzES
         d1Pc36JNhoKTn8b9eyoHEOAhJml0PJ0W6tT7ehHI1AI5nDAsEaWI6N8AJDGwujPko2
         vFO/nOPm6JAnj+YLAfQf1//2qzIp+Noe2RlBdCAlhyAlOH+5iVHyukPGhDt7BWhUF3
         /mjBC6Cl2idBTku2S6eOUl2Vpr7/Fz1SJh4RJUGAQnaEBV9aWQgyYW/e61QvXS8q1I
         bXT2UtivNgPIiotvL4tYmr7WubUXDEAxFEPgsqfLVnzf5CRxIdmIFxrKvkfDEeZuqR
         p4ZbQYlMem8tw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ECB3BE450B4;
        Tue, 26 Jul 2022 02:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: delete extra space and tab in blank line
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165880381496.11874.11661197265788899470.git-patchwork-notify@kernel.org>
Date:   Tue, 26 Jul 2022 02:50:14 +0000
References: <20220723073222.2961602-1-williamsukatube@163.com>
In-Reply-To: <20220723073222.2961602-1-williamsukatube@163.com>
To:     None <williamsukatube@163.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-afs@lists.infradead.org,
        dhowells@redhat.com, marc.dionne@auristor.com,
        williamsukatube@gmail.com, hacashRobot@santino.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 23 Jul 2022 15:32:22 +0800 you wrote:
> From: William Dean <williamsukatube@gmail.com>
> 
> delete extra space and tab in blank line, there is no functional change.
> 
> Reported-by: Hacash Robot <hacashRobot@santino.com>
> Signed-off-by: William Dean <williamsukatube@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: delete extra space and tab in blank line
    https://git.kernel.org/netdev/net-next/c/aa246499bb5f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


