Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D84C433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 21 May 2022 05:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354586AbiEUFJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 May 2022 01:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347576AbiEUFJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 01:09:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F294179C12
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 22:09:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E128360B97
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 05:09:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56D84C385A9;
        Sat, 21 May 2022 05:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653109762;
        bh=Y/duMEZQWKwWljVJyfmGYB+GWYEmH4NazXwvgZBADBI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=I/PcQ8xYLL1YSsfjbNM/JqktkWqzwvF74wDLQrZ48wS9gBzljqWB6Jej83P74Dt4u
         IEfmyfVEnhCaDJy9hEsi7YbMzwG+a5hfI80qsDDl2kRWHIpguJ/GItbhZZ9ZpKrlgr
         NydhPoPS41otdhphIcUBHevC3Jydh09b96JUI/6TKnzXYJ9+AFOpD9w71MMSeYjaZR
         vzMWf3cfx/U9NHknWl6454I8O2odLBtf012fmWgcJuI18PIARVc0ZUqVJlqc/YvVC0
         cWOZ1K2gqkWlgLLCORxPVTnNtALbRTYLQgiwliEaUlTFyx4GIlAtiiwZfFuYqyPGYm
         glypLeds8tIJQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 434B1F0392C;
        Sat, 21 May 2022 05:09:22 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 5.18 final
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzncFLvW9htq+=r=BRT=2AiU58MEpvO0JikaBoUy3Kebw@mail.gmail.com>
References: <CAPM=9tzncFLvW9htq+=r=BRT=2AiU58MEpvO0JikaBoUy3Kebw@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tzncFLvW9htq+=r=BRT=2AiU58MEpvO0JikaBoUy3Kebw@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-05-21
X-PR-Tracked-Commit-Id: 64eea6805ecf7092a113bdb4cb73860430d39de6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 93413c849f1fd2ad294320c6eb140b95bf153b8a
Message-Id: <165310976226.23518.16768758842208912431.pr-tracker-bot@kernel.org>
Date:   Sat, 21 May 2022 05:09:22 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 21 May 2022 06:24:38 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-05-21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/93413c849f1fd2ad294320c6eb140b95bf153b8a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
