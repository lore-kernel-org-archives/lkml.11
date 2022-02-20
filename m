Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6998DC433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Feb 2022 19:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244618AbiBTTGa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Feb 2022 14:06:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244603AbiBTTGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 14:06:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0A44C7B4;
        Sun, 20 Feb 2022 11:06:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 547BFB80DC0;
        Sun, 20 Feb 2022 19:06:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2807EC340F0;
        Sun, 20 Feb 2022 19:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645383960;
        bh=XK1CaPRJP+TW9kZsyn9kwDrAuHNgVQaFOx5iyW8572I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=f92JjSjuC4DL5s+S1LGMS9qQygIsR5eyZnl8ivVQh3UzmCrLEECoWEkRY6OvkmYN9
         hLlUjQGGZxbhewU6b79egVzxIkbuKIBxx8su+kucjkZJyOr9bjCq57OzcCy6fRyVle
         TJnIYslrwfLq3zPI5hzsJ1YcMXlenLuwcabj1eCnQtse1ooPJp2atFAiy0B8P3Ogcj
         tus/fgp2mRgmM6/zpVIPf67ppR8zsnlhGd65QAZl8CnblNQK19Z6xX7ANs6eb2n+Pt
         7UW7D4d6+AzOzCSbqcBCMNctqBQCvc443nQL1SPoPgQ2Sb5akSvsxwkfqzhGthbHyy
         AcF8JrIgY2OLQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 148D8E7BB0A;
        Sun, 20 Feb 2022 19:06:00 +0000 (UTC)
Subject: Re: [GIT PULL] fs mount_setattr for v5.17-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220219115327.3635609-1-brauner@kernel.org>
References: <20220219115327.3635609-1-brauner@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220219115327.3635609-1-brauner@kernel.org>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.mount_setattr.v5.17-rc4
X-PR-Tracked-Commit-Id: 538f4f022a4612f969d5324ee227403c9f8b1d72
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7f25f0412c9e2be6811e8aedbd10ef795fff85f2
Message-Id: <164538396008.24844.16173704332043691169.pr-tracker-bot@kernel.org>
Date:   Sun, 20 Feb 2022 19:06:00 +0000
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 19 Feb 2022 12:53:29 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.mount_setattr.v5.17-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7f25f0412c9e2be6811e8aedbd10ef795fff85f2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
