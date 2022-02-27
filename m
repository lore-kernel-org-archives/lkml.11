Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDF7C433FE
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Feb 2022 21:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbiB0VXT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Feb 2022 16:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbiB0VXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 16:23:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E08741308
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 13:22:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61B5B61152
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 21:22:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C4FDBC340F3;
        Sun, 27 Feb 2022 21:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645996953;
        bh=qeI4SUv6sb2bQnVEchKRvZDw6ejRVEOF7WoawO5c3uw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MXh2OxPxoErXiXIaewimNRZrUiJVd+5Clgu4ZFmOsVMHuHvl4ezDZbtTbSt7nx4Ah
         59xEBzrJi430UOV+dwYHqbTGycVgx7WIe7a+6EYBQKGCFXGHR7F/Snb5M4FWba63aJ
         jbLxiHIkbZIlFOjlkff/KbYCfikm/mmjRqls5k27oZZTsWzdwBGCTDnfFQHknd4Oo9
         ykgtfSItMz5xjh81P/lggeBXHFgO+OrwkTiWyOPe+Rn8CLZarKkWKKXGDGXecgQii2
         5WCVSbM53eOLSuxAT0Td2dxoaqRp7zNdOLRy8X+WBBaoKxwSXiG2iA6LAbHQivpfpu
         dnrcq9bHOFv+Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AFBA8EAC095;
        Sun, 27 Feb 2022 21:22:33 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fix for Linux 5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yhu+8trQqqmYLid3@infradead.org>
References: <Yhu+8trQqqmYLid3@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yhu+8trQqqmYLid3@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.17-1
X-PR-Tracked-Commit-Id: ddbd89deb7d32b1fbb879f48d68fda1a8ac58e8e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 98f3e84f8df66f1ac9d04b6d8093993c9bfd69e6
Message-Id: <164599695371.31011.11146855339411947265.pr-tracker-bot@kernel.org>
Date:   Sun, 27 Feb 2022 21:22:33 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Halil Pasic <pasic@linux.ibm.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 27 Feb 2022 19:12:02 +0100:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.17-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/98f3e84f8df66f1ac9d04b6d8093993c9bfd69e6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
