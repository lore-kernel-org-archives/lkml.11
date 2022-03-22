Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC473C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Mar 2022 03:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236024AbiCVDIV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Mar 2022 23:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235991AbiCVDIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 23:08:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207EE28E3D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 20:06:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3FD0B81B44
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 03:06:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6CF9DC36AE7;
        Tue, 22 Mar 2022 03:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647918398;
        bh=+VrkQ5qQx0jI/dAgMz/rAx+2rfiHpCNeN9ROIsRsLz4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jI5PalNCKR36sU7ebtUFBdyk+77FzFwb5lnipXgh3qNqy8m2Q+kgVewC4OHHoahx/
         WhKTdbMtYQLAk9Nlw9/SsZI0ne5rYtwJCg+KbQkPHPo1x2j2N/IOiLS1tbhrsGVaux
         ViwIUNtVBP+b+L5HpUxzDjuRxTF0RU6xUinJ42+9den48z5Wl/BPZ+RZT4t45eiLLo
         jCD6d2RuOs6ZFf2UKAMYWFVDIvRUOIdlNZtG6MSQ33hpcj+aH2Xsvws8LlhkXNOMOK
         Nmkk+XuHYZOWrqZQyEXeBrFoYP3akszqXe9NXGOUS7KTqjq29fWrXl+IEOtGYUenyE
         DuGzkESTAlYmg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5A655E7BB0B;
        Tue, 22 Mar 2022 03:06:38 +0000 (UTC)
Subject: Re: [GIT PULL] pstore updates for v5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202203210747.C40221E63F@keescook>
References: <202203210747.C40221E63F@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202203210747.C40221E63F@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v5.18-rc1
X-PR-Tracked-Commit-Id: 8126b1c73108bc691f5643df19071a59a69d0bc6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fd2d7a4a354539dc141f702c6c277bf3380e8778
Message-Id: <164791839836.13286.3803635250418520072.pr-tracker-bot@kernel.org>
Date:   Tue, 22 Mar 2022 03:06:38 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 21 Mar 2022 07:47:53 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v5.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fd2d7a4a354539dc141f702c6c277bf3380e8778

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
