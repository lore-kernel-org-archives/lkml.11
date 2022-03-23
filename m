Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07B3C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Mar 2022 19:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344248AbiCWT1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Mar 2022 15:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344210AbiCWT1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 15:27:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147404EA01
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 12:26:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A293F61595
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 19:26:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F024C340F6;
        Wed, 23 Mar 2022 19:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648063562;
        bh=OU8yIYs0YFSiT/ETa9tDxApZodNZdBczzs42i/CLfOI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cjD7UeCsl6nkDPLdpVNZ9Wy4KC0o6LREUhKVsEfQtyt54DjL+Koyj6Zym/FAFVPpi
         CfNxbAA8JrITeGtkPdwNS//xeJ4CxuVMLIGbwVoSFRrPld/9BdIqEyPgoJyG0gIPVG
         6oYnX4YbZvIhemSMfz/LIQEPo09di4FGu/lQNfhuIs+QG38bLx6i/ya5KtnZZDQAOf
         TZLDI1Isj80Hf1DtlemqmmWZO/VFHcTZoSv4HGkqkrApTSJFjJpjVxWG/6nwEW0JNn
         uCD5DG4Gt6W1aX9onQVH4jlU7J+yWATY1/HJKU7ta3b8uCfIU/kUTdZbtQ6q3Ki1rj
         Nieydzs0lYaPQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ED64DEAC081;
        Wed, 23 Mar 2022 19:26:01 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Updates for 5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220321105621.3d4a9bc6@gandalf.local.home>
References: <20220321105621.3d4a9bc6@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220321105621.3d4a9bc6@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.18
X-PR-Tracked-Commit-Id: 795301d3c28996219d555023ac6863401b6076bc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1bc191051dca28fa6d20fd1dc34a1903e7d4fb62
Message-Id: <164806356196.7379.9221178121995818415.pr-tracker-bot@kernel.org>
Date:   Wed, 23 Mar 2022 19:26:01 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 21 Mar 2022 10:56:21 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1bc191051dca28fa6d20fd1dc34a1903e7d4fb62

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
