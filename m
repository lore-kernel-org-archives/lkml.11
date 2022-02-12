Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97134C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Feb 2022 18:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbiBLSYE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Feb 2022 13:24:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiBLSXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 13:23:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D854460061
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 10:23:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81CAF60B2E
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 18:23:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9C33C340EF;
        Sat, 12 Feb 2022 18:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644690196;
        bh=rasUWAlonzLjFtJrq5UHVo7snAhyxGAnb+a0gtb2MSg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FTj3cbFkUPz8bLj/OKPzvSKQz7wl3KO5y6nAKMqxKRbqJ/wyDcICBo6RljbztjFyd
         +JFi1tJNblCzQDV9s2B5xdzVt1dYXAqZikrpU4Amm+dlA6LC37vS7qH43VJj9ZT0lr
         GCMJa1wVRbEomBIreykN+i9HSQ/cYkdskFe4NTmigBqSvBZh819Q+qe02KuEunlUl4
         ssatbdja58BNBMHYFV9ac3xRfHV2oDkL/1OgUWfuFkGnsa+jp9utI6d0ygwHINl/7r
         y8gPqi96OcRi1sioywFBXMDU5hP/pi8GQlJzSSnXQFZygCw5xUsIZs5Ezc5wAZRlrT
         Q0pZjCWI5Z/Hg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D942AE6BB38;
        Sat, 12 Feb 2022 18:23:15 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver fixes for 5.17-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YgeMkKpZpeMO4hNj@kroah.com>
References: <YgeMkKpZpeMO4hNj@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YgeMkKpZpeMO4hNj@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.17-rc4
X-PR-Tracked-Commit-Id: c72ea20503610a4a7ba26c769357d31602769c01
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 080eba785fe10ba21c40bbdd80f2bd5331a28be6
Message-Id: <164469019588.16091.3116471196915685510.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Feb 2022 18:23:15 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 12 Feb 2022 11:31:44 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.17-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/080eba785fe10ba21c40bbdd80f2bd5331a28be6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
