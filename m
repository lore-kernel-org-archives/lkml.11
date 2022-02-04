Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09815C4332F
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Feb 2022 20:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239885AbiBDUem (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Feb 2022 15:34:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238501AbiBDUek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 15:34:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353EDC061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 12:34:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E012BB83883
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 20:34:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 717F9C340ED;
        Fri,  4 Feb 2022 20:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644006877;
        bh=6JwJ6tsccvHMF9copb7bHgjNK6VMkj2Rv75xBiejVjU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kvA3X2iGKtsD1DXajuNP0PNaSHZxgsXBDyEw2fB7tLDpH7a3PdWR1+uNeVj17Qrjb
         x/gpRE5s58Bl7ssq/MyGxTKRLdPnVNAT+TTyHK1V3Pra3LXXlC4kO6Ap3OahpJS3oM
         azaGNU3JDOux4i85iMRJGsKvrkSCSWvfhAPa5APn7JC8CwaiCB/vA/N1/mOJLcOvNI
         SHS7kYMFZcpxq82hbQHHnqmZPVzX8ZhuBhDnQiUkdKpWq5LaO6vAt27vatnRBAFz0C
         IMptA9VeDQe7JgG4wX1dQJ83wgV7A0FKrFHlzyzLIdya4QTyD653PfC9EYsA9nNYIk
         aJjkZzWLHiu3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 60F25C6D4EA;
        Fri,  4 Feb 2022 20:34:37 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v5.17-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yf1LITyFpv5yAUNJ@8bytes.org>
References: <Yf1LITyFpv5yAUNJ@8bytes.org>
X-PR-Tracked-List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <Yf1LITyFpv5yAUNJ@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.17-rc2
X-PR-Tracked-Commit-Id: 9b45a7738eec52bf0f5d8d3d54e822962781c5f2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 07cd9ac4c54039c99f98d30e83e23040e330fad5
Message-Id: <164400687739.31755.350959112073263932.pr-tracker-bot@kernel.org>
Date:   Fri, 04 Feb 2022 20:34:37 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 4 Feb 2022 16:49:53 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.17-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/07cd9ac4c54039c99f98d30e83e23040e330fad5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
