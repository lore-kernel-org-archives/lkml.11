Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D2DC25B0E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Aug 2022 19:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237091AbiHPTVX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Aug 2022 15:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237046AbiHPTVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 15:21:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1C08284F
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 12:21:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DBE76147D
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 19:21:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BEFCEC433D6;
        Tue, 16 Aug 2022 19:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660677676;
        bh=DVjDZViIiSyshh5qO8Il3ydK/D0qSnEq7cNGsPIiiFY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OvsviNjd0+z6L/rgsERoLmNzcL5DycRkYUbjYakGoF4vRxRwxlPmeXRnNIx8ZmrCV
         o/eStx9uHJuP7zJ+2Hf3dSbbZbdTfaC6y4ssOI3OvVckU45fl2wJwFizR0h+/Py7h7
         lbmwVYdxPICMUTVsQAwxwp9ivvLH+UWFUhBYcFyzVQXQN4wT45Nf4HQSzylojWfWPx
         CewoDCx5L7/Cfh4FlRonpENXi08/9VNz6TI3PFZMVR2GdwjPS8NBaoAZ1R+JnzFV/W
         aQ0T/K1hry3Qf7drivUuteE6/xceCfg9l0DBgneY9I13xWq+K+REWiPvcbx0iDjpFR
         k/tSULg6OIQ1A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A1E0AE2A04D;
        Tue, 16 Aug 2022 19:21:16 +0000 (UTC)
Subject: Re: [GIT PULL] NIOS2: fixes for v6.0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220816144539.371752-1-dinguyen@kernel.org>
References: <20220816144539.371752-1-dinguyen@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220816144539.371752-1-dinguyen@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/nios2_fixes_v6.0
X-PR-Tracked-Commit-Id: fd0c153daad135d0ec1a53c5dbe6936a724d6ae1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3cc40a443a04d52b0c95255dce264068b01e9bfe
Message-Id: <166067767665.31662.18039185456400996060.pr-tracker-bot@kernel.org>
Date:   Tue, 16 Aug 2022 19:21:16 +0000
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     torvalds@linux-foundation.org, dinguyen@kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 16 Aug 2022 09:45:39 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/nios2_fixes_v6.0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3cc40a443a04d52b0c95255dce264068b01e9bfe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
