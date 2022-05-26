Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD709C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 26 May 2022 02:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346497AbiEZC7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 May 2022 22:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343801AbiEZC7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 22:59:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07F5BCE9E
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 19:59:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D687618F2
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 02:59:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F1D21C385B8;
        Thu, 26 May 2022 02:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653533962;
        bh=00LMgoPWEFmCnxipynpG3BFblBalQPIF1H2NyYkl7lM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hH088AjP/rh9vOL2vZ+DCoftDkucsJaUBraKBVSRdRz0LT/ptQ085IyfMBLZULkwA
         hTMA8SqkTGtx3a0KHM+cWgV0z1Ovh1+aX/iwMCD0QkEusSIhgNtNGfk6i7/GQhICA8
         s1YKGX0RbTsz3fvu6Q42KaLDD3DQ8zNnxh0L3uXeeVDSQxsAPCsdQ/kbp6bZBd9afD
         jP8E7m5t6Gi1AmDfoI2hb+tg7ZuRdyacj5VrRwp/cgnCfez9wxzgsCYZrx8T8DoOel
         8hNtKMObq6GXICafk3uY2OoGo6XJkW+Y2xvICarnbp58XPe1UqJI0Eney3NHjIy2Hi
         wdOC77lg49k+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DF57DE8DBDA;
        Thu, 26 May 2022 02:59:21 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping updates for Linux 5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yo5t+HAiFg5jaSEt@infradead.org>
References: <Yo5t+HAiFg5jaSEt@infradead.org>
X-PR-Tracked-List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <Yo5t+HAiFg5jaSEt@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.19-2022-05-25
X-PR-Tracked-Commit-Id: 4a37f3dd9a83186cb88d44808ab35b78375082c9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3f306ea2e18568f693f7763d1c2178f349ae8f31
Message-Id: <165353396191.29187.2933220820599232248.pr-tracker-bot@kernel.org>
Date:   Thu, 26 May 2022 02:59:21 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 25 May 2022 19:57:12 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.19-2022-05-25

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3f306ea2e18568f693f7763d1c2178f349ae8f31

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
