Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37AB5C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 18 May 2022 00:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbiERAuR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 May 2022 20:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbiERAuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 20:50:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BC24F456;
        Tue, 17 May 2022 17:50:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72A0B61535;
        Wed, 18 May 2022 00:50:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C353BC34117;
        Wed, 18 May 2022 00:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652835011;
        bh=qCFJ+7YxiR6QQVMcRlM8DPk+TLzB2Ca01PfAV6vVFCU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=rQyXlBzfJaXAgP3ljeqZH9kwOxtp+pbRC187LX+qo92A+gVOeC+DAlmxfbCI64+M6
         /aQeZu/iHYugJYA7pkjST4IdFyrteNV2qeHKTOZe2Sb2rOenzi35NWXPTliouEDNMO
         fnu46JUe1C0ErOakenVPl9K/cYR6iyA/Bcpk3Sy4paonK4VbvtugwXcvycZT9Ujq0a
         PSxL/mTdkuhfiCKeY9+80E/qGR+frZP5PfPZeLr8+YPeOn5bGynlFx3VOESru3I7cc
         lPXpUul3UhlkHjMEgbkG5S93R8ZfzEpLh1oal6P/MZ0SIqe5yxew3nVh7SvhO3OfeT
         c8x1kbjqTR6Xw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A1D8DF03939;
        Wed, 18 May 2022 00:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH linux-next] net: smc911x: replace ternary operator with min()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165283501165.24421.7768201614645641413.git-patchwork-notify@kernel.org>
Date:   Wed, 18 May 2022 00:50:11 +0000
References: <20220516115627.66363-1-guozhengkui@vivo.com>
In-Reply-To: <20220516115627.66363-1-guozhengkui@vivo.com>
To:     Guo Zhengkui <guozhengkui@vivo.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, colin.king@intel.com, jiasheng@iscas.ac.cn,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhengkui_guo@outlook.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 May 2022 19:56:25 +0800 you wrote:
> Fix the following coccicheck warning:
> 
> drivers/net/ethernet/smsc/smc911x.c:483:20-22: WARNING opportunity for min()
> 
> Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
> ---
>  drivers/net/ethernet/smsc/smc911x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [linux-next] net: smc911x: replace ternary operator with min()
    https://git.kernel.org/netdev/net-next/c/5ff0348b7f75

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


