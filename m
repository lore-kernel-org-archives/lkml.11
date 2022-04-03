Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B57DC433FE
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Apr 2022 20:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376470AbiDCUb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Apr 2022 16:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376458AbiDCUb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 16:31:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48A933893
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 13:30:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 703E460B91
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 20:30:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4EB2C340F2;
        Sun,  3 Apr 2022 20:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649017800;
        bh=l2TlrE4d00wzGx4AP47XC26CUIDmqS2zIcjMMRmYoZ4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Yi05j6QcwndB0PI8PPBI02HH19Xdqu9G/sZjgU5oPt5ljTxtCn/DjXfkv5ZVF+oy/
         9zOnlvSYZ0YfHPRo/B7xbtdHEGo5pYoBm4tg8ASlWb8aDku7Xxa7tt4T5gAT+xVPTD
         QQ9bktgQ1c43v4f0MGSonvKUVdmHwIL/bAlhaG3cOwmg8Vb+b7l/D5NVOTCUEWQQkw
         7FtdGLH7DVrqSMCp/lNBVL3J9USGwIY/UCPQ3FgKanvWGH2cSZ8REPBawYQ9NH9ceI
         negAorY62LNuqXQU+6zjfg8QptgX5aSJN+TSXsYAojebHU6UbojNPbedFcejmYi2E5
         pVnRqoLH6oPNQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BBFD8E7BB0B;
        Sun,  3 Apr 2022 20:30:00 +0000 (UTC)
Subject: Re: [GIT pull] core/urgent for v5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <164897466883.360450.8070511660014503126.tglx@xen13>
References: <164897466883.360450.8070511660014503126.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <164897466883.360450.8070511660014503126.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-2022-04-03
X-PR-Tracked-Commit-Id: 7dd5ad2d3e82fb55229e3fe18e09160878e77e20
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e235f4192f4f5689ac7aa8a7a320fe157f1bb803
Message-Id: <164901780076.22329.168385904607397602.pr-tracker-bot@kernel.org>
Date:   Sun, 03 Apr 2022 20:30:00 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun,  3 Apr 2022 10:44:12 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-2022-04-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e235f4192f4f5689ac7aa8a7a320fe157f1bb803

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
