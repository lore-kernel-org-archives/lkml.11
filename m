Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D417C433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Apr 2022 20:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbiDPUpg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Apr 2022 16:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbiDPUpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 16:45:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F65633A7
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 13:42:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F8D861007
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 20:42:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94782C385A1;
        Sat, 16 Apr 2022 20:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650141777;
        bh=VxkwGfU9iHJE5L0HxycfmYK299/j5zMhv83yEXB65vw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Am15EMsDMN5QTtt3i8Gl2aM2ZkOu05QWzq3H99cK9PGpCL6QVmdDcBizyO/ciR5gy
         DZwoBm+kfcMTOsDPwR9paH2PgvMCp4//8GjjqnHlfioXMSe1EqiREyMhpf84x376c7
         VK7G67vdJa1GsOoC8VIH/JoW/ObNWxIVKt0DtCzYEESF8hsmGN+9cEykTZQArtpuKC
         EBYnvzbl/gD7EibcpKaQ6BQMdBsWruKNIQQ2Qo3YGUipqaUkuS7sVMDB1cM7gmXwy1
         FoZKupJdi6oiuddGy0+6kHnS6NIgO9creSVO7CsIDl5E5EMCI9TqWq16mNTI0tLRQ9
         /8OrOfaDTvJqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 826FBE7399D;
        Sat, 16 Apr 2022 20:42:57 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fixes for Linux 5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YlpaRgHee1NPl2XB@infradead.org>
References: <YlpaRgHee1NPl2XB@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YlpaRgHee1NPl2XB@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.18-2
X-PR-Tracked-Commit-Id: 9e02977bfad006af328add9434c8bffa40e053bb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b00868396dbd23bb6875f4096b6e59e1b17d67de
Message-Id: <165014177752.10681.14946785121575724320.pr-tracker-bot@kernel.org>
Date:   Sat, 16 Apr 2022 20:42:57 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 16 Apr 2022 07:55:18 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.18-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b00868396dbd23bb6875f4096b6e59e1b17d67de

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
