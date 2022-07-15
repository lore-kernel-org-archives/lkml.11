Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF437C43334
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jul 2022 17:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbiGORpl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jul 2022 13:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbiGORpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 13:45:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BBE31DF8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 10:45:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 181BA622CF
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 17:45:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7CA1BC3411E;
        Fri, 15 Jul 2022 17:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657907130;
        bh=CuTRal5okKM9j1PFVlEKp6GRIJx0+aW1oFToCDlirE4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=YS95odb9Gm6sQMPobEJDXqQ1Ec45D6d8AetChy0kggbNuLRQw7aAeHWSoxrbm6aSX
         DeJ20CbmWgXH/yz9ZU3WxQBkSXWigVaeXz55wZ1J8K0evHEpLZBlIuSHy4K/8qv+N6
         q6UM7k7DSrIvv38oWpwD0sSbPiOCd0NmZ1VNZO7FrqJCZCAM6q3Dn/pK5sTMvRta0f
         Pw2ScaPf3X6SFYzde0cmIqlFE7HlOcG1M10v2PasVABytL0/7U3Ru/jUMAhTDfisHF
         stvWQKx9gLtY9mh5nb9CwO15zuOLwSykBbEfy6eaEA5S2sPI97E/u8+mU+3QvQJuFN
         HV0UPokVb7RzA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6A0FCE4522F;
        Fri, 15 Jul 2022 17:45:30 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 5.19-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twM75GDM9t+9-CSCPDZG3QdcEpQ-X+FzQ4CLUCM7cKLkw@mail.gmail.com>
References: <CAPM=9twM75GDM9t+9-CSCPDZG3QdcEpQ-X+FzQ4CLUCM7cKLkw@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9twM75GDM9t+9-CSCPDZG3QdcEpQ-X+FzQ4CLUCM7cKLkw@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-07-15
X-PR-Tracked-Commit-Id: 093f8d8f10aa22935bc8bf7100700f714ebaba9c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fcd1b2b9c7b085e9c200f73c079b322eb8c666f9
Message-Id: <165790713042.27298.9446072286219150279.pr-tracker-bot@kernel.org>
Date:   Fri, 15 Jul 2022 17:45:30 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 15 Jul 2022 13:36:17 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-07-15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fcd1b2b9c7b085e9c200f73c079b322eb8c666f9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
