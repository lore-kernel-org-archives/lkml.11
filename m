Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1ECECAAD4
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Sep 2022 17:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbiICRhR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Sep 2022 13:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbiICRhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 13:37:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405AE52DF5
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 10:37:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CE3960BC6
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 17:37:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81F3DC433D7;
        Sat,  3 Sep 2022 17:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662226627;
        bh=vMe+MPJSu6IvdmG7H4esZoCwHCK4sOq6It0vtPsWEEA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gn7XJq1NwKEJkcbkvoKA/BDYRgWxm3AZQRDZw9fME2C8ASazWDbgBLxaT+HwXGOFY
         1DYAcX8YGGtrtQFWuB9LY8KJFcXfuJKG+uSijCDnH8DzWSPPK2KfD9JsMqbgHQjVs9
         FPbFIvIk/W+MA9eO5ubqUwuX3p1pV70oWWzt3ybxWW0vl0rOfTnqhkup/MxedxjhgY
         p0RlItFr6xKidz2huXcJnmSzZf2FxOYsvDPcFVA7tAE7n1nLh2OhLwZ9HEY3AWbpPY
         8rdljQPOdhzgwCFdKTEfDt5FH+PcV9FLdO2MbafCKl913Nk8QOlYQJpAbYI72y/2Sq
         Mf3yOmpn350Zg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6BC28C395DB;
        Sat,  3 Sep 2022 17:37:07 +0000 (UTC)
Subject: Re: [GIT PULL] Staging driver fixes for 6.0-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YxL1iR5/c+tl60ja@kroah.com>
References: <YxL1iR5/c+tl60ja@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YxL1iR5/c+tl60ja@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.0-rc4
X-PR-Tracked-Commit-Id: e230a4455ac3e9b112f0367d1b8e255e141afae0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c53b3dcb9942b8ed7f81ee3921c4085d87070c73
Message-Id: <166222662743.30432.11405932023025320341.pr-tracker-bot@kernel.org>
Date:   Sat, 03 Sep 2022 17:37:07 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 3 Sep 2022 08:34:49 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.0-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c53b3dcb9942b8ed7f81ee3921c4085d87070c73

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
