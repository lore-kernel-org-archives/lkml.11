Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C521BC433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Mar 2022 17:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236229AbiC0Rim (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Mar 2022 13:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236208AbiC0Rij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 13:38:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BFB50063
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 10:36:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C7F361115
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 17:36:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5C7EC340EC;
        Sun, 27 Mar 2022 17:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648402618;
        bh=ZzMfnEms0MAUgCxXcIy9cny/Vs8AQSIi2J78Wi3+s/E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EJx3QjbAiZObXovYJua3rmJPh1GJGWONzr1KCbkkX+V7LEcUmkUdMDJwSUZPMQY6w
         77cURv0kIYi6LDw9n4YSbAYmnJUYssDnQRtXGchK1Yl9DDz/fMefwqka4swMhNFdqr
         wZLCtVO681gr+wWzxPcjTIlVov1Zp4wJz+wKrlFotosJELgOMYKfA5ZhM+x6HjRWSL
         Pk874wqaKIExGK2sjq8CE77y/DwWZ2A+RDr9kT3RECgTg7Ia3aT2+glHNIFl6YyR5o
         Kjoa1cCCSNvNKeEsH/mrdWp87bUW7sRDgUWUmf5ACcgPsKuN9RRmEw9vo6GDeJDFz8
         gczNvRFMmzD0A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A1ECCE6D3DD;
        Sun, 27 Mar 2022 17:36:58 +0000 (UTC)
Subject: Re: [GIT PULL] x86/core for 5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220326152646.GT8939@worktop.programming.kicks-ass.net>
References: <20220326152646.GT8939@worktop.programming.kicks-ass.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220326152646.GT8939@worktop.programming.kicks-ass.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86_core_for_5.18_rc1
X-PR-Tracked-Commit-Id: 3986f65d4f408ce9d0a361e3226a3246a5fb701c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7001052160d172f6de06adeffde24dde9935ece8
Message-Id: <164840261865.18234.11347896670747276781.pr-tracker-bot@kernel.org>
Date:   Sun, 27 Mar 2022 17:36:58 +0000
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com,
        christophe.leroy@csgroup.eu
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 26 Mar 2022 16:26:46 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86_core_for_5.18_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7001052160d172f6de06adeffde24dde9935ece8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
