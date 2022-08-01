Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15890C19F2A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Aug 2022 16:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbiHAQSS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Aug 2022 12:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233826AbiHAQSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 12:18:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42DDB3E77A;
        Mon,  1 Aug 2022 09:18:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0102460EC4;
        Mon,  1 Aug 2022 16:18:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6178EC43141;
        Mon,  1 Aug 2022 16:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659370683;
        bh=wWjfqcOE137rZ0EQDSs/N6nNC29OzFnft1J9qJh4waE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HpWiZmDJDo/fzkAXlAcfhKL0E1CnZgo4yDkzQzxIhIFIO8L6J0F5Y2/21zeVJrkUm
         NPKn7CudVswUuLzKYrkHtJM/U+1e1+QHtdhL4VHMZH1bvtZ9sdJm6u3FJEYCAqYwcI
         pI0/0LYbD+84MXWweQYxbTiw0vnw5QeYc6xu48e1NHUcp6/Vd15bJaYRJe+ui4JyZ4
         oCXlr7Wx7fX5HyZ6d0f7Rt1JakMoHx7gdwphEaHRnTFmPaDUYjEb6b39bXmBCKtuAu
         5UDAfN4VU/2n7RTjLdNL0mk09Ytuf4MI+sSUoACnULWBioOiuTgVQLKlaIK7IEql8g
         47pZPVx7Mmx/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 449FAC43142;
        Mon,  1 Aug 2022 16:18:03 +0000 (UTC)
Subject: Re: [GIT PULL] fs idmapped updates for v5.20/v6.0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220801141942.1525924-1-brauner@kernel.org>
References: <20220801141942.1525924-1-brauner@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220801141942.1525924-1-brauner@kernel.org>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.idmapped.vfsuid.v5.20
X-PR-Tracked-Commit-Id: 77940f0d96cd2ec9fe2125f74f513a7254bcdd7f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 45598fd4e2897306ed5006e6a80b0460c3079bbd
Message-Id: <165937068327.17475.13046184746662688452.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Aug 2022 16:18:03 +0000
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Seth Forshee <sforshee@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon,  1 Aug 2022 16:19:42 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.idmapped.vfsuid.v5.20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/45598fd4e2897306ed5006e6a80b0460c3079bbd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
