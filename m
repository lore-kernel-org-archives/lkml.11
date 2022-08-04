Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AEC4C25B06
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Aug 2022 22:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240189AbiHDWqd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Aug 2022 18:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240186AbiHDWqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 18:46:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338D21C113
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 15:46:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC4DC61870
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 22:46:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A71DC433D7;
        Thu,  4 Aug 2022 22:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659653176;
        bh=8GbqkiWfNHy2YTDTpXKrS42/D7bPRs2xpLIZuqfQv1k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BSaOSXNTpSmPHVDPuPEpDsIUK21kmPwm610k31OZRLDP/LlM+raW8M02bwFjnEq2L
         Pj/eQsdABgHRDyshPrttb/HUho6yI37RMWk4YzB5M2qBi3nkexzCKcTAMEVoQMasVH
         gB07M6x6dXCY8djUQjlnbrOlgC5C48QVyR/id+CNZoZYEGCYC5s+4TPWJGDrOQvhMo
         FoIUUzQuc3CUuEkvS7+wzy2xMve+U+l/KioOo0CNEGeA3AI0T2Qqi3aWrVdBDMCKe+
         qV3wdVTKK9ul5E9Ojx2vabjrtPUeUfOzfM/QlHAmpzgNJX85+kXgZ8PaMRyktw9WD7
         86ruYl8wdLfBA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0969CC43142;
        Thu,  4 Aug 2022 22:46:16 +0000 (UTC)
Subject: Re: [PULL 0/5] xtensa updates for v5.20
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220804181207.1246232-1-jcmvbkbc@gmail.com>
References: <20220804181207.1246232-1-jcmvbkbc@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220804181207.1246232-1-jcmvbkbc@gmail.com>
X-PR-Tracked-Remote: https://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20220804
X-PR-Tracked-Commit-Id: 0847d167d0f9bdc8f61e5e5d32831fa8fdcd150f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c040862bfbd9c5f3cb64e1df1c623e20e38fe656
Message-Id: <165965317603.20279.17958134995271590719.pr-tracker-bot@kernel.org>
Date:   Thu, 04 Aug 2022 22:46:16 +0000
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  4 Aug 2022 11:12:07 -0700:

> https://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20220804

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c040862bfbd9c5f3cb64e1df1c623e20e38fe656

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
