Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA63C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jun 2022 15:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382997AbiFQPAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jun 2022 11:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382433AbiFQPAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 11:00:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E9A3A5DF
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 08:00:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E8FBB82A37
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 15:00:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C75F3C3411B;
        Fri, 17 Jun 2022 15:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655478007;
        bh=juLM2aFEds/UTQ9zKpiZl6fHy3OD50rorZXIxQMu4u0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DFSS+9WVQJ4QLdR0rACtsY3BPIcwaIrs6TZCDOqbqrlBJACFrb3gtHS0NtcAxpdXi
         dlY5yCrVPsQWvJ6lH2mLmodg9geor37k/wH3E40pIO+P1kjALT25yNFVDoqcKR9jXL
         +qymzQswNg/f+izW/HEsDOTJWaSPDKNn5R88mEtm/FB+pwRsYd0d8alwwH5W+cAiPp
         +prgUUjNZKpzMvcxifnc+c4lwbgeHCs+aKaEKNXm4fbkq5C1z11qI2wR43FtRmrWnz
         3nXlLt8LkvFtN0nLbQI/0V4bEljhXG/OHgZEafY7E9vJu/TQ06mYZnfHy91iIqKGYD
         MuFwJx2oyR0BQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A8573FD99FF;
        Fri, 17 Jun 2022 15:00:07 +0000 (UTC)
Subject: Re: [GIT PULL] Staging driver fixes for 5.19-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yqw4DynMEtAcZVim@kroah.com>
References: <Yqw4DynMEtAcZVim@kroah.com>
X-PR-Tracked-List-Id: <linux-staging.lists.linux.dev>
X-PR-Tracked-Message-Id: <Yqw4DynMEtAcZVim@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.19-rc3
X-PR-Tracked-Commit-Id: cd756dafd86ee3a4969906086f3c2537e0c6d9d0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9afc441c3c9c56f80468c097d25eb1a2a14f0c95
Message-Id: <165547800763.17120.871695222925102794.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Jun 2022 15:00:07 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 Jun 2022 10:15:11 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.19-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9afc441c3c9c56f80468c097d25eb1a2a14f0c95

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
