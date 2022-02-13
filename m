Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECCEC433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Feb 2022 18:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237744AbiBMSEe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Feb 2022 13:04:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237699AbiBMSE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 13:04:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A3D5B890
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 10:04:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01251B80B4D
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 18:04:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B8EBBC340F0;
        Sun, 13 Feb 2022 18:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644775458;
        bh=iBYlMuNl93ZJtaOeKZChWZju0ljA1IxKcHumhsT48I8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WhjyYbJhkHTpRo2eiKEfdMraaNSp0xsQVg2ERVI9pY/8JJOgh/jL29qw6gSkzcmXN
         DQpslMplTRjrupNfZLTcMErbDP5KVDDb6JUu4F7GLgVKUfFbeQ/X5dEz1D/86BnvW5
         72YtibPj213uSPe5v7nupD7LQbYp4qBUqKCmOT8pl5mi3iqlUbHJzxHwM+ReeQM+rx
         WnCZefMXAq7xSZijNSWIVUFB1i1bzux0EMozWGWxv/JsPi/Mo5ReMs5UMcXcr7Rm2D
         viE0up+Z2v5Td9CHsy0Au/ZD4u8YG54qSrJ/sSdq0puUCNi7InE9zoCuJWOSsdfupg
         ndTNvJFM8rB2Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A4E7AE5D084;
        Sun, 13 Feb 2022 18:04:18 +0000 (UTC)
Subject: Re: [GIT PULL] perf/urgent for 5.17-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Ygj51dBiTt3KCCzK@zn.tnic>
References: <Ygj51dBiTt3KCCzK@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Ygj51dBiTt3KCCzK@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v5.17_rc4
X-PR-Tracked-Commit-Id: 5f4e5ce638e6a490b976ade4a40017b40abb2da0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f5e02656b19fa4e38180a08faadd631858a02877
Message-Id: <164477545867.17492.2246559045813938372.pr-tracker-bot@kernel.org>
Date:   Sun, 13 Feb 2022 18:04:18 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 13 Feb 2022 13:30:13 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v5.17_rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f5e02656b19fa4e38180a08faadd631858a02877

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
