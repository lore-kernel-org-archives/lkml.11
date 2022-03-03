Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1256CC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Mar 2022 07:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiCCHBC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Mar 2022 02:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiCCHA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 02:00:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA2C16BCFC;
        Wed,  2 Mar 2022 23:00:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA2A961982;
        Thu,  3 Mar 2022 07:00:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14939C340F8;
        Thu,  3 Mar 2022 07:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646290811;
        bh=yR0NKHoMSVMqfm34BjqsfrQ2a98ZPdHWFVuHeWTJsKk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=gvRbBHNJp+UiMJ4wYql5AsncbrWad4uxcBILZHFvKmEEHlSczs1H6pFKKHOWQbIp3
         ZM0W9N0basfg7nswtPKZ5C+C6ZlmLmP775HP7GbfvKuyPLDThpAM806VLbpauGCaAP
         kBfK1vkTNKN9ZQJ7dIrs6JVcYuQGQquc87sszM5bPnISaDRE1nod2nWUGUjtNDL+oK
         HVSYlfzFbdziTtujT2bpPREhcjVG7CYtKEL9zbEL5MdiFr73BLtmXOKwjmAoDpxSE5
         mYmVEf37bvOY0Na5C0QDfiX4iDL18LiNfKDS0Oj+1O1wd0S15kqS86HFsnXfupuGFs
         EHyAa5BC01vzA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F3FB5EAC096;
        Thu,  3 Mar 2022 07:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] tcp: Remove the unused api
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164629081099.23910.10078762061993431199.git-patchwork-notify@kernel.org>
Date:   Thu, 03 Mar 2022 07:00:10 +0000
References: <SYZP282MB33317DEE1253B37C0F57231E86029@SYZP282MB3331.AUSP282.PROD.OUTLOOK.COM>
In-Reply-To: <SYZP282MB33317DEE1253B37C0F57231E86029@SYZP282MB3331.AUSP282.PROD.OUTLOOK.COM>
To:     Tao Chen <chentao3@hotmail.com>
Cc:     edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  1 Mar 2022 06:35:42 -0800 you wrote:
> Last tcp_write_queue_head() use was removed in commit
> 114f39feab36 ("tcp: restore autocorking"), so remove it.
> 
> Signed-off-by: Tao Chen <chentao3@hotmail.com>
> ---
>  include/net/tcp.h | 5 -----
>  1 file changed, 5 deletions(-)

Here is the summary with links:
  - [v2] tcp: Remove the unused api
    https://git.kernel.org/netdev/net-next/c/42f0c1934c7c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


