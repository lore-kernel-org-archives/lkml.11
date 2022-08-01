Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5FFC00144
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Aug 2022 19:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235390AbiHATzi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Aug 2022 15:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235367AbiHATzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 15:55:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35F7EA1
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 12:55:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB6586136E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 19:55:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1CA05C43148;
        Mon,  1 Aug 2022 19:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659383718;
        bh=g2WNLF60TiV3RtvbD2+7OXLKnyi6BwZTNThqAgThPwI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DmIo9h0eEEi1Bt4Buk1dAio7UNHjqD+Mg5L/jwOKiDr/Udoow7PPRLUXCdrKmFz5Z
         cqEI6wSzZmBZzzNeGauFYlMIGZlNlPdCU1mEpqb9G6sGcVCo3UecjVgaZUPGBv5xK7
         VcABuYKCMki+9nDsQLT11ZyhUrvReXBaxv6zCpYGfenc6F2K6TXjJryYTeOxG3eKGi
         iHSgMmo8All9MILH42n1OsclblRl6lfcON/sX3xMCZb3Qli27L3MIbrq6ef+PD+Q0N
         ionG9fTssYEfH2RSAtzyWR5vu+RsYhdPMa7ZPBu2qxw2q7AYkxn32Bk94deGqxgQYV
         4aM1ADELBIYOA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0C5FAC43142;
        Mon,  1 Aug 2022 19:55:18 +0000 (UTC)
Subject: Re: [GIT pull] irq/core for v6.0-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <165936521992.1709539.10227752058452220355.tglx@xen13.tec.linutronix.de>
References: <165936521992.1709539.10227752058452220355.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <165936521992.1709539.10227752058452220355.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2022-08-01
X-PR-Tracked-Commit-Id: 779fda86bdeb86bad6daa4f0ecf37788dfc26f6c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9de1f9c8ca5100a02a2e271bdbde36202e251b4b
Message-Id: <165938371804.14399.6367182258923393547.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Aug 2022 19:55:18 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon,  1 Aug 2022 16:48:03 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2022-08-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9de1f9c8ca5100a02a2e271bdbde36202e251b4b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
