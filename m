Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953B9C19F2D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Aug 2022 18:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241963AbiHFSUJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Aug 2022 14:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbiHFSTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 14:19:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A6AE0C5
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 11:19:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4C6C61161
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 18:19:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0FA71C43141;
        Sat,  6 Aug 2022 18:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659809978;
        bh=ln/S5g2mIY4cQHqdAxg2fEFur99jYiy6v9QQ/+ckCYU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=l9qURp2BYifrWLTcupPrX7msEAINM/xDJ9OqYz0enuD1A/sO5MOTEevsc4CE15tnD
         vn67sENfJOI+RzEt8c49ZzRLyrCerK0SydrfP1Lxd6JZ3BbMWud7gFISX5Eo6jP1Kp
         e+p+GH+HEeRWU4jybSTGTeZdXbJIU1JrPfoJCKmNXlPfNAGbZw14pjbFini3i/aNI6
         7mRyKXTeM53m6+JuMuo1M53C9nx8QoB+2qqtFXfpR6/9KSff1zlGZ/axFRvU072unf
         T5PrqhZMfY5r3tcF18GCR0UWPIPH429SvvNP+W+1RTFV2dorDTvmlBgAsY5YrjPvIa
         wvDaXAEKmgK2Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F10C4C43140;
        Sat,  6 Aug 2022 18:19:37 +0000 (UTC)
Subject: Re: [GIT PULL] sound updates for 6.0-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87czdf2lfo.wl-tiwai@suse.de>
References: <87czdf2lfo.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87czdf2lfo.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.0-rc1
X-PR-Tracked-Commit-Id: 24df5428ef9d1ca1edd54eca7eb667110f2dfae3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 668c3c237f5ddc2889879b08f26d2374231f3287
Message-Id: <165980997798.27284.7400203168250001711.pr-tracker-bot@kernel.org>
Date:   Sat, 06 Aug 2022 18:19:37 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 05 Aug 2022 09:34:19 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.0-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/668c3c237f5ddc2889879b08f26d2374231f3287

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
