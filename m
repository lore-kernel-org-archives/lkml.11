Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60EDC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Mar 2022 15:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbiCIPBQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Mar 2022 10:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233101AbiCIPBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 10:01:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BFB151342;
        Wed,  9 Mar 2022 07:00:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CAEA61157;
        Wed,  9 Mar 2022 15:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 97C6AC340F8;
        Wed,  9 Mar 2022 15:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646838014;
        bh=8+Wwmzha7qMTmPjbOP8MH0J36SecwzQWAPelpOSSfmA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=IMqEcARiyeABko3ZvDs9FcpzsfpryKPMZSUCwUldvR5ci5Fr5BH5JsEo4GTark2MQ
         Vee7KriRYpkTMYA12mXXhYc3oNV/u1ee8MeKdCVpaLjoo1SiTPfSaSOuf/23FL3qhk
         kE5M+WvmU4Y5fK4jQb3Cffltrn17r+TM3DoMJvso/0NBoXaHUZtzO2EQl6cKov51lv
         fpjF697uRg2lRvl8nUJ71LFcWTMeD36QcLX5LdGXAclGBpNIkXo/yGRzmRhhH8KHiu
         1Nl1yyMY667PvnNuVb62AdND6+bdlbbzBfAwI91yYQ5hJo/bnCIDVXnlrnaGZB85Z8
         mWBwJ626LWdDw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7F177EAC095;
        Wed,  9 Mar 2022 15:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ethernet: sun: use min_t() to make code cleaner
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164683801451.7970.8378076408639039246.git-patchwork-notify@kernel.org>
Date:   Wed, 09 Mar 2022 15:00:14 +0000
References: <20220308092106.2079060-1-deng.changcheng@zte.com.cn>
In-Reply-To: <20220308092106.2079060-1-deng.changcheng@zte.com.cn>
To:     Lv Ruyi <cgel.zte@gmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org, wangqing@vivo.com,
        jgg@ziepe.ca, arnd@arndb.de, jiapeng.chong@linux.alibaba.com,
        gustavoars@kernel.org, christophe.jaillet@wanadoo.fr,
        deng.changcheng@zte.com.cn, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, zealci@zte.com.cn
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (master)
by David S. Miller <davem@davemloft.net>:

On Tue,  8 Mar 2022 09:21:06 +0000 you wrote:
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
> 
> Use min_t() in order to make code cleaner.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
> 
> [...]

Here is the summary with links:
  - net: ethernet: sun: use min_t() to make code cleaner
    https://git.kernel.org/netdev/net-next/c/2c9ec169f70b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


