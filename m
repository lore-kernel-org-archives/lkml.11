Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3A5C00140
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jul 2022 03:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbiG2Dho (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jul 2022 23:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233314AbiG2Dhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 23:37:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00CF7CB40
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 20:37:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A8C6B8264F
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 03:37:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D1BEC433D6;
        Fri, 29 Jul 2022 03:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659065854;
        bh=9mcUUg5lmuACGthaun+7+p+qT7sMOwljbBFVfcsaj+o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dkjcWeaRfHdg3UDbnV/TDsjdjAPiKyXeDcQEf3rYd1lOSBheySxpw+IYn5t+bm3Px
         pE7t5RJreDKPYYAUVmPa6V964ElXyGMePl7HPy+2W2hWrA00dOr09150ez1WcmDEXR
         zgEGB3ZtBZiOYzBt2JzAdzGBn9B6qoA2Tb3jMT3SrexkSzAmk/dfdUrPgErLYH88N3
         BcPkLqiwUSIXKLpNnTklNtbr8ayJmkXstGnW1mclDqJxKUs5rKxUoZqWz3YmPSfrOU
         SbAIAsXsZFR2bMWCFmo3twJ3s5Z4mxYzpAcw84FG+wzyOnesMCIo7T17QS+U+lY6A7
         70/WKIgPA6/lw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 07180C43140;
        Fri, 29 Jul 2022 03:37:34 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 5.19 final
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txsRyEJWjrTsha6wkqcdTM5MmTqRVns5b9eQCaQAwJpNg@mail.gmail.com>
References: <CAPM=9txsRyEJWjrTsha6wkqcdTM5MmTqRVns5b9eQCaQAwJpNg@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9txsRyEJWjrTsha6wkqcdTM5MmTqRVns5b9eQCaQAwJpNg@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-07-29
X-PR-Tracked-Commit-Id: f16a2f593d0095e82e6b7f9d776f869c8ab45952
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6e2c0490769ef8a95b61304389116ccc85c53e12
Message-Id: <165906585402.27318.8863200340585582598.pr-tracker-bot@kernel.org>
Date:   Fri, 29 Jul 2022 03:37:34 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 29 Jul 2022 13:31:03 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-07-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6e2c0490769ef8a95b61304389116ccc85c53e12

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
