Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABFFC433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Feb 2022 00:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240377AbiBSA3J (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Feb 2022 19:29:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240367AbiBSA3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 19:29:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9E6B7C4C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 16:28:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2FD461F7E
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 00:28:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19E72C340E9;
        Sat, 19 Feb 2022 00:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645230530;
        bh=L3VRlBv6tAqdgXucgTnsdwiVKKptjWP6+7IbqcZx2Ng=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BgUdikWtguueG9dERfTa1heEckomOgVQfN0ymbMjOInpxk5beNIJFU0g5ehfrHrh9
         ucN43Oiqs5z4MMhfBiCn/pA+Gu/1L4p7QFNeNvE29aRMNE/1FtTKQeMgwGEKKu8Ghl
         lfbHXewNTSAf7j/kMF7I2oFuxzRcnxKCRkTBv+jtDnvGnd7AYbxziEhzakBJRv2PuX
         pFLEIMD9PcFbo4klBjYsZP0Wax7/phZmG5H2P6xtmtG6T+ycbg0OZPnsOMSc1+vrHT
         t+JzmPSAblJ18uR+uElP128wZujonI8mWked1EF+B/82flxl25W11sF/q1a44wbbkV
         EHSW9MXWgsspg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 09BBCE7BB07;
        Sat, 19 Feb 2022 00:28:50 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 5.17-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-f149d1ba-1f6d-43b3-8df0-95d27c2b89c0@palmer-mbp2014>
References: <mhng-f149d1ba-1f6d-43b3-8df0-95d27c2b89c0@palmer-mbp2014>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-f149d1ba-1f6d-43b3-8df0-95d27c2b89c0@palmer-mbp2014>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.17-rc5
X-PR-Tracked-Commit-Id: 5feef64f4c67068c49f5409d43c67cabf2327f66
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 241c32d853a84b9d775f9fd58f1ba91a0a5c9117
Message-Id: <164523053003.25426.2979653564959805148.pr-tracker-bot@kernel.org>
Date:   Sat, 19 Feb 2022 00:28:50 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 18 Feb 2022 09:50:17 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.17-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/241c32d853a84b9d775f9fd58f1ba91a0a5c9117

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
