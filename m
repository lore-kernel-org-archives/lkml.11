Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74EBC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Feb 2022 01:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236448AbiBYBiJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Feb 2022 20:38:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236482AbiBYBhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 20:37:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEF41A6FBF;
        Thu, 24 Feb 2022 17:37:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A633B82A89;
        Fri, 25 Feb 2022 01:37:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 00AF3C340E9;
        Fri, 25 Feb 2022 01:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645753041;
        bh=v3VYr+U2RZhw96lFP3Eto4AKp4jG70Phcb4lbGJsz/8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ojUT3OODSUuLBCzeSrQK8a3Hl8ErF7gPIwH3QUudeorkwrkINtv9NHXa8leAWf97Y
         QfNa/pAn1ArSQuw3w24BHmZT9Miq/uzm8uIpaDZZij/42TSzUMCeCukLLJVySZBtBF
         Jfkyi44ScgVQvlUTkyDdHt7v2LaUetWm1k7i3Ih5r2s9xnwe3cyH9dY1oz7hFtuZR7
         MVh0SYQgkQnJnd03uCCWpScH3yUqWVMMOIbcaeZkK6Q7mB0DvPIopr8l0guq1k44e6
         C7ZAuuVR12JrYhLv3EWnbmKPNVVvomuAY35ToF0jDwtI0NXUer2eBaDvC7MF58vURJ
         +tVSNkQAXo/uA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E341BE6D453;
        Fri, 25 Feb 2022 01:37:20 +0000 (UTC)
Subject: Re: [GIT PULL] clk fixes for v5.17-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220225010059.1877605-1-sboyd@kernel.org>
References: <20220225010059.1877605-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-clk.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220225010059.1877605-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus
X-PR-Tracked-Commit-Id: 2f0754f27a230fee6e6d753f07585cee03bedfe3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 53ab78cd6d5aba25575a7cfb95729336ba9497d8
Message-Id: <164575304092.32163.4448652725101419025.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Feb 2022 01:37:20 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 24 Feb 2022 17:00:59 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/53ab78cd6d5aba25575a7cfb95729336ba9497d8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
