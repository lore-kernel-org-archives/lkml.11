Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF58AC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Mar 2022 19:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236015AbiCCTTO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Mar 2022 14:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235984AbiCCTTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 14:19:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB21E02F5
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 11:18:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2713BB826B9
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 19:18:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6B2BC340EF;
        Thu,  3 Mar 2022 19:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646335090;
        bh=IwlmB04s0WyFQcfP/qtAUjFASVA8aPFQTqm5mIbtYCA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hZ7s3mS8iQilVxY3nYRt681k7YTyJogZ+bQ3OZf9Gy+RQT2tD9sWcrunsnPzWgrhl
         MuBECIRZtwGAznfCgvPf95MGqAFKWaQpwFn5oLnSvvj+yvIIcGMqLXxe0TU9Xuds5Z
         F48GDczKo7ob7pHgapB4hK6bcjOmM1oAM7wkd4Z037CRIyznbtHTR1uqSrOjtGrwtv
         5uRyz/6tY91lCU8Hw0diRQelj3Xx/5u+et/97KKqXkxd7/lJiu9HN4Xu13jlZKItg1
         xPJHoMpGLUqiTPjLsgbUnzVV+ulVgkAJ5wVlRs5jxhMjxEPj6eb38Z/1guIWpWWFV9
         fydN/Fl72cuwQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D2993E7BB08;
        Thu,  3 Mar 2022 19:18:10 +0000 (UTC)
Subject: Re: [GIT PULL] auxdisplay for v5.17-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220303121607.GA11312@kernel.org>
References: <20220303121607.GA11312@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220303121607.GA11312@kernel.org>
X-PR-Tracked-Remote: https://github.com/ojeda/linux.git tags/auxdisplay-for-linus-v5.17-rc7
X-PR-Tracked-Commit-Id: 9ed331f8a0fb674f4f06edf05a1687bf755af27b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4d5ae2340dd4f0298e607e0792b0881693657279
Message-Id: <164633509085.14270.16125652413738701559.pr-tracker-bot@kernel.org>
Date:   Thu, 03 Mar 2022 19:18:10 +0000
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Lars Poeschel <poeschel@lemonage.de>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 3 Mar 2022 13:16:07 +0100:

> https://github.com/ojeda/linux.git tags/auxdisplay-for-linus-v5.17-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4d5ae2340dd4f0298e607e0792b0881693657279

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
