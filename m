Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A24C19F2A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Aug 2022 19:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240263AbiHDT1E (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Aug 2022 15:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239275AbiHDT1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 15:27:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EDF6BD5E;
        Thu,  4 Aug 2022 12:27:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 13235B82659;
        Thu,  4 Aug 2022 19:27:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CCB7FC433C1;
        Thu,  4 Aug 2022 19:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659641218;
        bh=UImkFfaQBGRQmT8UhnefXDjxMFPugNlsRPy3cWw56tI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FzIs1orQBEOOnwj6K42r7bRfBEaNhVL9SB3ekWPEOJp+l3wlULT0OnmQ7JTXqxM/L
         c9gpkWWJYX+Lhm7ZlhIi+JCMXN7ll55MsSrgEosCSJjJgzCl48iWoSsOamB/xgZh2C
         FrMfu+qYi397Lur3BftzNYfxdMBqmNxR4dldvYISjjku2ikXKAaDKSEH8X9Qdmmw9T
         01btzu8NB1r5MJdXq2XAKCNZXpIUUqmwzDGoBqe/c6BaGrfLXsjNLBn6i19Wy0Gd/D
         WQyH2ypEurYfBTTDccCY0AmHw+uNC2spE2qAXnYObgbKuWjH4EZ6i1coDLqrjS68ta
         hFkainUUDDbWA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BD1FEC43142;
        Thu,  4 Aug 2022 19:26:58 +0000 (UTC)
Subject: Re: [GIT PULL] USB / Thunderbolt driver changes for 6.0-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YuqB0tl2hjT3x7a4@kroah.com>
References: <YuqB0tl2hjT3x7a4@kroah.com>
X-PR-Tracked-List-Id: <linux-usb.vger.kernel.org>
X-PR-Tracked-Message-Id: <YuqB0tl2hjT3x7a4@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.0-rc1
X-PR-Tracked-Commit-Id: 8288c99fc263bcafc5df5fa8c278b2eb8106364e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9e2e5ea3b28f81512c792f30729edb1db0c21f6a
Message-Id: <165964121876.8981.2001804608464046684.pr-tracker-bot@kernel.org>
Date:   Thu, 04 Aug 2022 19:26:58 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 3 Aug 2022 16:10:26 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.0-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9e2e5ea3b28f81512c792f30729edb1db0c21f6a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
