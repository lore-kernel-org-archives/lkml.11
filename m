Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E36C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Mar 2022 19:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236540AbiC0Tf1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Mar 2022 15:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbiC0TfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 15:35:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761BE64E5
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 12:33:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2BB14B80DB8
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 19:33:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DC8C1C340EC;
        Sun, 27 Mar 2022 19:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648409622;
        bh=uRLYQZUXcSMkQFV3XFE75HhH7pvdu7sNPWs4xlpxV5M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ltCJ3gaTiQ6dcbAlvjFigHMAHbiGuXJtfEE6sHYWcCvRONwDbrP3tr2cAlcGAJ0Yq
         IYwWKioHFNB/NbPTFV4k8OwTBMq2/LGIn/RHDMdmoZLNEC0sYYkLa9xpor6OIGMDxN
         BUn46qu51npitNMxQoxc0izGGcgsTIYvdBRJRVA/1jTaMCIaQFN5L3v4NHAiqQ31wp
         Pdv/JaFL6AjnUTioIbWdSw1w2MxdPMoXMt3PGmOauAa9Li78phiyMc4NslDELeaH5o
         gFSovKPr6XvDUgsYTIVnBGVsbOJKIKC2a8l39+8Xe2/JOs0Ck6wjXK3gPMOe2EevxZ
         URFKR5CJaMyYQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C7419E6BBCA;
        Sun, 27 Mar 2022 19:33:42 +0000 (UTC)
Subject: Re: [GIT PULL] OpenRISC updates for 5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YkASeMlP+k/OJm3+@antec>
References: <YkASeMlP+k/OJm3+@antec>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YkASeMlP+k/OJm3+@antec>
X-PR-Tracked-Remote: git@github.com:openrisc/linux.git tags/for-linus
X-PR-Tracked-Commit-Id: 862cf8d5fd98ed8ea8989726ed5da53761a9ed76
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 88b3be5c6391a5b4be1dcdc4bb8dca8438105438
Message-Id: <164840962280.6575.12850786353069820369.pr-tracker-bot@kernel.org>
Date:   Sun, 27 Mar 2022 19:33:42 +0000
To:     Stafford Horne <shorne@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 27 Mar 2022 16:30:00 +0900:

> git@github.com:openrisc/linux.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/88b3be5c6391a5b4be1dcdc4bb8dca8438105438

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
