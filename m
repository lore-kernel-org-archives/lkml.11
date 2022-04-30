Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C25C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Apr 2022 17:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383250AbiD3RbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Apr 2022 13:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383227AbiD3RbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 13:31:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B6529800
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 10:27:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 739D061023
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 17:27:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9073C385AC;
        Sat, 30 Apr 2022 17:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651339665;
        bh=6pP5MhGckY7lBHWRoflfsbiC8/nvwk3HplMcZ6uUosw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=V5H+lUX7H127Mcu56PuI4qIMSjKxcH7dYJq2V3GCOdTarObUkRn+L9l3gxNwgUKaA
         lCArYnWPC+AH/LHVXN4tgBq3YkjSA6jJkdduyekcdTctoWoZ/F2ia9iMDRi2193loc
         gOJV0u1wpQ6ozT1YrDWso533mMLu/aChmZ+hgy1z0KP98HgV9DPxlmfatdZZOm0cC7
         ZcpRVUIIJ8T2gDWtTjkMYiziaY5gZNQq+B7dxv4q/8eKmrrqmdTPV0+NCE7gIswDUJ
         mlR7pYvEBHFCmQaH498F3bVbUKFRhHuquBuUZoW4M+zOWIxYLx1yrdxGp1JX8p8zyb
         xRY8WKhffx/dQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C46B9F03847;
        Sat, 30 Apr 2022 17:27:45 +0000 (UTC)
Subject: Re: [GIT PULL] Driver core fixes for 5.18-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Ym1bduXu4c5Qt5LA@kroah.com>
References: <Ym1bduXu4c5Qt5LA@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Ym1bduXu4c5Qt5LA@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.18-rc5
X-PR-Tracked-Commit-Id: ad8d869343ae4a07a2038a4ca923f699308c8323
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 57ae8a492116910bad2b3497ffe555b3a4b4180f
Message-Id: <165133966580.20469.16727817948490056963.pr-tracker-bot@kernel.org>
Date:   Sat, 30 Apr 2022 17:27:45 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 30 Apr 2022 17:53:26 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.18-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/57ae8a492116910bad2b3497ffe555b3a4b4180f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
