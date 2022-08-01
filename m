Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6341FC00144
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Aug 2022 17:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbiHAR1T (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Aug 2022 13:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232824AbiHAR1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 13:27:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC83B4AB
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 10:27:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FE6961073
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 17:27:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CD030C433C1;
        Mon,  1 Aug 2022 17:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659374827;
        bh=cy1qec1T2w0+x9O074v+b6R9ajog5/ZgsJigFyVJl1Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IA7bqNVcy+XN+PF2CK07kMVBp2/WM0ar3mMOLAAqHOeX50iRQje+GpCtA3UPai9Jj
         RiovlmTZrOXe74/2Wp1LFiySFUgA/3quX+G8XMugyYdhguLvUyV/uV7w9wekxtuq+u
         LlrGZB5ZS0r3iH/xdb+iX0FXvy0L9FIPjARfFbkZBvimV66Qt1Q6Gxj+FTaCGMRJJQ
         CQA2ExQuEvgoLGaaHZFJCf4Ioe4zsEgD7RnCOpdylMVKrbPi3dB1xA/KTuNRYuiWBD
         8QN/6sThrCfXYnuG8lvlv/HzVBLNolyn07Y0huu8esplf1RTuSEQsN8ihlnt/G1sBv
         WjDWa2XngGxhQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BB1BEC43142;
        Mon,  1 Aug 2022 17:27:07 +0000 (UTC)
Subject: Re: [GIT PULL] x86/kdump for v6.0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yufw9vdoONCXEiE7@zn.tnic>
References: <Yufw9vdoONCXEiE7@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yufw9vdoONCXEiE7@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_kdump_for_v6.0_rc1
X-PR-Tracked-Commit-Id: 68b8e9713c8ec90af93c16e1de51cca18cefdb56
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 60ee49fac817754a465a16b837347d1e9b7b090e
Message-Id: <165937482776.24126.14689544629828519898.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Aug 2022 17:27:07 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Aug 2022 17:27:50 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_kdump_for_v6.0_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/60ee49fac817754a465a16b837347d1e9b7b090e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
