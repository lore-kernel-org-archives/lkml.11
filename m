Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB49C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 May 2022 18:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242785AbiE3S2a (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 May 2022 14:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242669AbiE3S2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 14:28:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72455932D;
        Mon, 30 May 2022 11:28:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42BA160B0A;
        Mon, 30 May 2022 18:28:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9168C3411A;
        Mon, 30 May 2022 18:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653935303;
        bh=tr+sYVcNuaoeDozYf8qrO3FAA8xM27ho9vW0nmXlO3A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gpf0/Eg8Txrqad8wCYWrWPk4vFxoMFU6t/MpjlsAycHFeqCyRIXgCoc/9XzTIo1rP
         3UcgvqS3N54SsAIeq5g8aiPntENguQu08rMi2qBXNi3fGNrhFxqSgZbQJBjrvhUocF
         Mb3Xk2WKR/rvpxPi7kQBMlUpgRA+N6Hm2du2eOQrpnADHZNpbH2jl7VZlfv/mPjXCp
         Lji46ruLMk1wkgVzRZIxvcp/ylbtMX0GQq3z45coQVDkVeKQtkvRdkFrrRAGeZwQCB
         j/mbKMfVaoYqAyBc3AhWG+7LlZVd5yk75ycSWg2nFUj3PiWRE0yX0OLV/XjgN6Y24x
         PxuyU14tJRyKw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 95A6DEAC09C;
        Mon, 30 May 2022 18:28:23 +0000 (UTC)
Subject: Re: [GIT PULL] MIPS changes for v5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220530085713.GA4761@alpha.franken.de>
References: <20220530085713.GA4761@alpha.franken.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220530085713.GA4761@alpha.franken.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips_5.19
X-PR-Tracked-Commit-Id: 7e4fd16b38923028b01d3dbadf4ca973d885c53e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 73d15ba6ba390caed47aa8885811d1cd7b4477f3
Message-Id: <165393530360.32021.153029674865849869.pr-tracker-bot@kernel.org>
Date:   Mon, 30 May 2022 18:28:23 +0000
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     torvalds@linux-foundation.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 May 2022 10:57:13 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips_5.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/73d15ba6ba390caed47aa8885811d1cd7b4477f3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
