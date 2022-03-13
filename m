Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBCCC433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Mar 2022 19:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235306AbiCMTBu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Mar 2022 15:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235294AbiCMTBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 15:01:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E54256202
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 12:00:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A741B80CF3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 19:00:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0D278C340E8;
        Sun, 13 Mar 2022 19:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647198039;
        bh=evj78VCLLQOuRUM8rgCOR3CIBDrSmHfNlw3Pn2mwmeI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PouJdIlw3CxXYtBvUIv99xc4SIGmXGoIDhPpTVmsrdYBCEttVOGSbEtDW6m+cTTK7
         /s/NjllrYb79iwqbwO6Wmy53wcdiD0EeHJwXsPWRCDfAKECKluyq4JqdvwM9wTSVbv
         nOUj+GZVlfd8rvTYSvSPWLtS622OG+BI2rJNtoWKXqmgIMorIuNK0vQu4KUE+5vFnm
         bvLOSosN191dVo+obHy4qP3lFP2wxOdZwzzs6dKN7SYO5s8+Tw2/UN48sV+CgvwSTC
         0MIyU0Su7kyzFRy/0i/YibmEQanjca0IRSUXfBmp+pjbmJbpAZDbifS21dACBkcWse
         AxNq9L3N8p1Rw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E4D0BE6D3DD;
        Sun, 13 Mar 2022 19:00:38 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for 5.17{,-rc8}
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yi3Nb6Z9rFNKzEIu@zn.tnic>
References: <Yi3Nb6Z9rFNKzEIu@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yi3Nb6Z9rFNKzEIu@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.17_rc8
X-PR-Tracked-Commit-Id: 08999b2489b4c9b939d7483dbd03702ee4576d96
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f0e18b03fcafd8344539101f564ae358950ae892
Message-Id: <164719803892.24799.12878472623410872401.pr-tracker-bot@kernel.org>
Date:   Sun, 13 Mar 2022 19:00:38 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 13 Mar 2022 11:54:39 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.17_rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f0e18b03fcafd8344539101f564ae358950ae892

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
