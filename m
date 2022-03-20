Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03B3C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Mar 2022 17:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245658AbiCTREj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Mar 2022 13:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbiCTREc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 13:04:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B873F1FA7E;
        Sun, 20 Mar 2022 10:03:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 692EDB80EE2;
        Sun, 20 Mar 2022 17:03:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F9EDC340E9;
        Sun, 20 Mar 2022 17:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647795786;
        bh=9AmvE5hEiIBpp8GNVJY9fDhWzUV+6Y8RvMvAHJqsbqI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uLn9g4MGqxLoewENTjUeFf597KmTgJy+khs60CNc4OsYGVXiWlrPY74EP0S5BSZ8W
         LJWN6JP+Lf+EBIPjB1L0ztYEGqh1on/akye3h7xkzuxx75y59486IySLBuhEHJnom6
         wjt+cb82CYmeoxrfjGpUNFSM/Lkht4H1cTvix0j/ZAX2Hbx9yFBRyVPy1aVyj/GS4P
         z6a3aCd3WHaUcQiO0AfUyaN+AyxkFKAFQCMfTV0Xcc0vpSpyTr+PEEpXvB0I1MSVoH
         gQ1U3/ek7/GomHUJ+/oUt3furl+vbwSxU56WyfSKauDOaLqUtzopS1qZyld/oH8MFE
         IBN3Srt1NyJCw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EEAFEE73C2D;
        Sun, 20 Mar 2022 17:03:05 +0000 (UTC)
Subject: Re: [GIT PULL] KVM/SLS change for 5.17 final
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220320140731.95666-1-pbonzini@redhat.com>
References: <20220320140731.95666-1-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220320140731.95666-1-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus-5.17
X-PR-Tracked-Commit-Id: fe83f5eae432ccc8e90082d6ed506d5233547473
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7445b2dcd77ae8385bd08bb6c2db20ea0cfa6230
Message-Id: <164779578596.15217.13004200325030149710.pr-tracker-bot@kernel.org>
Date:   Sun, 20 Mar 2022 17:03:05 +0000
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 20 Mar 2022 15:07:31 +0100:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus-5.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7445b2dcd77ae8385bd08bb6c2db20ea0cfa6230

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
