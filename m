Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DFBC433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jun 2022 17:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351496AbiFERQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jun 2022 13:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351419AbiFERQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 13:16:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702504EA0C
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 10:16:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23D04B80DB0
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 17:16:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF576C3411D;
        Sun,  5 Jun 2022 17:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654449380;
        bh=gtfTjE2G5QCOXUJN0JF2bESA9NEERHvQCR0TgsXRPo8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KBF3B9RwmP451Q38kpaNMUT2K1X1jmVfMgbWHYCvliLex62UjpQrZoaO2xFmmudBT
         9oTJQnSA47s608ZtAqsSpmIUZcoTiZ9d6PIv3JGLuXmKp4/pFPLHpwfXRQqZumwsNA
         Q1N2CSNjVqqERXBqNCEtq/Lt2lUMUAZNwSadzroC0t4GxLoyS9Rt9ZuX12L0pd+MR8
         4cAf4bYLBWLNKselXX0SzReVG5SJV71lQUFsFwogS9IsM6YQqMtEyxFWomOakGbCYK
         zCHdeL/tdWYt4zl0ygzRLIdZ+7B8HlhHyb6oO/cXcxzP4hAYolNkJ9ajHPLlXFaHA3
         +FWuK4isX4y1g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C00E5F03875;
        Sun,  5 Jun 2022 17:16:20 +0000 (UTC)
Subject: Re: [GIT pull] objtool/urgent for v5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <165442136963.152751.14259048792272164569.tglx@xen13>
References: <165442136963.152751.14259048792272164569.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <165442136963.152751.14259048792272164569.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-urgent-2022-06-05
X-PR-Tracked-Commit-Id: 2028a255f4df3af9e759f01f958d3237f825f256
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 44688ffd111af31984237f0cba05f2e201eac530
Message-Id: <165444938077.7539.7958098958836789558.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Jun 2022 17:16:20 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun,  5 Jun 2022 11:30:50 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-urgent-2022-06-05

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/44688ffd111af31984237f0cba05f2e201eac530

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
