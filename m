Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443D1C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 May 2022 22:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242628AbiEXW2Q (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 May 2022 18:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242610AbiEXW1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 18:27:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96F74C789
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 15:27:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61179B81BF8
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 22:27:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31341C34115;
        Tue, 24 May 2022 22:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653431267;
        bh=pbDYhFQSU3SsJ5cW/QcSAkSFVMIWD39ITm6muS9bOcs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Z79fp+cXeHetw0DHG6U78iAd/Y/A493CokrpO8Mar7KRHRmfoQa+puj8r5Psdmvib
         oPU+hbr2+07F/JjijMiLJgWQLmZhaow9hKLGPvRpnz/rJCzFwq32QbXY4X6vD3nuJT
         9Mtp2hrw3YoHtS6L36+GgrT3PYeZ6Opc+0i+he9C2MEEHgTklgnZvRLqwJsO4gq/8p
         +Jr1oREI6NuszdM+scoW5b8ks8cIjR11/902L3hEAU/SxVxvJsyUpCrqKvmfaWfNHI
         V9gatvYaOyogxobSkY3ti/wmLRC1WyzXBEsmX/O521IdtNR4aYl5yA5pmKZFHUZuQb
         2VXvImrl5CVsQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1FA49F03942;
        Tue, 24 May 2022 22:27:47 +0000 (UTC)
Subject: Re: [GIT PULL] regmap updates for v5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220523131213.5DF8FC385AA@smtp.kernel.org>
References: <20220523131213.5DF8FC385AA@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220523131213.5DF8FC385AA@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v5.19
X-PR-Tracked-Commit-Id: 5c422f0b970d287efa864b8390a02face404db5d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5d23bb5f25ed9cbf530b99640f4f17f59b79de9e
Message-Id: <165343126712.3997.9207032128689300848.pr-tracker-bot@kernel.org>
Date:   Tue, 24 May 2022 22:27:47 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 23 May 2022 14:11:56 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v5.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5d23bb5f25ed9cbf530b99640f4f17f59b79de9e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
