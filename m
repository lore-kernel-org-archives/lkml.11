Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47DAC433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Apr 2022 16:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234588AbiDQRBv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Apr 2022 13:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234562AbiDQRBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 13:01:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480311C933
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 09:59:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAEE661267
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 16:59:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28678C385A9;
        Sun, 17 Apr 2022 16:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650214742;
        bh=OMZ5d8Wq1kZqQjX804mwaYcHyITy/lMtLY/Hnk8wYy0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BV5pKLxLyGIWky7zHI/Dhxfm+oTDcrXpze85OEhFaWhpFxjPbT3OWrNx7oSa80cs/
         EKqJDSQ7yd9g1ttmv2O+CXzexh3KHV/9VFyz7jFVKD7InZaOeuyOYPV6ttVla/gbX2
         EQ+o7eohX60E7y9xbUIlaEaYYzIckTz2KsixIn8arcL3IfVYZnWtWMcbDnGg1RZgh+
         pj8fdtE0GNEQsk7LYZBMKIF21iE/QKOHpJoE1zRl2/rnoy1eZ8gS0jrKLRMYbaEDWq
         phtmih4qe8a2sfV2yZreZLXZMFiRHqJqQ3auzp00dQ9b8iOIVUZwGaW23INuKTABuv
         ehWywxwUxPFPw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 140F6E85D15;
        Sun, 17 Apr 2022 16:59:02 +0000 (UTC)
Subject: Re: [GIT pull] irq/urgent for v5.18-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <165018953450.44773.6382828227632028472.tglx@xen13>
References: <165018953450.44773.6382828227632028472.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <165018953450.44773.6382828227632028472.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2022-04-17
X-PR-Tracked-Commit-Id: 08d835dff916bfe8f45acc7b92c7af6c4081c8a7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7e1777f5ec178542adf0506e5ba2308f5be862a7
Message-Id: <165021474207.4330.7964302645424137648.pr-tracker-bot@kernel.org>
Date:   Sun, 17 Apr 2022 16:59:02 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 17 Apr 2022 11:59:11 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2022-04-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7e1777f5ec178542adf0506e5ba2308f5be862a7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
