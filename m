Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FC9C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Apr 2022 22:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbiDVW1X (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Apr 2022 18:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbiDVW0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:26:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4797A257CB5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 14:19:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09289B8327F
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 21:19:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0836C385A0;
        Fri, 22 Apr 2022 21:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650662373;
        bh=BTTHkFr4JQtwyE40DjJEQniG8s27DNDr4HkoPfkRKiU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=L7Sj1w4+UiJfjO1SFN3p6FuiSeTVlz+3IipYc4DYpECTXIF/WTvJOPwkH6Q/sLt8Y
         6UmjHsIxl7kWhjLhLoJIzCCeQ5YvrWMAdI+GQqO/M5P0ZVKRAgpdt3Dqh9M40kV+ed
         xPa8NsaqsRB8c0YKi6K1xNk2603B1poyzGkzb9hVfZfAIyQNGIJcqqiNQe4r+3xlmn
         6sZg9hEKBNfXK4rrflsJQI41jTC6PL1nv0Nb4SQgt1NfLW53RUW+4a6SwuyHmM/G+7
         ki+gghjF7SCULwHGlj0SAJjG5y95l8NHPfV6TBE/1MteIBEGV8tx16QqkCCTT/roWe
         MapRH+HoDbCrw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AE337E6D402;
        Fri, 22 Apr 2022 21:19:33 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 5.18-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-650d0eb6-fc62-4859-b713-2a4e6ccd7465@palmer-ri-x1c9>
References: <mhng-650d0eb6-fc62-4859-b713-2a4e6ccd7465@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-650d0eb6-fc62-4859-b713-2a4e6ccd7465@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.18-rc4
X-PR-Tracked-Commit-Id: bf9bac40b7635e2ce43ba0051a64c3fd44312405
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4e339e5e2dbf91e6499ef65389035b2795518c3d
Message-Id: <165066237370.18077.13767875299364762266.pr-tracker-bot@kernel.org>
Date:   Fri, 22 Apr 2022 21:19:33 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 22 Apr 2022 09:02:01 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.18-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4e339e5e2dbf91e6499ef65389035b2795518c3d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
