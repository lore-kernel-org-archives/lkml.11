Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A74C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 13 May 2022 23:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiEMXdt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 May 2022 19:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiEMXdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 19:33:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9443172E5
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 16:24:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 691B561776
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 23:24:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C994EC34100;
        Fri, 13 May 2022 23:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652484240;
        bh=/Lm84RWJelOTdP3T+xr4jDgjzowFvn2nQI1gg4nVsks=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nmTHGRGz/zbFfZCJ8I9grLj/UkEUxPcD1mGINh+ezpFevEmw7JZuzRY0LlLyOIumQ
         saFLmhWXrafd4LIYT5aYj59Zu7WzNYSTA7rw2CPhUGa2Mxi4TVAG6/3IB9IILhsvEf
         mGmqiGxQS9b4ELYwhnEIiJ6aZDMxaHXXiQUJZq0U+ko1C0Amn+YT/aN+2f1isYbqoG
         s24VJiSJEYwfnV8OaqF0JB1JoA1EY9PCLUYRD8PUqbalpr4Ru89yrGOMbG6GNikCQs
         vMDDlVSIWp60+SRJ5//4x8thNKEx6FGSg8IvB2laq2oz3Dw9VVLdfxGPTJKA/rP2gp
         /Gp+b70kOTShA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B39FFF0389D;
        Fri, 13 May 2022 23:24:00 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 5.18-rc7 (follow up)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txpYhzyZtd60LEuBYYN+AVyeEQ8=h43bK=ZY8QCQpY5mg@mail.gmail.com>
References: <CAPM=9txpYhzyZtd60LEuBYYN+AVyeEQ8=h43bK=ZY8QCQpY5mg@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9txpYhzyZtd60LEuBYYN+AVyeEQ8=h43bK=ZY8QCQpY5mg@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-05-14
X-PR-Tracked-Commit-Id: eb7bac3973d209e5227d1783676362ee5a8a7127
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ec7f49619d8ee13e108740c82f942cd401b989e9
Message-Id: <165248424072.28273.15365436534682035448.pr-tracker-bot@kernel.org>
Date:   Fri, 13 May 2022 23:24:00 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 14 May 2022 08:56:01 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-05-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ec7f49619d8ee13e108740c82f942cd401b989e9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
