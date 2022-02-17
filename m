Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2B3C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Feb 2022 05:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbiBQFUl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Feb 2022 00:20:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234027AbiBQFUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 00:20:33 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8382A5990;
        Wed, 16 Feb 2022 21:20:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BD9ABCE2A99;
        Thu, 17 Feb 2022 05:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EDFFDC340F1;
        Thu, 17 Feb 2022 05:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645075211;
        bh=jYXmr0UKZPZVISiWYJEA7MX+1xNcLgx43+mRHdlFfSM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=SR2pwOyGkWZKn1muE7WoEWVei6PFgN2HAv9lce/uH0852TsRAMRLyLfnTyChbgEF2
         qLWUQfkg9fynD27lUIVOekIRrBqjtyJdVY2URSEIjNvDUAfC3Y++jf9nK9MypdGljv
         5pvw1fmjw8s3G5WsI64s5JoAJgzE11vP2zhwS1JpVWSWte7rV33fzoS1fYvwDuW7CT
         ptLZ/NxMPs052Dn6+sgpsEIbujla7MHDE/PVkdIKA6tavmwuMriOp8TIGPjThK+evi
         H4DD4+H4ewzxx/2mnTkrTEP2lOWnvm0GgsbpWD1On0sHAtMlzWuT5xjR2nubDllo4e
         0f1w+A1VYrwzg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D5359E7BB04;
        Thu, 17 Feb 2022 05:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: dsa: lantiq_gswip: fix use after free in gswip_remove()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164507521086.4843.15810838690771731499.git-patchwork-notify@kernel.org>
Date:   Thu, 17 Feb 2022 05:20:10 +0000
References: <1644921768-26477-1-git-send-email-khoroshilov@ispras.ru>
In-Reply-To: <1644921768-26477-1-git-send-email-khoroshilov@ispras.ru>
To:     Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc:     vladimir.oltean@nxp.com, f.fainelli@gmail.com, kuba@kernel.org,
        hauke@hauke-m.de, andrew@lunn.ch, vivien.didelot@gmail.com,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 15 Feb 2022 13:42:48 +0300 you wrote:
> of_node_put(priv->ds->slave_mii_bus->dev.of_node) should be
> done before mdiobus_free(priv->ds->slave_mii_bus).
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> Fixes: 0d120dfb5d67 ("net: dsa: lantiq_gswip: don't use devres for mdiobus")
> ---
>  drivers/net/dsa/lantiq_gswip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - net: dsa: lantiq_gswip: fix use after free in gswip_remove()
    https://git.kernel.org/netdev/net/c/8c6ae46150a4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


