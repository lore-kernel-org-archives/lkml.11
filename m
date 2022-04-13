Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681A3C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Apr 2022 01:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiDMB12 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 21:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbiDMB1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 21:27:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983002E6A0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 18:24:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09CA2B820DB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 01:24:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3383C385AB;
        Wed, 13 Apr 2022 01:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649813091;
        bh=WVv8xP8EsTazDXX9+yZEe387stFtqf5XJqQincwmJQs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HQvHKfw2H4tYjfofMDIrBZsGRm8v9wdQeSSOsuVXRoZdp5qYA1PBySUNyd7pGR9lN
         mSF1kBWGk8pwmKprsgTDAFPMDqUn9rGT/4sahZ7YXnYvCe5zn1xQ0qZ6UfF3OaYVIh
         JLJbUkbKBrTpxcJh1/4SRJgVvoEJ+MyndrCPau3caoJwWhA9M0KyfPDYXbfV3vkKQz
         UuRCIfdrPEHliPzhJH4j174PZVnuqLPKXi2WreQKvyrv216wKeLrK503vcqV7+/D7Q
         VJo5Qv9KmUuwzlB3xatGwcenzYL+g+O9UzmEFtapkYfSiJrVF1+pHWK/hLuV4mcYNA
         rFCJssLxXiOwg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B0084E85D15;
        Wed, 13 Apr 2022 01:24:51 +0000 (UTC)
Subject: Re: [GIT PULL] kernel hardening fixes for v5.18-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202204121635.BCF6C9C4D3@keescook>
References: <202204121635.BCF6C9C4D3@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202204121635.BCF6C9C4D3@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v5.18-rc3
X-PR-Tracked-Commit-Id: c40160f2998c897231f8454bf797558d30a20375
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a19944809fe9942e6a96292490717904d0690c21
Message-Id: <164981309171.9925.772594053652812407.pr-tracker-bot@kernel.org>
Date:   Wed, 13 Apr 2022 01:24:51 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Kees Cook <keescook@chromium.org>,
        PaX Team <pageexec@freemail.hu>,
        Tadeusz Struk <tadeusz.struk@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 12 Apr 2022 16:36:10 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v5.18-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a19944809fe9942e6a96292490717904d0690c21

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
