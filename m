Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFE7C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Mar 2022 19:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352744AbiCUTUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Mar 2022 15:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352717AbiCUTUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 15:20:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E38757491
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 12:18:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4289060C3B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 19:18:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA5DBC36AF3;
        Mon, 21 Mar 2022 19:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647890314;
        bh=xo3z0svGX2xUSyvuyadfnP6eJBqqDS5C11iE462Yrvk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UqHE0JcP7pj/xcAk7LVZVZz2lJozRX/wVTVBEEyWWZlHpmO2Y0g2cvh3qTHXQUqe3
         iJGdg9CfMthhcfEMqSDXi2xRD8DSWVtPBp5dsQvMdZ25eL38JILg8qxcdz9WI/xp6N
         Ro3l57I+gHa/hpGcXv6maeNzu3ykaCI22ShDFvin1TTC9++DJZNmDTfeA0QgftmGKu
         bwrQybYzbbXncLO1KyPzTVRK06LBy5oZxpdAu0+MK82nwThJEcgTAp/Qjt3T8/n7MO
         wL9oYJb+SwzdxhyJBrQCGAvUjnSFOZhQNZgj/UQlaV1MSDeVCCWUIlrX7BTsFaXuGv
         tciki7Dpus4Jg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8FCE5E7BB0B;
        Mon, 21 Mar 2022 19:18:34 +0000 (UTC)
Subject: Re: [GIT PULL] x86/sgx for 5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YjhaMTdKv/728zQE@zn.tnic>
References: <YjhaMTdKv/728zQE@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YjhaMTdKv/728zQE@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sgx_for_v5.18_rc1
X-PR-Tracked-Commit-Id: 6170abb21e2380477080b25145da9747ad467d3d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 61e2658e37b3c0c7c82aab84f4cc162e1b90f6ca
Message-Id: <164789031458.24158.12739640983191967218.pr-tracker-bot@kernel.org>
Date:   Mon, 21 Mar 2022 19:18:34 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 21 Mar 2022 11:57:53 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sgx_for_v5.18_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/61e2658e37b3c0c7c82aab84f4cc162e1b90f6ca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
