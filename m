Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DE7C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Mar 2022 20:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344891AbiC1Uav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Mar 2022 16:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345789AbiC1UaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:30:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D9CDFD5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 13:28:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72648613F5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 20:28:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DBB93C34100;
        Mon, 28 Mar 2022 20:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648499323;
        bh=hDzmwoBWJcvalozbJMYdgMflfBRp1M4sn/NRKZZi5R0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VES4+2A2G+gsCyvIn36bCmoqlN4ihnanxhue2saW+9OotPbifL8FRweh0rlHvGC5Z
         9ocI7m/JzKv9qsORr3IKMQWpbAm76hDyt4t5f5ik/0RQmGBSYEB0j3mYeF2x4jYins
         iQT5iADU1Qu0mNOVD0UhIJcQSIQdoKz3nX/bcuFwHHnb4m4aOKKOgWnmsoiWbIVzdD
         OYCyIdmbqtcj1p1lNcdledAZoI23S+133UY5rokIJ5ymF1qHh0uO2Y9T7RVrFyUec0
         nXwLJ5aOc1TqAcnxXj1rbNz/v4T3hkFmzDOFJrf+hM9wVBO5/+RxtT7lLANWJhbqp0
         I+sRZ/dGTJxGg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C98D5E7BB0B;
        Mon, 28 Mar 2022 20:28:43 +0000 (UTC)
Subject: Re: [GIT PULL] Driver core changes for 5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YkG6qJsnjjzF0iFD@kroah.com>
References: <YkG6qJsnjjzF0iFD@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YkG6qJsnjjzF0iFD@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.18-rc1
X-PR-Tracked-Commit-Id: 88d99e870143199ba5bf42701dca06ce1d1388f0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 266d17a8c0d857a579813ad185cd1640b0d6ccac
Message-Id: <164849932382.7875.3535925229119898659.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Mar 2022 20:28:43 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Mar 2022 15:39:52 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/266d17a8c0d857a579813ad185cd1640b0d6ccac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
