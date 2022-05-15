Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D024BC433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 15 May 2022 13:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237027AbiEONtP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 May 2022 09:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236999AbiEONtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 09:49:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE07DFFD
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 06:48:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6453160F98
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 13:48:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C8AD4C385B8;
        Sun, 15 May 2022 13:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652622538;
        bh=aW5+pAlE1kjU0PIDU7Y7dEWLQ0ou8Kv5SnQgP3ZNpek=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Hxwcg4MiPUpEVkqhkbVarsrJU0xKmEWrC6DwLX3xS4MtHpD71D38jKQq8pjl1k1G4
         5KaxEo3+46z8H5nlvYnehPjaruDkPeW8LSc9daInYkwWhRXbDK+vYEiO5YavIqnUtk
         oQ1p3VamVJR0+/YbqR98z6vEcmYN2Zx5qMT2txXnANTlo9hCCnXGfofQrsNPnHNk3V
         939OK9KxImffL1MY+fXhffMXX8iKLqCNYRadgUXiiIWZ274Tnvwv8K4Yhy4DVN9oJP
         WCUs1A8jnB6mhA7eNLoakPf1t4SslQoYpTdl/pNnwo0bQ36/+QA0z0g4eDmbRZGPCd
         6MO68wXOgq7EQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B2D01F0389D;
        Sun, 15 May 2022 13:48:58 +0000 (UTC)
Subject: Re: [GIT pull] irq/urgent for v5.18-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <165260667543.920532.17932536291158599837.tglx@xen13>
References: <165260667543.920532.17932536291158599837.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <165260667543.920532.17932536291158599837.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2022-05-15
X-PR-Tracked-Commit-Id: 792ea6a074ae7ea5ab6f1b8b31f76bb0297de66c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fb756280f97788525e898181adfc4feb106c79d3
Message-Id: <165262253872.32598.16854088021937907749.pr-tracker-bot@kernel.org>
Date:   Sun, 15 May 2022 13:48:58 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 15 May 2022 11:25:05 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2022-05-15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fb756280f97788525e898181adfc4feb106c79d3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
