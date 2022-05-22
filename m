Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20119C433FE
	for <linux-kernel@archiver.kernel.org>; Sun, 22 May 2022 19:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350693AbiEVTub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 May 2022 15:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350799AbiEVTuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 15:50:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937F039BA8;
        Sun, 22 May 2022 12:50:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30D4561132;
        Sun, 22 May 2022 19:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7EDB5C34118;
        Sun, 22 May 2022 19:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653249012;
        bh=Ub+IOYnJnxk/eYgoRrTOwYMEFkGfwHU1mKG3My/XPaw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=SRCKIwN4qWks6m+4dUJH0SAzd6j6I0sGiyWLSuULAlaQZtSJK9YplLG2iLzhUOXzl
         bIF4rCnEuIIGP9UbBmovetDlZEeUtNOL+lmNZ3xmtekQh30hvNISBdr6clVtgFuRmj
         Wf/dmEsj2xGIycbigrY5kDhgRuYKGEzz2KIy17pye8CgbXO0eSnKXd2j168Fk2Jekf
         Rv0GgTujKFJl5GPWrkCNa8Lks+CMetIyZN6cvuO2lRM7QgLK0FkHFvW/DOSmbpvZyG
         Wxz/ReoZlX3pK2RNfW+T1TV7DP5pCjHhUQsyjfDUgJD8rNPHIZRFe7OVlZTHCZD3L4
         8AMx6gTuKG24w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 63D4AF03944;
        Sun, 22 May 2022 19:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] cirrus: cs89x0: fix typo in comment
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165324901240.28407.16150306909965262726.git-patchwork-notify@kernel.org>
Date:   Sun, 22 May 2022 19:50:12 +0000
References: <20220521111145.81697-47-Julia.Lawall@inria.fr>
In-Reply-To: <20220521111145.81697-47-Julia.Lawall@inria.fr>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     davem@davemloft.net, kernel-janitors@vger.kernel.org,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (master)
by David S. Miller <davem@davemloft.net>:

On Sat, 21 May 2022 13:10:57 +0200 you wrote:
> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> ---
>  drivers/net/ethernet/cirrus/cs89x0.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - cirrus: cs89x0: fix typo in comment
    https://git.kernel.org/netdev/net-next/c/3f660c1820f7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


