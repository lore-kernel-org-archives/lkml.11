Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B090C433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Apr 2022 20:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376466AbiDCUb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Apr 2022 16:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376453AbiDCUbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 16:31:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CB933884;
        Sun,  3 Apr 2022 13:29:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12675B80D9F;
        Sun,  3 Apr 2022 20:29:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ACD8DC340F2;
        Sun,  3 Apr 2022 20:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649017796;
        bh=0hK4HXo/3S6Y4aP5LPDRKT/TbXSlch0JfT0hI1hVRBs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ih0CsbZIcUbqZdjJAg6Ec675lDXLxoxpCewK2riM+UNQX7KzjztBUp5WENQvxKLyC
         fRgXuQuZbkl1egIsoSRHR2duO4T2LiMS2m7QytrBYZnLPZQ2kb853v3XqXlzGrJxh6
         iBfZNqM6cfHsbzMM8JR9TluDiRk1rJiJliOCWbcmXQMqVffZvdMkL3XVE+XugNN8o3
         VD6IFkaTd60gb3elAz13WRs79mezdbr8p29+AVHv/JgKpmjJq8rhTRV8u13ZaG3/9P
         LIaZu8DtTfHUEwe098rIi04wNk1DWFvqIh8l3xOHeI2RDpb1L0llc2IMXJ3JiQYYs1
         YtUg8+EwXzcCA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 99250E6BBCA;
        Sun,  3 Apr 2022 20:29:56 +0000 (UTC)
Subject: Re: [GIT PULL] one more clk change for the merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220403140959.113778-1-sboyd@kernel.org>
References: <20220403140959.113778-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-clk.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220403140959.113778-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus
X-PR-Tracked-Commit-Id: 859c2c7b1d0623a6f523f970043db85ce0e5aa60
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 34a53ff911eb30629baad788fbed892f711bdd3e
Message-Id: <164901779662.22329.11478011777146283017.pr-tracker-bot@kernel.org>
Date:   Sun, 03 Apr 2022 20:29:56 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun,  3 Apr 2022 07:09:59 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/34a53ff911eb30629baad788fbed892f711bdd3e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
