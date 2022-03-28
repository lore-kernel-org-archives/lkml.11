Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB85EC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Mar 2022 22:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiC1WPg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Mar 2022 18:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiC1WPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 18:15:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E12313E24
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 15:06:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD3146152F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 22:06:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3BE73C340ED;
        Mon, 28 Mar 2022 22:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648505172;
        bh=XDHX0WEgIa8e+llG90tklr+k0N0LpRWXlKeNqm0bbEU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TeNnPH4UEOMYXIrwHAbji1EWj84BWiNJMk2Www5A8o6YKyAuhDzaY5Kad2ugzJ0C3
         3pF+vUIMCD26jVj6t99ADaSxHFF2Nx61pb4pT7t3xiPvRCR1u3+TtZxJb7gvACq+Uh
         0lTX4lLIOy/2I5zOEBie5wJQ5XHSlGw/Rybi3wB6+9d2YL3g19bIDicya1ODHmqDdC
         y79K0QAPS07zkKpHryVWrWQXiwfN1hjy0SLePalZiujnYKIHDzbQPyRD/wfdySWv/m
         F9i7Z0pDQYHAj/iAmggTIj1JCVM5hM9e1ph+mezt3H2zsy5W6StnZdqLyspwhOHYWH
         DNNuJyRMIEj8Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2986CEAC081;
        Mon, 28 Mar 2022 22:06:12 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220328092544.14418-1-jgross@suse.com>
References: <20220328092544.14418-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220328092544.14418-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.18-rc1-tag
X-PR-Tracked-Commit-Id: de2ae403b4c0e79a3410e63bc448542fbb9f9bfc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a701f370b521b2ed0654a9da7cf424b3ff8fa73d
Message-Id: <164850517216.27348.18317093563343238542.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Mar 2022 22:06:12 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Mar 2022 11:25:44 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.18-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a701f370b521b2ed0654a9da7cf424b3ff8fa73d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
