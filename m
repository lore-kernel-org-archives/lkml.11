Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC0AC43334
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jun 2022 18:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbiFLSlH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jun 2022 14:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233759AbiFLSkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 14:40:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD695996B;
        Sun, 12 Jun 2022 11:40:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D485A6101E;
        Sun, 12 Jun 2022 18:40:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 40CC0C341C0;
        Sun, 12 Jun 2022 18:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655059253;
        bh=MqFJVX8VvK4ga4pNeGD9npapbWz4fGTLoCapwW8bcN8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=sI/jFyVNwXaBnLAQlzZIwelvjrS7XySoAEYMpBUHTwlCiedPFwA98hA1GkIkB85XY
         2Acs490ocS8i8V46eABjbri2stMdpOi5uwi/Mp2nSbzOJKfJA4tt41ABuG4IECaztv
         MUiWMytCjibakqjRp7t7yYlAFpbrGAVmiZ6lDKnBPKhUfvGMECXXHR+L36JpFtLOQg
         diFmPyG+DpdEyCZez/ToRhapea8VF0phf6BZALinuBw68PtUX5yaEgqbtU3jnxcv6d
         cryXojaO/Qe2uMBjjuGWURCguNd/I7HZ2Q2QPGKcnezvJJ4MxbZ5iDbBipwKjC2KUm
         7jFGPB6HiCrCw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2DEDBE737ED;
        Sun, 12 Jun 2022 18:40:53 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.19-2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <8c5b557d-7e6b-cbb7-316b-f26c567b08cd@redhat.com>
References: <8c5b557d-7e6b-cbb7-316b-f26c567b08cd@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <8c5b557d-7e6b-cbb7-316b-f26c567b08cd@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.19-2
X-PR-Tracked-Commit-Id: d4fe9cc4ff8656704b58cfd9363d7c3c9d65e519
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 997952851843935024962b51fc36c61b3c2d1ed4
Message-Id: <165505925318.24195.13324827727462255609.pr-tracker-bot@kernel.org>
Date:   Sun, 12 Jun 2022 18:40:53 +0000
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Gross <mgross@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 12 Jun 2022 14:55:41 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.19-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/997952851843935024962b51fc36c61b3c2d1ed4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
