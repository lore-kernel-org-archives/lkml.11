Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E21C433FE
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Apr 2022 17:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350625AbiDARmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Apr 2022 13:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350547AbiDARmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 13:42:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09C414D017
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 10:40:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 818AFB8259F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 17:40:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 23C7EC34112;
        Fri,  1 Apr 2022 17:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648834809;
        bh=0VF5gI+BdUGcipkfhQJ6BC3RNie/2LSNEBiNCz6luZE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MkpEFKiZiEjzCiAa4+RdLgBKIjNh6USlHXpijM0OxRzm08LA/TbSOUXnrQUYlib76
         N3Z+rNJQNUVXCbvNBe1WY8oEEyjfAcKAetwkQReo8IUdI6oD2C22qitaLXKyXa9UXP
         yGRCig5bPGT/88Y9PGEcVyCC8y9Um6p0XncFfzaSYv7Ut4KOEPaZ9sIsPfziFtsl3X
         Kt3xnFpzGPLP0KZ8GOOr5ucoxWBrO1pWBFjKmVJfyQUkX+vjW8ScJGz6Qo4tHmnvyi
         x6UdXq5LhE/HcnJc6anZY22aTJIOlAfUiEle6SGvNbjInUEqyjxRkJhHh/b/3cyiAx
         0sPIg8/rn86EA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 08B2EE6BBCA;
        Fri,  1 Apr 2022 17:40:09 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5h35ixcgdi.wl-tiwai@suse.de>
References: <s5h35ixcgdi.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5h35ixcgdi.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-5.18-rc1
X-PR-Tracked-Commit-Id: bc55cfd5718c7c23e5524582e9fa70b4d10f2433
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d0d642a5d365b5e2295950fd184d5d1f630896dd
Message-Id: <164883480903.11835.4597511360337174140.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Apr 2022 17:40:09 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 01 Apr 2022 11:17:13 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-5.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d0d642a5d365b5e2295950fd184d5d1f630896dd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
