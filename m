Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10EDC32772
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Aug 2022 17:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354733AbiHSRfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Aug 2022 13:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354661AbiHSReu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 13:34:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACC5356E5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 09:53:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9319B6188A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 16:50:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F09E7C433D7;
        Fri, 19 Aug 2022 16:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660927804;
        bh=cSdsWeqdGn8SEt2YjuZktKCzw5+88mf/N/Xl3/Z0VZk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XVHussIvfr70KNvuJZpFfEWjKagUGfrl+c4t4PD06Stknj3D9Sf/8mtyny94EW7P0
         T2yU2D0uSgEImm6POUQHrg710ozlkCSOhusU/4fK7hcJq9BhCW4cGYi7lepi1r7wIt
         Byg9+5/GzHXQ33vOfhALILMj7q0vAaDIyHpvdr9f4ehgBgQ1xeOBSNF/QWVTTxgVgt
         Vg6xmU0cWvqAz+R6Fq+xQlwT1MnIOkQhZp3N+7IDKN+SmNt6KBlI3RYp/U+jAnQdPc
         IkX5vGpgnMa3igsZhOEyWXPpa7Ff7pHbqwSwM/nE/w2yP++Z7yc9ee9WIKfki7UPHx
         Zvst11jXjseSw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CADABE2A050;
        Fri, 19 Aug 2022 16:50:03 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.0-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tx=MmC2wezaYG7m0A71jdL=niFrFhcXxaS8Z5=6Rf88Qg@mail.gmail.com>
References: <CAPM=9tx=MmC2wezaYG7m0A71jdL=niFrFhcXxaS8Z5=6Rf88Qg@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tx=MmC2wezaYG7m0A71jdL=niFrFhcXxaS8Z5=6Rf88Qg@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-08-19
X-PR-Tracked-Commit-Id: b1fb6b87ed55ced458b322ea10cf0d0ab151e01b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: adb67b373a68b6ca4ea9225e248d726f0f5f0f8d
Message-Id: <166092780381.6323.6381660537952761302.pr-tracker-bot@kernel.org>
Date:   Fri, 19 Aug 2022 16:50:03 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 19 Aug 2022 14:05:45 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-08-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/adb67b373a68b6ca4ea9225e248d726f0f5f0f8d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
