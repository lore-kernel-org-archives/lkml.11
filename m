Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38969C433FE
	for <linux-kernel@archiver.kernel.org>; Fri, 27 May 2022 18:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354521AbiE0StH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 May 2022 14:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354450AbiE0StD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 14:49:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B02B31DD9
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 11:49:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5517AB824FF
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 18:49:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07127C385A9;
        Fri, 27 May 2022 18:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653677339;
        bh=YWpqbqMQogquimpCm1Wld3lZJ07fTWeUkG5fE99NnOs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Zp2eC+yjSNiXxmaV/gqa529+7bpplM6+TuRGweRSfGCTpzN+o5ApXsAuFlfVWqIxM
         bHNwh4N32lY83f9jQMWFYzgomIoWGDzC/+LBwU+DeAou6xS35MfjV2ogfutMgoeQ3X
         QI6C5slVMEVWoF2UYgCcLMuD0O3tT9pSW0vlUvmQ2RRBwo5dypj5sNwdhpdaTmq8Xh
         kUD9Xa4Qrz53j+PvedOn/oBOZ4/zNVRaILVhIakwgvEzEmIl/gvPruk3IaALc9iDan
         SSCYBMYl9nbmESGjth42h/anVNve3Ju3MY4dWW6gkbzrJ/Oz7tuw+NqaH4b+uvDefC
         J6Rrcjg6mz9hg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E7C11EAC081;
        Fri, 27 May 2022 18:48:58 +0000 (UTC)
Subject: Re: [GIT PULL] non-MM updates for 5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220526151437.f0bad876b435dfe494be9203@linux-foundation.org>
References: <20220526151437.f0bad876b435dfe494be9203@linux-foundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220526151437.f0bad876b435dfe494be9203@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-nonmm-stable-2022-05-26
X-PR-Tracked-Commit-Id: 3159d79b56c15068aeb7e4630cd5f6dacd20fda4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6f664045c8688c40ad0591abd6ab89db9ecd7945
Message-Id: <165367733894.12450.12091986345131845306.pr-tracker-bot@kernel.org>
Date:   Fri, 27 May 2022 18:48:58 +0000
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 26 May 2022 15:14:37 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-nonmm-stable-2022-05-26

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6f664045c8688c40ad0591abd6ab89db9ecd7945

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
