Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15068C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Apr 2022 18:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350862AbiD1STu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Apr 2022 14:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245277AbiD1STj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 14:19:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441FC3F8B6;
        Thu, 28 Apr 2022 11:16:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8B9CB82F58;
        Thu, 28 Apr 2022 18:16:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 91180C385A9;
        Thu, 28 Apr 2022 18:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651169781;
        bh=8GYl2v23R4RNOKsXXcr4bQ+Kjv3eMYrQMwKAlxHBVTQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PHZTHpy9l9NGFPupuf8T5hOCsNeB645hXPINYIpLiweeuzILFVnk9Ovw7rIMADYMh
         /WZtCLwVv9fPU/fX7XDvtzHX5JsSYbK1pr+0BUaFG3cCYBIdNc/o31VFbSQCqsFRtz
         f1MGqWNWeHbLWcOiMv0W/xx/sMLBd6kBpXDoVWegtJsMun9UpWKriQVBofO1zi/YNb
         +1N06UMC/OlBHp8WGWsAloU4o8pL7r20mdKB6HNoomzjzO3/aWEZtcUW5fGLD7nXW4
         Ab5opqIHDJvm0kBmCuJMoH9FDrIJmVrDNQ97sVMivBdeLQzJk8HD+m24HnjQlbonsl
         uMH+R7E6Nn9kw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 74386E8DD67;
        Thu, 28 Apr 2022 18:16:21 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.18-3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <d6954974-3ee8-9573-f906-c141165cd4b7@redhat.com>
References: <d6954974-3ee8-9573-f906-c141165cd4b7@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <d6954974-3ee8-9573-f906-c141165cd4b7@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.18-3
X-PR-Tracked-Commit-Id: eb2fd9b43fae0c51982ac4229535b6cfd77380db
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 259b897e5a7958e06d1ac30ddd28dc8419e8f328
Message-Id: <165116978147.27414.3199673467686070742.pr-tracker-bot@kernel.org>
Date:   Thu, 28 Apr 2022 18:16:21 +0000
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Gross <mgross@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 28 Apr 2022 14:32:30 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.18-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/259b897e5a7958e06d1ac30ddd28dc8419e8f328

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
