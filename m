Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9577C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Mar 2022 18:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350129AbiC3SZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Mar 2022 14:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350300AbiC3SWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 14:22:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6407445781
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 11:20:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF90060F34
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 18:20:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1DB2C34114;
        Wed, 30 Mar 2022 18:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648664413;
        bh=m7Tydcoj1nTyhByX7K4Z5epjQ0nc8bkVxkgOVZwHO6k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TeXSRFpPQA/o2/EAcNjCBh8X2lpfovKfm6cIEFKpnlrzBFULxpqZwKgBJOCvmbbOn
         /LjhRs+2b2t8H1mQLn+Wq3IcRH9JnqGM9FpRL0DTlWb8qlYAuBFVvDRfOyuckBGlYD
         pb83t+Uz7qdg9gLO0JZhsuBOm+KPFEjd8IYmnuZ21tw9FnWqMfPaCDxBuP5C9lEoe+
         H+zQ39dEVuM7Cv9AUNFL7liAR8nUeopHruXdc3YAZIO5UhmuZZPu1MoXpDPwx63IWf
         xmM/l++eDrznZskezW5hHb/KKA9UK7pz6ZroyH/QdQB6oNnMVYzyWl2KJn+xa74Idy
         WDLj2jjvjzpMQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AC6AEEAC081;
        Wed, 30 Mar 2022 18:20:13 +0000 (UTC)
Subject: Re: [GIT PULL] I3C changes for 5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YkOH2Jd9soaAFoog@piout.net>
References: <YkOH2Jd9soaAFoog@piout.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YkOH2Jd9soaAFoog@piout.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-5.18
X-PR-Tracked-Commit-Id: 6cbf8b38dfe3aabe330f2c356949bc4d6a1f034f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f18e345dd156cc0fcf4a4911af2f959120613871
Message-Id: <164866441370.5472.4647208292700829377.pr-tracker-bot@kernel.org>
Date:   Wed, 30 Mar 2022 18:20:13 +0000
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 30 Mar 2022 00:27:36 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-5.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f18e345dd156cc0fcf4a4911af2f959120613871

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
