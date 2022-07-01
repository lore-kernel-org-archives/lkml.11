Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DBBC433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Jul 2022 18:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbiGASCr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Jul 2022 14:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbiGASCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 14:02:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8993F403E1;
        Fri,  1 Jul 2022 11:02:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17D50614B3;
        Fri,  1 Jul 2022 18:02:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C88CC3411E;
        Fri,  1 Jul 2022 18:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656698560;
        bh=w3KzFyaYEIc284AKOdm/iI5z51t8mxZXiqscMxHjcXI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CQwQKe0DmeF6TKqa0NADm8mgX+v8S248XO7rwEVHzJx3klZZ9BgyyVyuwJUGzqMws
         SOs7uZH8Mkup1+yCraQ6n7KJ3DbjSvrQ8wrMwCI7EfS0b7RBxm2ajEkoq6eSSJV8iL
         npJLKRN8yy4O/OnVhE90Rh3r+DodqvfaeNhvkie54CcgWqGf3cZLim8JW1/6Wr5JlW
         0wFLYo6kMrR9pVfZcDorhypOceeT0yS9ZXhHI3An+HH1kGUqezO5eNWGB5EEMefK55
         imoaer05/emM4TaBfFRLtdl/lHD9CSGQH7HL6rTaGCvnWCL9xQs+ohbIg0oNzq/Wzu
         4JD0Fcb42licA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5AFA0E49BBC;
        Fri,  1 Jul 2022 18:02:40 +0000 (UTC)
Subject: Re: [GIT PULL] clk fixes for v5.19-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220701021413.276395-1-sboyd@kernel.org>
References: <20220701021413.276395-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220701021413.276395-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus
X-PR-Tracked-Commit-Id: a79e69c8714f416bd324952d06d1dd7bce3f35bf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9650910d05a31d62f562f90ca15ece685a4c1b9c
Message-Id: <165669856036.14842.11250001484706715167.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Jul 2022 18:02:40 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 30 Jun 2022 19:14:13 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9650910d05a31d62f562f90ca15ece685a4c1b9c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
