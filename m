Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154C2C433EF
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Jul 2022 17:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbiGBRiu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Jul 2022 13:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiGBRir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 13:38:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFF8E03E;
        Sat,  2 Jul 2022 10:38:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F06C460EAA;
        Sat,  2 Jul 2022 17:38:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D0A0C34114;
        Sat,  2 Jul 2022 17:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656783526;
        bh=Gb8uLaU41fUi1H/x8XkA91xY0HYTVPLXOaLjTrX8Enc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RlSR5/osG8vu3FxuNkRDtJOqQ0QsCzocjb7SHGKw3Ye83/PdhOJjab9pLGydtOuAB
         9fnSA+CatqvZy/Q8oaHEDg1YO8Nvl7ZtpUcYrZvwTuzX/cY3m9XwTWevI5K53rrP/b
         d0XMU3nkZvZhbU14TE35LmEk2xAi+D6yYCQERmzub6B1+Pvse7Ad1+B7QbXhH3Rnrc
         XPtnlmJvVXeDAwuHo9tzCmv7PEQpTMVkYSV6o6pKF7bhjn4kiNTtaLS9Q1PkWcoZyf
         LC8lA18IW1bhwbrjkhzEwBoyNw2JBl9eTFKJe4oskFoynj8eLniZgTIgTaMIiEWRDT
         Kn6Z38q9vfNOw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 49891E49BBC;
        Sat,  2 Jul 2022 17:38:46 +0000 (UTC)
Subject: Re: [GIT PULL] parisc architecture updates for v5.19-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YsB7W2GLGRjR+TNr@p100>
References: <YsB7W2GLGRjR+TNr@p100>
X-PR-Tracked-List-Id: <linux-parisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <YsB7W2GLGRjR+TNr@p100>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.19/parisc-4
X-PR-Tracked-Commit-Id: aa78fa905b4431c432071a878da99c2b37fc0e79
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 34074da5424c08542d197396757cc3194ef754b4
Message-Id: <165678352629.3400.7825006178867216849.pr-tracker-bot@kernel.org>
Date:   Sat, 02 Jul 2022 17:38:46 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 2 Jul 2022 19:07:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.19/parisc-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/34074da5424c08542d197396757cc3194ef754b4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
