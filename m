Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958EAC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 May 2022 00:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbiEXAXM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 May 2022 20:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbiEXAWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 20:22:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2A043380
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 17:22:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 149FD615B8
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:22:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7AAF9C36AE3;
        Tue, 24 May 2022 00:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653351770;
        bh=S83RQvO1qfKRPLugUgm+PZlghhpwWbgTM82BUBCaNBk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CkE5gBGNbA37+yplnhLbVG6Ua3av9k4dVz/bK0x36oLpHUdRy0Cq9HXaT4ABTRRcs
         YbHmKCjPyhjUtnAcQsKDQsx4U0IvLD1Ve2lfMtptXsPyA+tmsQZ4zeK7QOEL8d7ywo
         Hffyqaa5oukf/l8ejHdKl/RKcfzhLjSLenEnGjyhB9jqReCUrdO4ONQK9YB+3IzZgg
         8S8t88qW36gvfP7jX09YY8YgixPlOcPIGlGpBImKD6NFeDhZ+jND2io9yPnAqNMG3F
         xvVDb7U0Yb4aE2CTpjriaK5k8qKhCo/FWljq+BiUiVYYBapxXkW9He2bFwdVJ6fDPk
         0tF5I832Qs3KA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 63592F0394A;
        Tue, 24 May 2022 00:22:50 +0000 (UTC)
Subject: Re: [GIT pull] irq/core for 5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <165329268046.3801280.14650675869745686928.tglx@xen13>
References: <165329267741.3801280.534077656528571075.tglx@xen13> <165329268046.3801280.14650675869745686928.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <165329268046.3801280.14650675869745686928.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2022-05-23
X-PR-Tracked-Commit-Id: cdb4913293897dde0df522ed5789ba016f3b9157
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fcfde8a7cf6d5e347ce61d8e5c0aee52926ef8e9
Message-Id: <165335177040.4476.11531963095196714608.pr-tracker-bot@kernel.org>
Date:   Tue, 24 May 2022 00:22:50 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 23 May 2022 10:02:06 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2022-05-23

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fcfde8a7cf6d5e347ce61d8e5c0aee52926ef8e9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
