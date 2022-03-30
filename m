Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FD7C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Mar 2022 18:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350457AbiC3SW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Mar 2022 14:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350314AbiC3SWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 14:22:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA2745AC3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 11:20:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1748060F84
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 18:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D20D4C340F2;
        Wed, 30 Mar 2022 18:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648664414;
        bh=TqUtCGbVl7S3CC2RwlX8WMCuZ1lYrt6u3ONUTwoDxV8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FCkNm9fKiJ53bODuMehtfTcriMFXehN0WIYUO0KWD6UqPKUX/u9wdrtvD0x+ghB5m
         5GwJ1nbZQTJJoQ+JTLMYcyUj6iZHWepmCGEQK8NOSCPuTV18vO2vqBDi3plSYtLjq/
         M9W5fV/Q+ZewbA2qGlWLzlk67Tv8d44LxI/eU7PPlcT50aGK3a/jgAW2A0QzhwoQy8
         1NKNXWVkJDlbK46dl0Lk+lhoelQEhpqwxIq87i7YcQDWXhDi55Tghl+z8TIPENmR5t
         enbsB2K7jwDEEISK/kxwy9jYKj7eQBVVF9TSRyX2Xut2YiL7lWHV+UcsGQb8GzCX2o
         DwpNyIc5IWgXA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B9229F03849;
        Wed, 30 Mar 2022 18:20:14 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220330115736.03D86C340EE@smtp.kernel.org>
References: <20220330115736.03D86C340EE@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220330115736.03D86C340EE@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.18
X-PR-Tracked-Commit-Id: aefe5fc3000a24869edbf7bb657adf28372ec158
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4f3730117f162b17147795eaad44421cc65178c7
Message-Id: <164866441475.5472.13042695329571080357.pr-tracker-bot@kernel.org>
Date:   Wed, 30 Mar 2022 18:20:14 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 30 Mar 2022 12:57:21 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4f3730117f162b17147795eaad44421cc65178c7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
