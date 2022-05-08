Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9DFC433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 May 2022 19:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236202AbiEHTIp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 May 2022 15:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238211AbiEHR1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 13:27:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C1EDED0
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 10:24:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3DD06127D
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 17:24:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46D37C385AC;
        Sun,  8 May 2022 17:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652030640;
        bh=OGSNeq9FibhP2r8o1DN+/r8A0jUXBngkFTPzjDXBRHg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qAagCgclpnDXgqt2+UI7u7EZwXV+PISqxG7NE5F9KKou+vg6QBKv3ccVAGRJLxdwq
         qJ/J3E2zmrGKqJA1ZuMxezXKpeklNJR3MvsjAVBoVl3KHjRwxPkSDiw7M7YXaPzPIv
         paLmsZNDQwWsoL2FrlVWN0K7PncJJlad2jkTVEalBF8cWo1tHytYvnd4YMqi8X29kT
         wia/rYONJrQLsro5nYKF2za2/lXxWw6ldR4J+jjBFnlfjz3YrXSucN2wsv2klNSyge
         aGybkbZZhIAFilwcV3xZrOPJG0wxvEF4ntIiNP7VQ6hlFoNixE5sj0ZDb2WBnc698L
         edYezje01jIdg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 33EC5E5D087;
        Sun,  8 May 2022 17:24:00 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 5.18-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5h5ymgo0ky.wl-tiwai@suse.de>
References: <s5h5ymgo0ky.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5h5ymgo0ky.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.18-rc6
X-PR-Tracked-Commit-Id: ac02e3cd5ab9407dcf926df2a1085c13881ccf7a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 379c72654524d97081f8810a0e4284a16f78a25e
Message-Id: <165203064019.1755.9424431586435211170.pr-tracker-bot@kernel.org>
Date:   Sun, 08 May 2022 17:24:00 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 08 May 2022 11:06:21 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.18-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/379c72654524d97081f8810a0e4284a16f78a25e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
