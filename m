Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADAAC00140
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Aug 2022 03:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242199AbiHSDNN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Aug 2022 23:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344081AbiHSDMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 23:12:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C59DC0A7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 20:12:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1FE3614AA
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 03:12:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 508A0C433D6;
        Fri, 19 Aug 2022 03:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660878768;
        bh=6yUr6v8bm4pBLzLEkMJytxnMR1BB7X9j8x6aCtKf6y4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=p1VTNwqEiXHU/yBmSRcHCwaP9OykcGk1RAQEmGoBuAZ1b4OiztfdodCD/NjOmtj1x
         grFtlsA50zWheV7JdC6sjuzAvhqV6Yyx7EWcgD4tJpPJEMSH27twYsXLsmSgkkKeVQ
         ZVBD9B2E+X+4PuPLviX1TiU/nE+7TR6RaAF000Wrqrzcy0uUcCgyG9kaeqkEIzqXoo
         8RBT5yby4LzxqjhsY/ZM3Wb2NVj0iHhFKAJ9gK71QKb4kSd5iJ0+SezuBqj/95i05X
         HM2GIZhQ2I12RpBFR7vBzNIenFJ/DGJ8FuzPtAUqFppGyUWvaSNZ+Nf5VUbW/a2NVC
         tJFeR+cbBH86A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3FEE4C4166F;
        Fri, 19 Aug 2022 03:12:48 +0000 (UTC)
Subject: Re: [GIT PULL] rtla: Fixes for 6.0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220818104151.524f3df2@gandalf.local.home>
References: <20220818104151.524f3df2@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220818104151.524f3df2@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-rtla-v6.0
X-PR-Tracked-Commit-Id: 20aec89aac7761e3c096004f5c819aacc86fc542
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0de277d44e5b2c4dc823baf0236864ebb0658191
Message-Id: <166087876825.25117.2549703113534014342.pr-tracker-bot@kernel.org>
Date:   Fri, 19 Aug 2022 03:12:48 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Alexandre Vicenzi <alexandre.vicenzi@suse.com>,
        Ben Hutchings <benh@debian.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 18 Aug 2022 10:41:51 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-rtla-v6.0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0de277d44e5b2c4dc823baf0236864ebb0658191

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
