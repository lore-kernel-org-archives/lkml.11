Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108B0C43334
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jun 2022 23:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbiF3XAt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jun 2022 19:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbiF3XAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 19:00:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FE05073F;
        Thu, 30 Jun 2022 16:00:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E905B60DF4;
        Thu, 30 Jun 2022 23:00:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A745C385A2;
        Thu, 30 Jun 2022 23:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656630046;
        bh=vQEUJ3kYvM//AAmZ39j4qeTmfsnAG8Rdw2PkNJ1rs8o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rEKr2tU2Qw2PvI9sKOFAp1IuqHZci2FHobJfHaWb5fnnQd57KUzi/zfuqdGN4h3NI
         P1X1qV6FAfRV3OYSQMFi/iIT5Gwp/Gci1ELiysJcWHPR7o9ehFLkJt+iHIwo2/VB8Q
         liunYzvfCfETC2soW8BD43hM6aZL1+ESczv8jT7r2claEjrQX6Ql9Fxzj+Q/vDYZxD
         4oSPaOO8N5J2i3iHU58RRM7UbJsxqkeEdxxrykx9WniMYGG3X83EqxLZ8GLsAnOTlt
         RaT0p9LARNcRrudMiAJwEM+vMA/BCWcCpg7EEcYpCxZ4rAh3ubhdZwpRJ9EMzgt6pE
         Y4osHEZmkk/LQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 36B9BE49BBB;
        Thu, 30 Jun 2022 23:00:46 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for 5.19-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220630193044.3344841-1-kuba@kernel.org>
References: <20220630193044.3344841-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220630193044.3344841-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-5.19-rc5
X-PR-Tracked-Commit-Id: 58bf4db695287c4bb2a5fc9fc12c78fdd4c36894
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5e8379351dbde61ea383e514f0f9ecb2c047cf4e
Message-Id: <165663004621.6808.1664806913400082833.pr-tracker-bot@kernel.org>
Date:   Thu, 30 Jun 2022 23:00:46 +0000
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     torvalds@linux-foundation.org, kuba@kernel.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 30 Jun 2022 12:30:44 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-5.19-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5e8379351dbde61ea383e514f0f9ecb2c047cf4e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
