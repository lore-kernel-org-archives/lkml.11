Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75989C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Apr 2022 20:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243900AbiDJUOl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Apr 2022 16:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242011AbiDJUOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 16:14:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915714B1CC
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 13:12:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2804561243
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 20:12:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B53DC385AA;
        Sun, 10 Apr 2022 20:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649621542;
        bh=KK9L7oSmYUauDE+ORapWC3VsN69XuXFHH85bdi0n+7s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=e39Olygo7oazFexHrq1QcJ12LOr8tCEinL9cThDjoOkquIIkQY/ooldvmY/L0hQIc
         U7/enkbX0Bs7OCWvq/EiZx/wkMjaw6S8d8fwrWVU5Z46exrg86PXCvQcfhecgTzv4B
         +hm96t5vzlf6QwFEk3aUA0Nl0UfuGaL4G1smcEN1lybBSt/E7medvIZLVynRx5KKIz
         5Kso/DpsIhyVXDQKC/4ktFeikmwKKM9m6ICK2FQNmTERgMikiQrLENQE0AqkvYOq8f
         SqvXjw5eO5pddHHxAE+OaDadnhAcs9gjP1AtbJZ+W+CrDB8P22BqZUB7ksrUQosAEX
         E1whsEyzklKUA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 75001E8DBD1;
        Sun, 10 Apr 2022 20:12:22 +0000 (UTC)
Subject: Re: [GIT PULL] Driver core changes for 5.18-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YlLRSO25cPZ7cLZR@kroah.com>
References: <YlLRSO25cPZ7cLZR@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YlLRSO25cPZ7cLZR@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.18-rc2
X-PR-Tracked-Commit-Id: cdb4f26a63c391317e335e6e683a614358e70aeb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 33563138ac2fa38fd4fb9fc79a2c29be4ea65642
Message-Id: <164962154247.385.3745762403247447500.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Apr 2022 20:12:22 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 10 Apr 2022 14:44:56 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.18-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/33563138ac2fa38fd4fb9fc79a2c29be4ea65642

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
