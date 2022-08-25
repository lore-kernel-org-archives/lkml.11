Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CE5C25B06
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Aug 2022 02:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235797AbiHYCaZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Aug 2022 22:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235051AbiHYCaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 22:30:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3610B37FB4;
        Wed, 24 Aug 2022 19:30:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A45C561291;
        Thu, 25 Aug 2022 02:30:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 05D75C433D6;
        Thu, 25 Aug 2022 02:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661394615;
        bh=zARuAjQaB6fNrTTQ51hm9fDWpTcFilOUCIo3fUAlHXg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=mIPYMT8cWnQnWzRFBnhWgEkRxq4JSElmfjg7xdL6p9+cOeVLTe2JQJMoY7e8Uq76p
         ZaVxF2uvs7PDcUE3oHvZMUDL0atEFYElwv1P3ithgeTxnZtxOuggj5gp+hiTwx+CCA
         KOTNFP+a9J/ptkk+7JOlhXnegSWE6U6sCxwaupZasOT/P8T7/eQiHHqe5okUU8S8MG
         yMeuyo4faTFukFmbfqwauStOe3haACjqgPoKeq9xbrp3BjnzBnrUkJ0ZzmMQjmaTWB
         pxywUTlWrSKN+nONGGlePB56CReY9AwfWanIQ0ShYA7H2XdSpCDh1YLydq0oV9PO5H
         IL5gv5Y5obMNQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D8E6DE2A03D;
        Thu, 25 Aug 2022 02:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] netlink: fix some kernel-doc comments
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166139461488.28757.10831519801603630363.git-patchwork-notify@kernel.org>
Date:   Thu, 25 Aug 2022 02:30:14 +0000
References: <20220824013621.365103-1-shaozhengchao@huawei.com>
In-Reply-To: <20220824013621.365103-1-shaozhengchao@huawei.com>
To:     Zhengchao Shao <shaozhengchao@huawei.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, weiyongjun1@huawei.com, yuehaibing@huawei.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Aug 2022 09:36:21 +0800 you wrote:
> Modify the comment of input parameter of nlmsg_ and nla_ function.
> 
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
>  include/net/netlink.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] netlink: fix some kernel-doc comments
    https://git.kernel.org/netdev/net-next/c/0bf73255d3a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


