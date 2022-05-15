Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F16C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 15 May 2022 13:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237028AbiEONtS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 May 2022 09:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237003AbiEONtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 09:49:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29172F5BA
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 06:49:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C59C60F9D
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 13:48:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DEE95C36AE2;
        Sun, 15 May 2022 13:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652622538;
        bh=jTreumFMetFA6tJ/hPjsAj1trveCC4F1szJB7kluzyU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=eNtdlw4HyiqwEvxxMIZShpz3Jwvd+pVyRav8GYSzaE7yc91jsC2Gm6jGKlob18MPC
         S3mFYXBWkEcMAA9AKrZhsKMdPVFZazl4A9bEhyZeXoyHG1lgl/SxNE+BX5bb0HRkvf
         mzfOpbUKHlLIvPcE7q6zOmh1ud/v/FPhdIeSZtzXa3Qn90k5Yw0/2zElAGn4lBCOdt
         Z7YMY/J/OsPWt+g0Qq7gO41STMuR6N0x0pNdOyZwNSJyz6tfC/350cFlx8ePnpCf0V
         6tXQ6ayAVwQamLfFsjJy42vxIC277KpMekJK7m6kGdv+uUpXiMjb3UkCD36oPLy7ul
         lJYaWZWB7btfg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C5357E8DD69;
        Sun, 15 May 2022 13:48:58 +0000 (UTC)
Subject: Re: [GIT pull] x86/urgent for v5.18-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <165260667833.920532.1890128975471695929.tglx@xen13>
References: <165260667543.920532.17932536291158599837.tglx@xen13> <165260667833.920532.1890128975471695929.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <165260667833.920532.1890128975471695929.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2022-05-15
X-PR-Tracked-Commit-Id: 280abe14b6e0a38de9cc86fe6a019523aadd8f70
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 79dc4fc2f235159f0f59fca2250855a796f590ff
Message-Id: <165262253880.32598.17148955970297986558.pr-tracker-bot@kernel.org>
Date:   Sun, 15 May 2022 13:48:58 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 15 May 2022 11:25:08 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2022-05-15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/79dc4fc2f235159f0f59fca2250855a796f590ff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
