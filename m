Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7C3C43334
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Jul 2022 16:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiGJQys (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Jul 2022 12:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiGJQyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 12:54:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767FC2BF0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 09:54:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2538AB80B77
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 16:54:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C7525C341C8;
        Sun, 10 Jul 2022 16:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657472073;
        bh=0vhv3C2XXK2OAjekR7Kmc+fP9gOJO04apnP8JJRfzh0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VHhWBkLue1FUU1mj/OmYco5KJEo+fQeLqcPHQ/7ae2zilg3Y62osc0YvfqmLAN6Tk
         b0LkdZZksEULYc2STVIbb/evC04+k0cP9ofekFmKmL8MzGln6WxI4Z+/yjm2DxsEXa
         7sbBsbqDYSGC7wf5RmmNdpolSHZZoBIcwul0WPsZfcTvVQS+5Y9Tto43ymntVGQ/RP
         /moVWURuWw6iFTiteh3kda/bAdtZVazXKyd8a9+xBhCVjQdDkA4jScFH0FjZeAxY60
         zj3BgyKHvvCFJO+StlH8q6MtGFJxj7bEei5TXLhYqAsrshHpELsmbPe3eqi9mMfaeU
         kUjwshYxsds6Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B2D96E45BDB;
        Sun, 10 Jul 2022 16:54:33 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver fixes 5.19-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YsrueF8EfYIOyCk/@kroah.com>
References: <YsrueF8EfYIOyCk/@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YsrueF8EfYIOyCk/@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.19-rc6
X-PR-Tracked-Commit-Id: 2cd37c2e72449a7add6da1183d20a6247d6db111
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b41362fdf26710693535fade5e4eeda019c3b410
Message-Id: <165747207372.29896.9804525535017782512.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Jul 2022 16:54:33 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 10 Jul 2022 17:21:28 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.19-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b41362fdf26710693535fade5e4eeda019c3b410

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
