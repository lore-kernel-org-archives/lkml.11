Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E130C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Mar 2022 21:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbiCYVJG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Mar 2022 17:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233279AbiCYVIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 17:08:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D3C1EDA37
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 14:07:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48E3361D7D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 21:07:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE3D3C36AE3;
        Fri, 25 Mar 2022 21:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648242426;
        bh=PA3+t8bHQ4uRnyUhnP9UF+rTF5VsNaPbiks0yzerpns=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=p9wSJ78p9ahqj40iwWnBgDnqR/6LkLdZnqSCDtuB3xrddh5npx6QPSTNBE9q/wO/I
         IDOLthfqf1FeWMhGhAtc7p7Eg2qqGQRSXVs+1HbJjXn+5XHXB3TI/8FIA8bmNAqXWd
         0Y68T5/BLRi+iLlGRbR6KULiCdIXGWzZ0/pQ+6LDa6NXYnja9M3b8AVx1eV5KQkz5y
         abn/3a6lsAf2dKhYhtazlnkpYfIdSnxsZhCKCP20q3tOKeISMHGdHUfNicbYRgTPoS
         7BZovh4tEZ0BGbIE1XzWsy7w1MeuDbw7WOQWdc61NDsfAOIOQeIorOSb6N2v3nAjsp
         TS6Zb/jFfBKBw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9C5AAE7BB0B;
        Fri, 25 Mar 2022 21:07:06 +0000 (UTC)
Subject: Re: [GIT PULL] Backlight for v5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yj2gqnIk6HY5WyKo@google.com>
References: <Yj2gqnIk6HY5WyKo@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yj2gqnIk6HY5WyKo@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git backlight-next-5.18
X-PR-Tracked-Commit-Id: 023a8830a62846e1cecc8da07e00c801dd0d7598
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 46f538bf2404ee9c32648deafb886f49144bfd5e
Message-Id: <164824242663.8431.1930325632927035855.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Mar 2022 21:07:06 +0000
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 25 Mar 2022 10:59:54 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git backlight-next-5.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/46f538bf2404ee9c32648deafb886f49144bfd5e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
