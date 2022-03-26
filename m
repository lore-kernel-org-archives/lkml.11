Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17E7C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Mar 2022 18:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234252AbiCZSwB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Mar 2022 14:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbiCZSvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 14:51:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6A2369FB;
        Sat, 26 Mar 2022 11:50:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47EE1B80B86;
        Sat, 26 Mar 2022 18:50:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B58F0C340ED;
        Sat, 26 Mar 2022 18:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648320610;
        bh=Wqw4eQuViEzG4+yfG4QJHnYoM5iKeaKNB4G1IP3GJmI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=cdhxYo+QdLZRWafxS14zZ3iKCxSJjXGixUDqYZNEcOX0gTDC5Du96oSSQsYzi15MY
         dGQLz83hhjvOZGrHMPLXxkMJ52b0TF/JyPbFxCG08F9hGOonGOCBcq+nayWsy6tjUL
         nBULx3KKBhIezCgfL92wVML4CvDU/PQvuJdaRez+2poYUyg5xFeWInUXlVj3qFQikB
         13qXhyWIeoDQvymy/3CYYRHpdse2WeJ3JZpCqB33yOjID80PdFFj+olDQDewnP1/Fa
         RLgXNLDlMj1SBqjoovWvAgVpptqfYwDUZX2VfnCQYTm4YkjytcL+pb44EGUaF24HGU
         UvHoFDosTNvwg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9B717F03847;
        Sat, 26 Mar 2022 18:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] qlcnic: dcb: default to returning -EOPNOTSUPP
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164832061063.28772.2120074851105666171.git-patchwork-notify@kernel.org>
Date:   Sat, 26 Mar 2022 18:50:10 +0000
References: <20220326172003.2906474-1-trix@redhat.com>
In-Reply-To: <20220326172003.2906474-1-trix@redhat.com>
To:     Tom Rix <trix@redhat.com>
Cc:     shshaikh@marvell.com, manishc@marvell.com, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, nathan@kernel.org,
        ndesaulniers@google.com, sucheta.chakraborty@qlogic.com,
        GR-Linux-NIC-Dev@marvell.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (master)
by David S. Miller <davem@davemloft.net>:

On Sat, 26 Mar 2022 10:20:03 -0700 you wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Clang static analysis reports this issue
> qlcnic_dcb.c:382:10: warning: Assigned value is
>   garbage or undefined
>   mbx_out = *val;
>           ^ ~~~~
> 
> [...]

Here is the summary with links:
  - qlcnic: dcb: default to returning -EOPNOTSUPP
    https://git.kernel.org/netdev/net/c/1521db37f0d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


