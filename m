Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDB3C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Apr 2022 21:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353106AbiDAVrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Apr 2022 17:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353077AbiDAVrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 17:47:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59F010F6DD
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 14:45:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E01161AC7
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 21:45:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 960ECC34112;
        Fri,  1 Apr 2022 21:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648849515;
        bh=qXpc7b+dnomBykoiIuaYy0tmyNQ81SqJXueau5yIcms=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=J73Ng406uvhzvr7P1x61LOL7SkgegSKSyd+LFDzk9MmOPHdZwVjA3/zKVchvOvrj3
         c5hL54ldXgIL0BV62J+v4AVauqrqH+HEom9HiZsYPxRFj4IY+k9X4ZcPXao0Kdrb2G
         pHoN69C1EugmWsRUXdzzmEFJblnNnpAfvWcsmw6XgPMNG6XSnN3WDvkeJ0OBzd0Edi
         xVeO19vIiMy4kgfxQacPRqsMhfhywR3LYstrxRCrwfBUevWnt46tiXVrHet9g2ebZA
         6CUB92rtC0WS5gcqPg7kAEgFaTgTDKefS+sGGzjwiMSLSvcblLpVxRJoCYCX6G478f
         dBGw9Vkc+sT9g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7C4D7F0384A;
        Fri,  1 Apr 2022 21:45:15 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Patches for the 5.18 Merge Window, Part 2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-e0c01ab7-020f-4264-91da-0852f7e89534@palmer-mbp2014>
References: <mhng-e0c01ab7-020f-4264-91da-0852f7e89534@palmer-mbp2014>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-e0c01ab7-020f-4264-91da-0852f7e89534@palmer-mbp2014>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.18-mw1
X-PR-Tracked-Commit-Id: 1464d00b27b2e29a5556f6a4099cf083886e883f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a3dfc532b8731843c12bdc45e804eacc47e51e50
Message-Id: <164884951550.9554.12842077645290708402.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Apr 2022 21:45:15 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 01 Apr 2022 09:41:50 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.18-mw1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a3dfc532b8731843c12bdc45e804eacc47e51e50

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
