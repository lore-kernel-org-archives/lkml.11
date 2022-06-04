Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB7EC43334
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jun 2022 00:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349764AbiFDAGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jun 2022 20:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbiFDAGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 20:06:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A8D4F9ED;
        Fri,  3 Jun 2022 17:06:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3732B60B49;
        Sat,  4 Jun 2022 00:06:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E983C385A9;
        Sat,  4 Jun 2022 00:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654301160;
        bh=bB/7Qg/ZWdTRZBizAQW+tLeYFyUrjLlJ+g9oiaJnNPQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rF4ikw/L2wjG3Aa8eLURpCFcpl9uqcsY7m6zMeF+ead3CbyZH9+R0DCTpO5lsmawc
         +SCIlyAZ+nG4+zLOaqjaVXzvV+op0CcTOrUuxfiSyeQK+4XBwdgq82heNSGY8MjduU
         AFDpNO0aVaMrPkodlCbRBLadr444fhAIo+id3qGzKSYqEKkYUQVxtDmbjO/wY9+gMm
         Y+c1xrK89GVQMWKi5qM3X1O3HRYgw3y14EEXE6rlpotDIH82J9WUDRWBmKV+twivcR
         wFTbtumYFZphBH7x2Nk57Ptb+ZVMupbS7rbnTrMROdog4InFPH6ANtossUkWIj5ua2
         Cnjgpyv2OkOvg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8AA20F03950;
        Sat,  4 Jun 2022 00:06:00 +0000 (UTC)
Subject: Re: [GIT PULL] ntfs3: bugfixes for 5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <c5c16f3d-c8a7-96b0-4fd6-056c4159fcef@paragon-software.com>
References: <c5c16f3d-c8a7-96b0-4fd6-056c4159fcef@paragon-software.com>
X-PR-Tracked-List-Id: <ntfs3.lists.linux.dev>
X-PR-Tracked-Message-Id: <c5c16f3d-c8a7-96b0-4fd6-056c4159fcef@paragon-software.com>
X-PR-Tracked-Remote: https://github.com/Paragon-Software-Group/linux-ntfs3.git ntfs3_for_5.19
X-PR-Tracked-Commit-Id: 724bbe49c5e427cb077357d72d240a649f2e4054
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1f952675835bfe18d6ae494a5581724d68c52352
Message-Id: <165430116055.8653.4989553009324938778.pr-tracker-bot@kernel.org>
Date:   Sat, 04 Jun 2022 00:06:00 +0000
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     torvalds@linux-foundation.org, ntfs3@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 3 Jun 2022 14:26:57 +0300:

> https://github.com/Paragon-Software-Group/linux-ntfs3.git ntfs3_for_5.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1f952675835bfe18d6ae494a5581724d68c52352

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
