Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055B8CCA481
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jun 2022 05:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244471AbiF1FKT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jun 2022 01:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244420AbiF1FKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 01:10:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B551A19D;
        Mon, 27 Jun 2022 22:10:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1B1861793;
        Tue, 28 Jun 2022 05:10:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 428D6C341C6;
        Tue, 28 Jun 2022 05:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656393013;
        bh=bFNHVHxRqYMso2Y2PSbMSeU3nkzi4kEh4g5HSEhFO/k=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=QB+WvP4R+I3D7hjl3aOcByBEpRg/zrVZxJ6B/goUDokWixtqlNeI1pm6XYsvWR1nw
         XOJgdzN3SgMyhAN8HDXeLRPNdDSAi5/RI0laqCIcdc3pFN9rgiTCDqhIW5I7Tv5PB/
         ttsSIqUxIct+xdagIDC6zcaRbVDdRzeVzkswNbzfoG5tiCu5M6VRyszne1IrCBLTbr
         M4dNko3VQZ3cKHbbGb2vso9jTTF1VjbN7fr2J41VYABBYIkZ8JUO4J9rITQTlBniw4
         T8nIQwizO+NEfpmjeD5dltQ84jtWFg6S3zLwK+xJyhlIOAA1fSMIAMZoBbhOub21t/
         ogA5Ffsc4z8OA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2737DE49BBA;
        Tue, 28 Jun 2022 05:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] MAINTAINERS: nfc: drop Charles Gorand from NXP-NCI
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165639301315.30025.1234136499894457983.git-patchwork-notify@kernel.org>
Date:   Tue, 28 Jun 2022 05:10:13 +0000
References: <20220626200039.4062784-1-michael@walle.cc>
In-Reply-To: <20220626200039.4062784-1-michael@walle.cc>
To:     Michael Walle <michael@walle.cc>
Cc:     krzysztof.kozlowski@linaro.org, linux-kernel@vger.kernel.org,
        linux-nfc@lists.01.org, netdev@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 26 Jun 2022 22:00:39 +0200 you wrote:
> Mails to Charles get an auto reply, that he is no longer working at
> Eff'Innov technologies. Drop the entry and mark the driver as orphaned.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  MAINTAINERS | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Here is the summary with links:
  - MAINTAINERS: nfc: drop Charles Gorand from NXP-NCI
    https://git.kernel.org/netdev/net/c/6b9f1d46fdad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


