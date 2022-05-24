Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D85C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 24 May 2022 04:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbiEXE1t (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 May 2022 00:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234631AbiEXE12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 00:27:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F126166FAE
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 21:27:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 351FF61405
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 04:27:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 91522C34118;
        Tue, 24 May 2022 04:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653366443;
        bh=AOurxq/KkW8QV/IxoaDYTbraMvBD2jeoxgvtrfaR6cE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iUSO6cjnJPPUc1gcUaQDTadb+AdfhvIMzun7jiUMT7vc3SOOtFZuYRhzOpgQz1bki
         ba12keVo7iCEJbleRHgVMQCj6llc7NF4wCD3f3q30Dj0qeIGholJJBJKWWDoYFGcel
         1lMlYBbxtUbKyAkF4YMIv0KpNm0osR2sow9+AKUHpowNotCHTyRL/zrh5jaH6Y/+sC
         dP0ASugX5IVA2qZUao/4YG6t5ZBcO+ihUVdwONTpjIUugwmkc/IkLyS8yHVtqrlg6Y
         w3Upr4TJhR/ujFhJS5h39+yRtyTtFI5GyWxXNGFASSkTl+eR5JQpmY6zG/UQxnDqUl
         PZjZ+pbfF6BKw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7F96EF03947;
        Tue, 24 May 2022 04:27:23 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 updates for 5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220523163913.43175-1-catalin.marinas@arm.com>
References: <20220523163913.43175-1-catalin.marinas@arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220523163913.43175-1-catalin.marinas@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream
X-PR-Tracked-Commit-Id: 0616ea3f1b93a99264d84f3d002ae117f6526b62
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 143a6252e1b8ab424b4b293512a97cca7295c182
Message-Id: <165336644351.29742.5407006194895261676.pr-tracker-bot@kernel.org>
Date:   Tue, 24 May 2022 04:27:23 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 23 May 2022 17:39:13 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/143a6252e1b8ab424b4b293512a97cca7295c182

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
