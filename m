Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94A5C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 29 May 2022 18:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbiE2SvX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 May 2022 14:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbiE2SvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 14:51:19 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB3528E0B;
        Sun, 29 May 2022 11:51:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 87EE1CE0DF1;
        Sun, 29 May 2022 18:51:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB394C385A9;
        Sun, 29 May 2022 18:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653850276;
        bh=1W2QR5slwjM54lWd3JxpPDDcF5bE8LkPayXeoi6wpQ8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uFh+xmPpIkIJMKh2HrZ0DlaH9GSFguqTJKa/kNx0P8teuom9dVsEHH4hkjYTaOyrp
         I09T8JKGKDlxRPMm8a2TepBAPfbDGT9cG9nPlIxptXe+lVc7rRMCPd4tKVeaJrgONF
         1JxMrtSe44d0QQpQDuS6oSHseBHWTJB521itc8zZ5GIwHJNW4ybHBntV9/Jm+d8Ldd
         dMa8yLdU/ByVtiGCaLPo6ab5aQNGmjf2FxBLBjViY40oHf++NpVj9jfKc3Jjz3dFv0
         hcVxTue+RkUPg9iOx9ugotfegDsbLZiDukRnOIHe1bOOUAUNiXtL2AzZKCV/TDGUc3
         e//leLNhRYh+Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D2DCAEAC081;
        Sun, 29 May 2022 18:51:15 +0000 (UTC)
Subject: Re: [GIT PULL]: dmaengine updates for v5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YpOyb40/g5gIYigF@matsya>
References: <YpOyb40/g5gIYigF@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YpOyb40/g5gIYigF@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-5.19-rc1
X-PR-Tracked-Commit-Id: d1a28597808268b87f156138aad3104aa255e62b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b00ed48bb0a7c295facf9036135a573a5cdbe7de
Message-Id: <165385027585.17731.16445655647576053704.pr-tracker-bot@kernel.org>
Date:   Sun, 29 May 2022 18:51:15 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 29 May 2022 23:20:39 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-5.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b00ed48bb0a7c295facf9036135a573a5cdbe7de

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
