Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FE0ECAAD7
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Aug 2022 19:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbiHZTJk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Aug 2022 15:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343558AbiHZTJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 15:09:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8DDDD74B
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 12:09:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E773F61EDA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 19:09:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 53A4FC43470;
        Fri, 26 Aug 2022 19:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661540965;
        bh=q+4Me8XpP5l2dtCSAqvLCPDCu9ahJZ2IXskzO7Z1Vwk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bcU6jhGfH6XiPe0b4cXKDIclp0eV8YDvjVM/k8igY/3oUU4lZJUdUIIX6lS6eVUbx
         FOByKPadJBlhfqz8AdZK4fAbexE4KbdpUPWFIg82NQyEC5M50dbR1xETcbxud4SrS5
         DoSR29+mJQ/A7AwwPI+1tXP4F7tZ01UXPr8kGGo8F27bIBkNL1I7pJvF9e2joDazB7
         BzyYohrk7hqHBoNh6FOpnH5qSv9dzG4kpPxCemVc7NOB8vDwFHXsPd1xIUX+dql4e+
         o+8PtBr10HJD6pN7DEokl7xls0jBAnwvQ/CxQydqQ+f1HreeTD0uF5eAHvOhPmlhAQ
         CJk4fa6fr4yww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 40599E2A03B;
        Fri, 26 Aug 2022 19:09:25 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 6.0-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-b5674eda-e816-4e5a-aea2-22f8dc6617fd@palmer-mbp2014>
References: <mhng-b5674eda-e816-4e5a-aea2-22f8dc6617fd@palmer-mbp2014>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-b5674eda-e816-4e5a-aea2-22f8dc6617fd@palmer-mbp2014>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.0-rc3
X-PR-Tracked-Commit-Id: 1709c70c31e05e6e87b2ffa0a2b4cc0da4b2c513
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 012bd7e859df9d6aa0a8ab4484c00aeded108071
Message-Id: <166154096526.10698.2507268314030595927.pr-tracker-bot@kernel.org>
Date:   Fri, 26 Aug 2022 19:09:25 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 26 Aug 2022 09:01:28 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.0-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/012bd7e859df9d6aa0a8ab4484c00aeded108071

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
