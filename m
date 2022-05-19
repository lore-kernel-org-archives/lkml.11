Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93181C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 May 2022 16:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241951AbiESQOd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 May 2022 12:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241874AbiESQOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 12:14:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FA4BC6F6;
        Thu, 19 May 2022 09:14:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3AA461C4A;
        Thu, 19 May 2022 16:14:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3097CC385AA;
        Thu, 19 May 2022 16:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652976869;
        bh=G58ptIjn2GJ1aun6Kx0042yWFtBKi+hQ+ndMF+DadbA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MYqB6HJV5sDK5aDLjvOcrhLcCe++NNqmpyL6jIfz1BqX4vgjPo3wAq4xdc0h4M75J
         hEnaDygvwNvhZX2+omCCK6vqXYhExoKuQ80+8KRtsjHfcFdV0c79dzna4D0RpFo2OV
         GU+Y7YhVQXCWSp+blpjWzlkMrOyvvK4AHrYvR9gtDChWMeQVc9gNfB3/rTNWLSEMEl
         MvuCL4A8+1Drmj9DpWG0kgHwhQ/MB75diB+oPyp2KNFg7LcPKyL5lt5ldt6tEgQ8WM
         LGNqhqMxhGbdu/0MzeRTgEXWjFV7UvvZ0uw933uxxnUf0PGrqp3BcAflz0vUUI7Qdp
         tXzG6LKDjsUjA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1D671F0389D;
        Thu, 19 May 2022 16:14:29 +0000 (UTC)
Subject: Re: [GIT PULL] parisc architecture cache flush fixes for v5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YoZkpODq/SGRunJC@p100>
References: <YoZkpODq/SGRunJC@p100>
X-PR-Tracked-List-Id: <linux-parisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <YoZkpODq/SGRunJC@p100>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.18/parisc-4
X-PR-Tracked-Commit-Id: 798082be69fea995a475ca1db8f9873589e207d9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b015dcd62b86d298829990f8261d5d154b8d7af5
Message-Id: <165297686911.7702.14789683282223115092.pr-tracker-bot@kernel.org>
Date:   Thu, 19 May 2022 16:14:29 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 19 May 2022 17:39:16 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.18/parisc-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b015dcd62b86d298829990f8261d5d154b8d7af5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
