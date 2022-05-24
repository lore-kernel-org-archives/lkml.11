Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41078C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 24 May 2022 04:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234826AbiEXE2B (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 May 2022 00:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234648AbiEXE13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 00:27:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BA46899D
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 21:27:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F2B3613FB
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 04:27:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A80D5C36AE5;
        Tue, 24 May 2022 04:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653366443;
        bh=SxALyILetja/XiEAbYQRxFW7ZnjMxzcRQRvUOF2Z3kE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fRVcedOdsYwMMJGzPbb1cx2bGNWWVkz2dP4WD7RCV/W7pMiL2xu5+UHMtJ3t72cSO
         4Dn87/RSCiXb6sWdaGS3zlL37IzGURZvgsr87tMPyADUfMtNBWIFIcKhtWpgCVJowt
         OO9i+J2qNnrphP3v1qK/nmamAElAhqDtQ3SxrWeZ7SPronVYntpqdJGEE9FLtKb9Bt
         c9eCS4tmOw43wzUKRY66EiSfP8PWjw7yakKdILOZpWks12TJpfV6dsf1T6FT7wCLwo
         nX6kK1y2R5hDYftNOrLjk3XzbO1+6/N3briNXr3FLPs4GTDMhXCEBxfBPgrUmenX8T
         bgKmCGwZE1fiw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 96DE1F03938;
        Tue, 24 May 2022 04:27:23 +0000 (UTC)
Subject: Re: [GIT PULL] x86/sgx for v5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <e9abfba4-d178-7ee5-da13-4cd9e07ba331@intel.com>
References: <e9abfba4-d178-7ee5-da13-4cd9e07ba331@intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <e9abfba4-d178-7ee5-da13-4cd9e07ba331@intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sgx_for_v5.19_rc1
X-PR-Tracked-Commit-Id: e3a3bbe3e99de73043a1d32d36cf4d211dc58c7e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cfe1cb014bf947c8a85e542ab0f7a417adca7059
Message-Id: <165336644361.29742.7312677374828040416.pr-tracker-bot@kernel.org>
Date:   Tue, 24 May 2022 04:27:23 +0000
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 23 May 2022 10:23:52 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sgx_for_v5.19_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cfe1cb014bf947c8a85e542ab0f7a417adca7059

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
