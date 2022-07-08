Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAB4C43334
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Jul 2022 23:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238377AbiGHXRh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Jul 2022 19:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237068AbiGHXRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 19:17:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1A122B2E;
        Fri,  8 Jul 2022 16:17:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98D10B82A18;
        Fri,  8 Jul 2022 23:17:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4B415C341C0;
        Fri,  8 Jul 2022 23:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657322252;
        bh=B+2TKIgb0kymI4gIoHFlRXXuiSc4mxiGgxCK/sB3R1A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WbhihxDG+Qxgup006C2dG9JmAeZb6a0ru29GLxN2eAvvLcH9v+I9785oriGcmASem
         4SLLEOx8VZHNGhhbdg5uAfK/1wgQ6NXmkXJGHcHvxA/sXB5sTYJ/yUWqQZokG+HC1/
         Y2htKRANoQztFRa/pkM9s/vLTht6B9f3R9/nB+T4yn8rVUijA5ZlvrDek6qDbGQ13m
         LshF/vIJXK3KEnLcOvCk+NFUVyB6m9aDoF2A+p9o4HOBGLA0kdXid85t7fWRPfF9fA
         byjsjx7PcJzYKd9hChpQHkX6XaHoNpa2qwhLpPxohS3WsUMN06rc+qfwZrrjnUJQF9
         M/rvT2hW9Rnkw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 35996E45BDB;
        Fri,  8 Jul 2022 23:17:32 +0000 (UTC)
Subject: Re: [GIT PULL] fscache: Miscellaneous fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <3753787.1657315951@warthog.procyon.org.uk>
References: <3753787.1657315951@warthog.procyon.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <3753787.1657315951@warthog.procyon.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/fscache-fixes-20220708
X-PR-Tracked-Commit-Id: 85e4ea1049c70fb99de5c6057e835d151fb647da
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e5524c2a1fc4002a52e16236659e779767617a4f
Message-Id: <165732225221.30799.13034712144647468572.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Jul 2022 23:17:32 +0000
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        jlayton@kernel.org, Yue Hu <huyue2@coolpad.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Jia Zhu <zhujia.zj@bytedance.com>,
        Max Kellermann <mk@cm4all.com>, linux-cachefs@redhat.com,
        linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 08 Jul 2022 22:32:31 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/fscache-fixes-20220708

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e5524c2a1fc4002a52e16236659e779767617a4f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
