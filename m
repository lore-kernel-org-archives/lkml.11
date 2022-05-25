Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEDEC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 25 May 2022 19:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344845AbiEYTkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 May 2022 15:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344805AbiEYTk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 15:40:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34ADA66F8D;
        Wed, 25 May 2022 12:40:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F20BF619EC;
        Wed, 25 May 2022 19:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C35A6C36AE9;
        Wed, 25 May 2022 19:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653507625;
        bh=Wt2lJck2AxcZgLj+yP6AxtmGUEzmVVUjATnsSPocxZo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FJ3LHFUzeYFzKVXWdMRLhk4eTyfFotn7kWs8rVRqoO6Fu/A92cu0PWGwBl25uQ89P
         h8NenlZ+aogeWk++Rnup43WN7RBFE4iv2SYIv2Fn+7xnlA/mDcWZSC0mOx/K1VxV5f
         qHP9lTkdm09e44+3P9VutcnPuaHBgkeInMp/zZJHMll2qvPJnAqAed3/caHEH/x27B
         7KYPceCpOef1VT5sVu/Nv97CambuLzdU8KITUeujNJbjda2WojhgwDWL33RyTrj0EU
         fGuuamW/Mav0DxIINLcRbksO0/2ECT+F24Ek51YJTj1wpsMEMA+bO4f1T1tfmklEhL
         CNcDnzmf8AToQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B0DCBF03943;
        Wed, 25 May 2022 19:40:25 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup changes for v5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yowcc/ZOBIIs2JtZ@slm.duckdns.org>
References: <Yowcc/ZOBIIs2JtZ@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yowcc/ZOBIIs2JtZ@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.19
X-PR-Tracked-Commit-Id: b154a017c92011d8f71ce804583e5f9c3d90bb9a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8b49c4b1b6f6397aca3eaee4c79295b74350b7b4
Message-Id: <165350762571.19106.6893198061463331276.pr-tracker-bot@kernel.org>
Date:   Wed, 25 May 2022 19:40:25 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 23 May 2022 13:44:51 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8b49c4b1b6f6397aca3eaee4c79295b74350b7b4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
