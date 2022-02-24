Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD24C433FE
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Feb 2022 19:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbiBXTS6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Feb 2022 14:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233580AbiBXTSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 14:18:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE25D19A9;
        Thu, 24 Feb 2022 11:18:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9030B828FC;
        Thu, 24 Feb 2022 19:18:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B93DC340F1;
        Thu, 24 Feb 2022 19:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645730299;
        bh=Uf1+jvYu+EI6xA2aQ2uGtpoCztVYh8Jzm3xzArNK6Dk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hvYKf4XPKXWjqyVywpZy+H9bYQUpiayzdkPQf8Yzo+4/HPvDgyvVJ65x/cYptCZ1y
         zsBk+DJL/ydqG1t4MxSncJQC4X1hmGoacCZdWhvwAUMb1Bbx0ofqAlFBSmMPjrZu4s
         ibEaQepn2NO/AfpNazzyFgye2LdGSB7quHqfgyACDwYncgYYkteB5Be+JxnOIVIkRL
         4MISC+AW852AT7PPrR22tuc05ekH06z6lCBWQuFl//9h6t/Sjw60rilHrH0hB3Vawv
         UPOKb/qQszTUTdPK13o5usi/2EhwJOqYx8LKOJ8GvOboEJPIOB0fIJAu0+k2VrVhDc
         9fX7BvTXGZbEw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 79FC3E6D3DE;
        Thu, 24 Feb 2022 19:18:19 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.17-4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <0cacb607-64a1-47de-7cf4-294d89045806@redhat.com>
References: <0cacb607-64a1-47de-7cf4-294d89045806@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <0cacb607-64a1-47de-7cf4-294d89045806@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.17-4
X-PR-Tracked-Commit-Id: 21d90aaee8d5c2a097ef41f1430d97661233ecc6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6c528f34ca367468a5be2f0263a7031c166ad558
Message-Id: <164573029949.2860.13615004105856604474.pr-tracker-bot@kernel.org>
Date:   Thu, 24 Feb 2022 19:18:19 +0000
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Gross <mgross@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 24 Feb 2022 14:54:00 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.17-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6c528f34ca367468a5be2f0263a7031c166ad558

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
