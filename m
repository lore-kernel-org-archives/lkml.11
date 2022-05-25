Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92189C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 May 2022 02:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243795AbiEYCQn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 May 2022 22:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243768AbiEYCQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 22:16:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12EC2DEC4;
        Tue, 24 May 2022 19:16:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1C15614FB;
        Wed, 25 May 2022 02:16:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0E780C34113;
        Wed, 25 May 2022 02:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653444993;
        bh=bYHB/xju0L2PR3zo/l8lQ4BL/b26SzgTj4nuzRM8Lv4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Vh7uB8I+tNp0z6Rwiw5ITzjU+eR77LIMcCPWKtj7KV73dBn3+vI5wBdoS2+G35MJh
         eg0vXS6wr88a5D+BqrGoTiaxAdbd3wuwW4GXEYYtlFOvwml3/2eQkQtBzaIRxldJh8
         6OHCyQkPmoJ1qKjM3QeHjZAmKLnvpqQBXu0ZHuKDWnylZ8qk1f9GKCHHjWTMg933CB
         qp+X4dA7iRIuh7ZBqME9kr398jdHkw5z1Q8xPPN5ii++BHH7hKx1FH1QGYKi3HLK/S
         dAr1SaV+xNaZw4v7U5UfxN/aqaXaTBls0Hx8l8jpCf7akj3+lZNH70S3C+cZvkxxsR
         ADMr/2jRYAFKw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E54B0F03939;
        Wed, 25 May 2022 02:16:32 +0000 (UTC)
Subject: Re: [GIT PULL] fs idmapped mount updates for v5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220523093835.1096673-1-brauner@kernel.org>
References: <20220523093835.1096673-1-brauner@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220523093835.1096673-1-brauner@kernel.org>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.idmapped.v5.19
X-PR-Tracked-Commit-Id: e1bbcd277a53e08d619ffeec56c5c9287f2bf42f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f30fabe78acb31cd309f2fdfdb0be54df4cad68f
Message-Id: <165344499293.22339.607379080295689703.pr-tracker-bot@kernel.org>
Date:   Wed, 25 May 2022 02:16:32 +0000
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 23 May 2022 11:38:36 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.idmapped.v5.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f30fabe78acb31cd309f2fdfdb0be54df4cad68f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
