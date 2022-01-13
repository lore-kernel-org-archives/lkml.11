Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B126AC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jan 2022 00:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiAMApg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jan 2022 19:45:36 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57126 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiAMAp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 19:45:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B53661BC2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 00:45:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F18B4C36AE9;
        Thu, 13 Jan 2022 00:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642034724;
        bh=O68F3Nu2VEdBbj9G5SZBlcgk3FUUK/jllIRq5moEFi8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lywSjBNlmD8Trgad8wMZqS9CzgCufgEAJ7i42zJj5xE+dq5QHwCyh3w4DSwE89Pmu
         hK0hNRvq3Qw/8ajln5lxGMKdNJxI8QcWdQ0auDWmsxk9YEfjfesmONnlN4exShg/du
         SjPl+6m62+/ms8E/GNHDkS8nBeFfWm6dR4HkxeFtN4X3uM0PYv34/jO4pE9tflrM7m
         AJjkB8yRzkuR9+QUhciWEhyjak5vB/LoXuBkn9XtT7Eqff9kbhcBWH5KNEbEtEXjMj
         UozkFiYvt3b/1aiXqrkOKKcyLX/5NJ3u9rlrr5oPtiYFeoemM/nOXFujTP5muP5ty2
         GFDtGZgBHHF7g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DEDF1F60794;
        Thu, 13 Jan 2022 00:45:23 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v5.17-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220112155011.1990-1-jgross@suse.com>
References: <20220112155011.1990-1-jgross@suse.com>
X-PR-Tracked-List-Id: Xen developer discussion <xen-devel.lists.xenproject.org>
X-PR-Tracked-Message-Id: <20220112155011.1990-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.17-rc1-tag
X-PR-Tracked-Commit-Id: 54bb4a91b281e1b21235a4bc175e1293e787c016
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ce990f1de0bc6ff3de43d385e0985efa980fba24
Message-Id: <164203472390.19726.4581721172474922590.pr-tracker-bot@kernel.org>
Date:   Thu, 13 Jan 2022 00:45:23 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 12 Jan 2022 16:50:11 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.17-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ce990f1de0bc6ff3de43d385e0985efa980fba24

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
