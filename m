Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EA8C38145
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Sep 2022 17:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbiICRhU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Sep 2022 13:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbiICRhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 13:37:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BDC52DD2;
        Sat,  3 Sep 2022 10:37:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07AD860BA3;
        Sat,  3 Sep 2022 17:37:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 682B9C433C1;
        Sat,  3 Sep 2022 17:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662226627;
        bh=m6WohAShk7KIdbjJFBHGlpyQaW+gPanAx6yMOvu71z8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bATeTWuzDd1NS7NIW1AG8uuHccCeEvK5VO93XJc816pbERgQumQ4fuFMFt+xR6HNe
         0moA+0IDnj4AfH+jG04sFpNoSho8I8FtcGNUwF0aQADaurjR1c2fvTSeVy7ohQ7QNN
         DsPjcJXTB4NQamrYiVrJcA01DthUuqF2GvreBMnRZxe6hUAvGR011Xb3kgCc8DlUtw
         xlz+7jZl0ppPTbtBMo8feo1cLVO0F1LmdXwniJrQG6kBlSBQ8fyCpnqE1SI7wTRgeK
         snV03xcf9dt7KzQIH46wLy6woKglZ3QsQ35Eq5eqV6TIupAHwPQUspTWcAJCuzG+bt
         baiK64nQcPM6Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 55A87C4166E;
        Sat,  3 Sep 2022 17:37:07 +0000 (UTC)
Subject: Re: [GIT PULL] clk fixes for v6.0-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220903050126.2767493-1-sboyd@kernel.org>
References: <20220903050126.2767493-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220903050126.2767493-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus
X-PR-Tracked-Commit-Id: abb5f3f4b1f5f0ad50eb067a00051d3587dec9fb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9a61442cba0e93de5e505b9f43d04d1afa6f18c1
Message-Id: <166222662734.30432.488222497781379159.pr-tracker-bot@kernel.org>
Date:   Sat, 03 Sep 2022 17:37:07 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  2 Sep 2022 22:01:25 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9a61442cba0e93de5e505b9f43d04d1afa6f18c1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
