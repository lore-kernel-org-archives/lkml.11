Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53153C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Mar 2022 23:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243039AbiCaXYs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Mar 2022 19:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243008AbiCaXYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 19:24:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D94F104A4E
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 16:22:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD5E2616BF
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 23:22:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A227C340F2;
        Thu, 31 Mar 2022 23:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648768976;
        bh=FH0m558pqChjSnVcIP66x8ypn8bfqK0HFKCtz7iN8Sk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Gr3SGwmFs9SHLrYilTqovDudhuRpbI0jGubAUNbhUp4ytVSKFnqzfdk5q+i8XwGG3
         vCaZtn2xdlmbpz2jfvyqBDJTeofoMORJ1paggL/sWIbmIXJw152ArfyicpKvt9wTmK
         /xvoAM/T3xJ28WiwpNgIpKuGGngb7+EGFNqSUXogxrKdrJB6HZfgPsHgDeOJeDuQwV
         Lm+foiKqDW2JvlF/5tbm4uaC+77OUDLROaAYiyT801YB9HdBtejfVTctenPMitHvMC
         z6kGOFPhk5nrqJav0IuJFJLDCkw8VUnvqsUZ3CbWt9TqTArbAD342kYUkXaCNn//XZ
         DKp8pMNj51+fA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 380CCEAC09B;
        Thu, 31 Mar 2022 23:22:56 +0000 (UTC)
Subject: Re: [GIT PULL] gfs fixes for 5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220331201149.566786-1-agruenba@redhat.com>
References: <20220331201149.566786-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220331201149.566786-1-agruenba@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.17-rc4-fixes
X-PR-Tracked-Commit-Id: 27ca8273fda398638ca994a207323a85b6d81190
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3d198e42ce25cb1d58ff7052c036407271ebfb51
Message-Id: <164876897622.28012.1848928690831938514.pr-tracker-bot@kernel.org>
Date:   Thu, 31 Mar 2022 23:22:56 +0000
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 31 Mar 2022 22:11:49 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.17-rc4-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3d198e42ce25cb1d58ff7052c036407271ebfb51

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
