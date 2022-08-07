Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6E7C19F2D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Aug 2022 00:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234859AbiHGAuc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Aug 2022 20:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234670AbiHGAuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 20:50:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FE31B5
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 17:50:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8B0A60CF6
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 00:50:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B755C43145;
        Sun,  7 Aug 2022 00:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659833411;
        bh=cyFbp8kho4+x5GDmNakt1HGmpgmG75XbijtUk+Q3BO0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GF/WUG9MBnuz7gFXos+etswZbiuSW211yO6+B7WW6spk816Vh5MDmBGAyXdBtNqwh
         ReLLEUS5q9QTPwF8VJjRmOUpohAZvung5jtJjaYIZH8Xx/2hqiP8ZcpVfwXZqIbsCH
         /pJnxgC4yt5iEntl2fpGTjYAgpnVABjhxK1/L4Kj3rpTnMqVsUHdmc3PyT+rs6jxqn
         JeBCBJ9Seema6ivqFcxtWrYovlrTUzW2U/Hww8AHlfFz/KfYH6+oKle0dopTUIJyUM
         8Gv2nbV3mH8sWbO+UJ4qUbOa9IEvt/ywJ1fDyrVfy09rtjiyBtCj3LuetADdjUB8/r
         sCz2hhFxuD9Ug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 51A00C43140;
        Sun,  7 Aug 2022 00:50:11 +0000 (UTC)
Subject: Re: [GIT PULL] scheduler fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yu6/KNcTRFCHIcW2@gmail.com>
References: <Yu6/KNcTRFCHIcW2@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yu6/KNcTRFCHIcW2@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2022-08-06
X-PR-Tracked-Commit-Id: 751d4cbc43879229dbc124afefe240b70fd29a85
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cac03ac368fabff0122853de2422d4e17a32de08
Message-Id: <165983341132.27609.16551357344045127933.pr-tracker-bot@kernel.org>
Date:   Sun, 07 Aug 2022 00:50:11 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 6 Aug 2022 21:21:12 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2022-08-06

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cac03ac368fabff0122853de2422d4e17a32de08

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
