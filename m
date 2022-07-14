Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF01AC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jul 2022 20:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240894AbiGNUmo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jul 2022 16:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240865AbiGNUmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 16:42:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F94854C9B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 13:42:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91B5B60C17
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 20:42:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED096C34114;
        Thu, 14 Jul 2022 20:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657831354;
        bh=F3n8P90icfC9993ShPHuypWR7iLxPcQuxDC5KAAQVD4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FicGBYTsnw1Btd4e02EYWj26dJF3Z5G/t83pX5vEwCPE4zeQT7QNdt9TrSyT/HpJj
         Q3Pm0YlwCExD7bgrhZ80X6dv6RN6V6riJEIalfFZHTgth/op7JyQuWmahUIvCG6tWI
         QG6g4fhK0jvtGrd/+KAmu3vJiJeZZBOwtnVwIFUmcNzcrPVh7o49/tHzpp5dMsNDVG
         bCcdQb65VC61+x95Dnf99sx92uuDktgmMU9zA5l1jBz5Zsf/aEJ16d6m/4zERkNcj4
         KlNQu7F32szuqz17Zx4a3wOIo1i3VnMBQ29PkX+XzTSriSJIh7VEmvcyUr/spxXyOm
         Rq+ROFIvJbVNg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DA523E45225;
        Thu, 14 Jul 2022 20:42:33 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 5.19-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <871quoxful.wl-tiwai@suse.de>
References: <871quoxful.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <871quoxful.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.19-rc7
X-PR-Tracked-Commit-Id: 9b043a8f386485c74c0f8eea2c287d5bdbdf3279
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c4634a3c7dcabed7321304efc00b5a81559adeca
Message-Id: <165783135389.13350.14150346691064570698.pr-tracker-bot@kernel.org>
Date:   Thu, 14 Jul 2022 20:42:33 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 14 Jul 2022 10:23:30 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.19-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c4634a3c7dcabed7321304efc00b5a81559adeca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
