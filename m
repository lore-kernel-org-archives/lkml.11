Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD68C3F6B0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Aug 2022 19:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235468AbiHATzo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Aug 2022 15:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235378AbiHATzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 15:55:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE692AF4
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 12:55:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45E7BB81699
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 19:55:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF4F5C43146;
        Mon,  1 Aug 2022 19:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659383718;
        bh=HlNQ6STAdLdst9D2+fnKH0DUXeZKmFAEulUqB4Tn/u8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jJH1tC7qGc560NqxJjBac1MDO7GkK2F2QLH6dMA2yG3w5RWZcGg3Qfo3RWVE13s7z
         qqM4EKHt7FuIVREafAU6k8ZLgS4jZP66dFcl3JnfnoND2//JIPCJ5LJgqFL1sSx6ly
         rMi11APB8pMVv+RYB/uM+JmTDZkduAKzLumKtTM7GlfkMYe2ge5pu6a4oCoy1qOIid
         TT2FykD1zliuALB3yjv3431CaxRicDmJhLKo3aryRJZ3kisOi1+nwTAAt9KHuXElV7
         M6lJqM4QUNir7NjDy5tfm+mxp56uIp+TcT/Hss44nr97bK63fhvVoGzuzzXkmlIz8X
         aN8qlWFPgOQkw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D4AE9C43140;
        Mon,  1 Aug 2022 19:55:17 +0000 (UTC)
Subject: Re: [GIT pull] timers/core for v6.0-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <165936522118.1709539.13739925223035696779.tglx@xen13.tec.linutronix.de>
References: <165936521992.1709539.10227752058452220355.tglx@xen13.tec.linutronix.de> <165936522118.1709539.13739925223035696779.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <165936522118.1709539.13739925223035696779.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2022-08-01
X-PR-Tracked-Commit-Id: cceeeb6a6d02e7b9a74ddd27a3225013b34174aa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dfea84827f7eb49ca41d837d92ac1cbd5353a742
Message-Id: <165938371786.14399.11901519992541613629.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Aug 2022 19:55:17 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon,  1 Aug 2022 16:48:04 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2022-08-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dfea84827f7eb49ca41d837d92ac1cbd5353a742

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
