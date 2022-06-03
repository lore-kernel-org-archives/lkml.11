Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5014C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jun 2022 18:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347999AbiFCSug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jun 2022 14:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349239AbiFCSuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 14:50:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F23286D4;
        Fri,  3 Jun 2022 11:50:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33E07619D9;
        Fri,  3 Jun 2022 18:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9CE14C36AE5;
        Fri,  3 Jun 2022 18:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654282218;
        bh=m591v3STS7SyfXpP9BlxK4XZiKIq2ToOWCGMX4Uu/BA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oP1Yw4H1THn+/ASQVMz/8EQ0MGa20lsgY3RtBl3fYJ8SGPoV93AY4lZGj/FoCJlMt
         ubvFqc5Z1Zs2kbrrc0nt2cdnRsiLNEhAX7rqCNEffshT7yZ5ic15ulPw79boky+wje
         A9EB5W+Uyf3D1uDRjWTJqho2oXeId2bn8CyiyIxgEbttsEvNcUvMTy506TBU9Qolj8
         cLYv0LiCNk1MiJK9A/s3x0xgCLx5Y22E4TT5ecqvRwrClWWAXiBSqTlNwx2xgxzPQA
         fEfLcmIjiJiDe/Fo0iUXNQ0hvmOQRXRBWInibiPER1pmrhemnZWG+lAaguIsdGWjGo
         Yn75zGL2i05IQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 89124F0394E;
        Fri,  3 Jun 2022 18:50:18 +0000 (UTC)
Subject: Re: [GIT PULL] USB / Thunderbolt driver updates for 5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YpnhBp/nzjpz+Pxr@kroah.com>
References: <YpnhBp/nzjpz+Pxr@kroah.com>
X-PR-Tracked-List-Id: <linux-usb.vger.kernel.org>
X-PR-Tracked-Message-Id: <YpnhBp/nzjpz+Pxr@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.19-rc1
X-PR-Tracked-Commit-Id: 97fa5887cf283bb75ffff5f6b2c0e71794c02400
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 54c2cc79194c961a213c1d375fe3aa4165664cc4
Message-Id: <165428221855.10974.5753214896868680091.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Jun 2022 18:50:18 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 3 Jun 2022 12:23:02 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/54c2cc79194c961a213c1d375fe3aa4165664cc4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
