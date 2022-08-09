Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90D6C19F2D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Aug 2022 17:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245245AbiHIRDS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Aug 2022 13:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245518AbiHIRCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 13:02:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399BB6419;
        Tue,  9 Aug 2022 10:02:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0082B8166E;
        Tue,  9 Aug 2022 17:02:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9EB20C433C1;
        Tue,  9 Aug 2022 17:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660064558;
        bh=vs/RgoJOKweyDQaVfy6BsbugDW8SAYyCIJcI0pHYn48=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=X5jYG0Re+3VlHqRCxsDVN+6QYUIwl4EgSx4pDM9bzHkb9q1lqwhYQFvOQZlihsqjK
         LJFg8MuEbryLu3GZHIedV7mCJ9Cnr5pPJ4WJQguXxDJHWWiI91hbuqyGYVlvtWixxH
         kDC+tTMkcHqkx6FA69aCX4GC4txwbF3/UjwDckFOXcc31dEb3Kb4Rw18QW+HKmOCcx
         Gy4muofuq1Z6blACogw/cJ7YCIwZRpvhQTH7Ah3HDc3kF9hQHDCgqlU86uSjkZm4ky
         Yr9kzdIYP7Y/tu0+ViePpViK6t7sQVj1PlyawUxuQRDWr5WL6wReO55Kg9ni/m4iWJ
         joW+YVicNUgZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8E560C43140;
        Tue,  9 Aug 2022 17:02:38 +0000 (UTC)
Subject: Re: [GIT PULL] setgid inheritance for v5.20/v6.0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220809103957.1851931-1-brauner@kernel.org>
References: <20220809103957.1851931-1-brauner@kernel.org>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220809103957.1851931-1-brauner@kernel.org>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.setgid.v6.0
X-PR-Tracked-Commit-Id: 5fadbd992996e9dda7ebcb62f5352866057bd619
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 426b4ca2d6a5ab51f6b6175d06e4f8ddea434cdf
Message-Id: <166006455857.27167.3132300456623890343.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Aug 2022 17:02:38 +0000
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Seth Forshee <sforshee@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue,  9 Aug 2022 12:39:57 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.setgid.v6.0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/426b4ca2d6a5ab51f6b6175d06e4f8ddea434cdf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
