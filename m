Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9769FC00140
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Aug 2022 17:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241584AbiHERmY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Aug 2022 13:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241177AbiHERmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 13:42:22 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9A0DFDD;
        Fri,  5 Aug 2022 10:42:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2F845CE29CA;
        Fri,  5 Aug 2022 17:42:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77398C433C1;
        Fri,  5 Aug 2022 17:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659721338;
        bh=i6nScADu6/2HLKRgXWKrEE/j2Qu9ddLXBk1yHwDeXQo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JtKf1sKKZKdc3DdE6IIXnIWO94x7ew/RvUPVdispiK8xp9ci0tZPsXftW3Q771YJT
         vKTO4ySgyCHuNZ+J/x0Gh4EblL5+61F9D6LJo0bWp4Q8cIwb6qlPxdSZCF9nJHpY2F
         5GDu7BsFAgHX8YHiFeR1nLp121ZeVStTlUAqoFrwdSn7RAXv7813zBdCwzOYUvPSLp
         gOT0RVJxoc4If1TZWbsW5f/aXNHakEcQKeXFDzwCTeT1WexPpmDQLYiDXImRzwIDaa
         YKrIsoft3zy2pxQMzvaYEqctI9gP1rj4+3mj1hloxsFJqUBv5+9xwpB+eRb5VbW9Zh
         ZfE09ukeiKzIA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 66EE5C43142;
        Fri,  5 Aug 2022 17:42:18 +0000 (UTC)
Subject: Re: [GIT PULL] parisc architecture fixes and updates for v5.20-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yu09gjA99eDcPNFM@p100>
References: <Yu09gjA99eDcPNFM@p100>
X-PR-Tracked-List-Id: <linux-parisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yu09gjA99eDcPNFM@p100>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.20/parisc-1
X-PR-Tracked-Commit-Id: e61b3125a4f036b3c6b87ffd656fc1ab00440ae9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8db4a0291b09be667ba72584e1aeb7aaf8b497bd
Message-Id: <165972133841.14838.8058552966396009637.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Aug 2022 17:42:18 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 5 Aug 2022 17:55:46 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.20/parisc-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8db4a0291b09be667ba72584e1aeb7aaf8b497bd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
