Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF09C433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  1 May 2022 17:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352567AbiEARNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 May 2022 13:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352330AbiEARNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 13:13:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AE94D9FC
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 10:09:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3EA360F70
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 17:09:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14D68C385AA;
        Sun,  1 May 2022 17:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651424979;
        bh=HxVMVa9aTyjIg3XB0bKCeN8vFJtSEvZsRFiVK6VCAMw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nhreG2Au7ha7aFm0mznke7X4yC5gGNcp/ZAWp3UrezyK2BbTVBShFQEG4ci4dGH6Z
         rKyBdHHfQlKsO4Sp6xdsjIs6uz5z9cp0N4Jz9PbaM3zrcOMqkkvX+WtSis64C0hLM2
         hVQGwi0uUih6G+5Cg+evVA3C2PY5mAGrRodt082LJGWlaliNrGe1m7W2rk3NjX6RaN
         wxCa+Z0fTFAIqS+LwnB53BDR3zWXze5UiXPuUxZowBfOvQKECc4bdQMoeTE8Hn4OV8
         VAz7sDSPevAOFv7py/gtKYcrglvgGmFHeafqSdngRCGZySKzJzCk3UCLm5PB+mhdUp
         rCN0kSBH7j+fA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 01DA1E85D90;
        Sun,  1 May 2022 17:09:39 +0000 (UTC)
Subject: Re: [GIT PULL] irq/urgent for 5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Ym5vDU6KFdzYaTAo@zn.tnic>
References: <Ym5vDU6KFdzYaTAo@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Ym5vDU6KFdzYaTAo@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v5.18_rc5
X-PR-Tracked-Commit-Id: c7d2f89fea26c84d5accc55d9976dd7e5305e63a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d4af0c17235fbf992f5023bbfb84303e082e45a6
Message-Id: <165142497900.30448.4836161885725858269.pr-tracker-bot@kernel.org>
Date:   Sun, 01 May 2022 17:09:39 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 1 May 2022 13:29:17 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v5.18_rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d4af0c17235fbf992f5023bbfb84303e082e45a6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
